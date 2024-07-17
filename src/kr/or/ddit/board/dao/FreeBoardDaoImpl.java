package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.common.MyBatisDao;

public class FreeBoardDaoImpl extends MyBatisDao implements IFreeBoardDao {

    private static FreeBoardDaoImpl dao;

    private FreeBoardDaoImpl() {}

    public static IFreeBoardDao getInstance() {
        if (dao == null) {
            dao = new FreeBoardDaoImpl();
        }
        return dao;
    }
    
    @Override
	public int increaseViewCount(int boardNo) throws SQLException {
		return update("freeboard.increaseViewCount", boardNo);
	}

    @Override
    public int countList(Map<String, Object> paramMap) throws SQLException {
        return selectOne("freeboard.countList", paramMap);
    }

    @Override
    public List<FreeBoardVO> boardList(Map<String, Object> map) throws SQLException {
        return selectList("freeboard.boardList", map);
    }

    @Override
    public void insertBoard(FreeBoardVO board) throws SQLException {
        insert("freeboard.insertBoard", board);
    }

    @Override
    public void updateBoard(FreeBoardVO board) throws SQLException {
        update("freeboard.updateBoard", board);
    }

    @Override
    public void deleteBoard(int boardNo) throws SQLException {
        delete("freeboard.deleteBoard", boardNo);
    }

    @Override
    public FreeBoardVO detailBoard(int boardNo) throws SQLException {
        return selectOne("freeboard.detailBoard", boardNo);
    }
    
    @Override
    public int countListWithSearch(Map<String, Object> paramMap) throws SQLException {
        return selectOne("freeboard.countListWithSearch", paramMap);
    }

}
