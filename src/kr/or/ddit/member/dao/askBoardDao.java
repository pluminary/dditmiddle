package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.askVO;

// 1:1 문의 게시판
public interface askBoardDao {

		
	// 1:1 문의 게시판 상세보기
	askVO detailAsk(int boardNo) throws SQLException;
	
	// 1:1 문의 게시판 전체리스트 가져오기
	List<askVO> getAlldata(Map<String, Object> map) throws SQLException;

	// 1:1문의 게시판에서 검색된 게시물의 수 계산
	int askcountListWithSearch(Map<String, Object> paramMap) throws SQLException;

	// 1:1 문의 게시판 게시물 갯수 가져오기
	int countList(Map<String, Object> paramMap) throws SQLException;


	// 1:1 문의 게시판 게시물 삭제
	void deleteAsk(int boardNo) throws SQLException;
	
	// 1:1 문의 게시판 게시물 수정
	void updateAsk(askVO ask) throws SQLException;
	
	// 1:1 문의 게시판 게시물 등록
	void insertAsk(askVO ask) throws SQLException;
	
	// 1:1 문의 게시판 내가 쓴 게시글만 보기
	List<askVO> getMydata(int memNo) throws SQLException;
	
	// 1:1 문의 게시판 답변후 N -> Y로 바뀌게 하기
	void updateAskAnswer(askVO ask) throws SQLException;
	 

/* ---------------------------관리자영역--------------------------------- */


//	// 게시글 등록
//		public askVO insertAsk(askVO askvo);
//		/* ---------------------------공통--------------------------------- */
//
//		
//		// 1:1 문의 게시물 갯수 가져오기
//		public int countList();	
//		
//		// 1:1 문의 유형가져오기
//		public List<askVO> getAskType();
//
//		// 전체 1:1 문의 가져오기
//		public int getAskCount();
//		
//		// 1:1 문의 전체 리스트 가져오기
//		public List<askVO> getAlldata(Map<String, Object> map);
//		
//		// 검색된 1:1 문의 게시글 갯수 가져오기
//		public int getAskCountBySearch(askVO askvo);
//		
//		// 검색된 1:1 문의 리스트 가져오기
//		public List<askVO> getAskListBySearch(Map<String, Object> map);
//		
//	 
//		/* ---------------------------관리자영역--------------------------------- */

	
	
}
