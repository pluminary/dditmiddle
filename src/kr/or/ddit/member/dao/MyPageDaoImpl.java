package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.member.vo.MyPageVO;

public class MyPageDaoImpl extends MyBatisDao implements IMyPageDao {

	private static MyPageDaoImpl dao;
	
	private MyPageDaoImpl() {}
	
	public static IMyPageDao getInstance() {
		if (dao == null) {
			dao = new MyPageDaoImpl();
		}
		return dao;
	}

	@Override
	public List<MyPageVO> boardList(Map<String, Object> map) {
		return selectList("mypage.boardList", map);
	}
	
	@Override
	public int countList(Map<String, Object> paramMap) throws SQLException {
		return selectOne("mypage.countList", paramMap);
	}
}
