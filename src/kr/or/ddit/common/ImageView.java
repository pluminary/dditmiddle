package kr.or.ddit.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mate.service.IMateBoardService;
import kr.or.ddit.mate.service.MateBoardServiceImpl;
import kr.or.ddit.mate.vo.MBoardFileVO;

@WebServlet("/imageView.do")
public class ImageView extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int fileNo = Integer.parseInt(req.getParameter("fileNo"));
		IMateBoardService service = MateBoardServiceImpl.getInstance();
		MBoardFileVO fileVo = service.getFileDetail(fileNo);
		System.out.println(fileVo);
		String imageFile = fileVo.getCbfileName();
		if (imageFile == null)
			imageFile = "noImage.png";

		String filePath = fileVo.getCbfileSrc();

		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			// 파일 입력용 스트림
			bis = new BufferedInputStream(new FileInputStream(filePath));

			// 출력용 스트림
			bos = new BufferedOutputStream(resp.getOutputStream());

			int data = 0;
			while ((data = bis.read()) != -1) {
				bos.write(data);
			}

			bos.flush();

		} catch (Exception e) {
			System.out.println("입출력 오류 : " + e.getMessage());
		} finally {
			if (bis != null)
				try {
					bis.close();
				} catch (IOException e) {
				}
			if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
				}
		}

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
