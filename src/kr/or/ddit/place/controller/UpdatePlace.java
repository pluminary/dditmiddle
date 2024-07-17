package kr.or.ddit.place.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.place.service.IPlaceService;
import kr.or.ddit.place.service.PlaceServiceImpl;
import kr.or.ddit.place.vo.PlaceVO;

@WebServlet("/place/updateplace.do")
public class UpdatePlace extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // GET 요청을 받으면 해당 시설의 정보를 가져와서 수정 화면에 전달합니다.

        // 요청 파라미터에서 시설 번호 가져오기
        String fcNo = req.getParameter("fcNo");

        // service를 통해 시설 정보 조회
        IPlaceService service = PlaceServiceImpl.getInstance();
        PlaceVO placeVO = service.detailPlace(fcNo);

        // 조회된 시설 정보를 request의 속성으로 설정하여 수정화면으로 전달
        req.setAttribute("place", placeVO);

        // 수정 화면으로 이동
        req.getRequestDispatcher("/views/gymplace/updatePlace.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // POST 요청을 받으면 수정된 데이터를 처리합니다.

        // 클라이언트로부터 전송된 수정된 데이터를 받아옵니다.
        String fcNo = req.getParameter("fcNo");
        String fcAddr = req.getParameter("fcAddr");
        String fcInfo = req.getParameter("fcInfo");

        // 업데이트할 데이터를 VO에 설정합니다.
        PlaceVO updatedPlace = new PlaceVO();
        updatedPlace.setFcNo(fcNo);
        updatedPlace.setFcAddr(fcAddr);
        updatedPlace.setFcInfo(fcInfo);

        // Service를 통해 데이터베이스에 업데이트 요청을 합니다.
        IPlaceService service = PlaceServiceImpl.getInstance();
        

        // 에러 발생 시 처리를 위해 try-catch 문 추가
        try {
            int update = service.updatePlace(updatedPlace);
            System.out.println(update);
            // 업데이트 결과에 따라 적절한 응답을 처리합니다.
            if (update > 0) {
                // 업데이트 성공 시, 상세정보로 이동합니다.
                resp.sendRedirect(req.getContextPath() +"/place/detailPlace.do?fcNo="+fcNo); 
            } 
//            else {
//                // 업데이트 실패 시, 수정창을 다시 띄웁니다.
//                resp.sendRedirect(req.getContextPath() +"/place/updateplace.do"); 
//            }
        } catch (Exception e) {
            // 업데이트 작업 중 예외가 발생한 경우
            // 적절한 에러 처리를 수행하거나 로그를 남기는 등의 작업을 수행할 수 있습니다.
            e.printStackTrace(); // 에러 로그 출력
            // 예외 처리 후 적절한 응답을 클라이언트에게 전달할 수 있습니다.
            resp.sendRedirect(req.getContextPath() + "/error-page.jsp"); // 에러 페이지로 리다이렉트
        }
    }
}
