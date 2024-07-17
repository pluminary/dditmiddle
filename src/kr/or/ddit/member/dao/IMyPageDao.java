package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MyPageVO;

public interface IMyPageDao {

	// 나의 동호회 리스트 가져오기
	List<MyPageVO> boardList(Map<String, Object> map) throws SQLException;

	// 나의 동호회 게시물 개수 가져오기
	int countList(Map<String, Object> paramMap) throws SQLException;
}
