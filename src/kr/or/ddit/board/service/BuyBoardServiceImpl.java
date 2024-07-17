package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.BuyBoardDaoImpl;
import kr.or.ddit.board.dao.IBuyBoardDao;
import kr.or.ddit.board.vo.BuyBoardVO;
import kr.or.ddit.board.vo.FreeBoardVO;

public class BuyBoardServiceImpl implements IBuyBoardService {
	
	private IBuyBoardDao dao;
	private static BuyBoardServiceImpl service;

	private BuyBoardServiceImpl() {
		dao = BuyBoardDaoImpl.getInstance();
	}

	public static BuyBoardServiceImpl getInstance() {
		if (service == null) service = new BuyBoardServiceImpl();
        return service;
	}
	
	@Override
	public int countListWithSearch(Map<String, Object> paramMap) {
    	int count = 0;
        try {
            count = dao.countListWithSearch(paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    @Override
	public void increaseViewCount(int boardNo) {
    	
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

    @Override
	public List<BuyBoardVO> boardList(Map<String, Object> map) {
    	List<BuyBoardVO> list = null;
        try {
            list = dao.boardList(map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public BuyBoardVO insertBoard(BuyBoardVO board) {
        try {
            dao.insertBoard(board);
            return board; // 혹은 다시 DB에서 조회한 데이터를 반환할 수도 있습니다.
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public BuyBoardVO detailBoard(int boardNo) {
        try {
        	dao.increaseViewCount(boardNo); // 조회수 증가
            return dao.detailBoard(boardNo);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void updateBoard(BuyBoardVO board) {
        try {
            dao.updateBoard(board);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteBoard(int boardNo) {
        try {
            dao.deleteBoard(boardNo);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
