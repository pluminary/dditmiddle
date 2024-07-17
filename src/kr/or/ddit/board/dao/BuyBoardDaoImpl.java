package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BuyBoardVO;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.common.MyBatisDao;


public class BuyBoardDaoImpl extends MyBatisDao implements IBuyBoardDao{
	
	private static IBuyBoardDao dao;
	
	private BuyBoardDaoImpl() {
		
	}
	
	public static IBuyBoardDao getInstance() {
		if(dao == null) {
			dao = new BuyBoardDaoImpl();
		}
		return dao;
	}

	@Override
	public int increaseViewCount(int boardNo) throws SQLException {
		return update("buyboard.increaseViewCount", boardNo);
	}

    @Override
    public int countList(Map<String, Object> paramMap) throws SQLException {
        return selectOne("buyboard.countList", paramMap);
    }

    @Override
    public List<BuyBoardVO> boardList(Map<String, Object> map) throws SQLException {
        return selectList("buyboard.boardList", map);
    }

    @Override
    public void insertBoard(BuyBoardVO board) throws SQLException {
        insert("buyboard.insertBoard", board);
    }

    @Override
    public void updateBoard(BuyBoardVO board) throws SQLException {
        update("buyboard.updateBoard", board);
    }

    @Override
    public void deleteBoard(int boardNo) throws SQLException {
        delete("buyboard.deleteBoard", boardNo);
    }

    @Override
    public BuyBoardVO detailBoard(int boardNo) throws SQLException {
        return selectOne("buyboard.detailBoard", boardNo);
    }
    
    @Override
    public int countListWithSearch(Map<String, Object> paramMap) throws SQLException {
        return selectOne("buyboard.countListWithSearch", paramMap);
    }
}
