package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.member.dao.IMyPageDao;
import kr.or.ddit.member.dao.MyPageDaoImpl;
import kr.or.ddit.member.vo.MyPageVO;

public class MyPageServiceImpl implements IMyPageService {
	
	private IMyPageDao dao;
    private static MyPageServiceImpl service; 

    private MyPageServiceImpl() {
        dao = MyPageDaoImpl.getInstance();
    }

    public static IMyPageService getInstance() {
        if (service == null) service = new MyPageServiceImpl();
        return service;
    }

	@Override
	public List<MyPageVO> boardList(Map<String, Object> map) {
		List<MyPageVO> list = null;
        try {
            list = dao.boardList(map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public int countList(Map<String, Object> paramMap) {
		int cnt = 0;
        try {
            cnt = dao.countList(paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cnt;
	}
}
