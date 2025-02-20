package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BuyBoardVO;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.place.vo.PlaceVO;

public interface IBuyBoardDao {
	
		// 거래장터게시판 조회수 증가
		int increaseViewCount(int boardNo) throws SQLException;
		
		// 거래장터게시판 게시물 개수 가져오기
		int countList(Map<String, Object> paramMap) throws SQLException;
		
		// 전체 거래장터게시판 리스트 가져오기
	    List<BuyBoardVO> boardList(Map<String, Object> map) throws SQLException;
	    
	    // 거래장터게시판 게시물 등록
	    void insertBoard(BuyBoardVO board) throws SQLException;
	    
	    // 거래장터게시판 수정
	    void updateBoard(BuyBoardVO board) throws SQLException;
	    
	    // 거래장터게시판 삭제
	    void deleteBoard(int boardNo) throws SQLException;
	    
	    // 거래장터게시판 상세보기
	    BuyBoardVO detailBoard(int boardNo) throws SQLException;

	    // 거래장터게시판 검색된 게시물의 수 계산
		int countListWithSearch(Map<String, Object> paramMap) throws SQLException;
	
}
