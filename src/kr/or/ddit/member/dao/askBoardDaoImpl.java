package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.askVO;
import kr.or.ddit.util.MyBatisUtil;

public class askBoardDaoImpl extends MyBatisDao implements askBoardDao {

	private static askBoardDao askdao;

	private askBoardDaoImpl() {
	}

	public static askBoardDao getInstance() {
		if (askdao == null) {
			askdao = new askBoardDaoImpl();
		}
		return askdao;
	}

	@Override
	   public int countList(Map<String, Object> paramMap) throws SQLException {
        return selectOne("askboard.countList", paramMap);
    }


	@Override
	public List<askVO> getAlldata(Map<String, Object> map) throws SQLException {
		return selectList("askboard.askList", map);
	}

	@Override
	public int askcountListWithSearch(Map<String, Object> paramMap) throws SQLException {
		return selectOne("askboard.getaskBySearch", paramMap);
	}

	@Override
	public askVO detailAsk(int boardNo) throws SQLException {
		return selectOne("askboard.detailAsk", boardNo);
	}

	@Override
	public void deleteAsk(int boardNo) throws SQLException {
		delete("askboard.deleteAskBoard", boardNo);
	}

	@Override
	public void updateAsk(askVO ask) throws SQLException {
		update("askboard.updateAskBoard", ask);
	}

	@Override
	public void insertAsk(askVO ask) throws SQLException {
		insert("askboard.insertAskBoard", ask);
	}

	@Override
	public List<askVO> getMydata(int memNo) throws SQLException {
		return selectList("askboard.getMydata", memNo);
	}

	@Override
	public void updateAskAnswer(askVO ask) throws SQLException {
		update("askboard.updateAnswer", ask);
	}

	
	


	

}
