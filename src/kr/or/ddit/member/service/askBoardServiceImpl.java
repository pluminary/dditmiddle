package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.member.dao.askBoardDao;
import kr.or.ddit.member.dao.askBoardDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.askVO;

public class askBoardServiceImpl extends MyBatisDao implements askBoardService {

	private askBoardDao askdao;
	private static askBoardService askService;

	private askBoardServiceImpl() {
		askdao = askBoardDaoImpl.getInstance();
	}

	public static askBoardService getInstance() {
		if (askService == null) {
			askService = new askBoardServiceImpl();
		}
		return askService;
	}

	/* ------------------------------------------------------------ */

	// 목록에 필요한것들
	@Override
	public int countList(Map<String, Object> paramMap) {
		int cnt = 0;
		try {
			cnt = askdao.countList(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cnt;
	}

	@Override
	public List<askVO> getAlldata(Map<String, Object> map) {
		List<askVO> list = null;
		try {
			list = askdao.getAlldata(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/* ------------------------------------------------------------ */

	// 내가 쓴 1:1 문의글만 보기
	@Override
	public List<askVO> getMydata(int memNo) {
		List<askVO> list = null;
		try {
			list = askdao.getMydata(memNo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/* ------------------------------------------------------------ */

	// 목록 상세보기
	@Override
	public askVO detailAsk(int boardNo) {
		try {
			return askdao.detailAsk(boardNo);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/* ------------------------------------------------------------ */

	// 게시글 삭제
	@Override
	public void deleteAsk(int boardNo) {
		try {
			askdao.deleteAsk(boardNo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/* ------------------------------------------------------------ */

	// 게시물 수정
	@Override
	public void updateAsk(askVO ask) {
		try {
			askdao.updateAsk(ask);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateAnswer(askVO ask) {
		try {
			askdao.updateAskAnswer(ask);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/* ------------------------------------------------------------ */

	// 게시물 등록
	@Override
	public askVO insertAsk(askVO askvo) {
		try {
			askdao.insertAsk(askvo);
			return askvo;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	/* ------------------------------------------------------------ */

	@Override
	public List<askVO> getAskType() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getAskCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getAskCountBySearch(Map<String, Object> paramMap) {
		int cnt =0;
		try {
			cnt = askdao.askcountListWithSearch(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public List<askVO> getAskListBySearch(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
