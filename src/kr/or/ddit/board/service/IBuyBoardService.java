package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BuyBoardVO;


public interface IBuyBoardService { 

		// 거래장터게시판 게시물 카운트 증가
		public void increaseViewCount(int boardNo);
		
		// 거래장터게시판 게시물 개수 가져오기
		public int countList(Map<String, Object> paramMap);

		// 거래장터게시판 범위별 게시물 조회
		public List<BuyBoardVO> boardList(Map<String, Object> map);
		
		// 거래장터게시판 게시물 등록
		public BuyBoardVO insertBoard(BuyBoardVO board);

		// 거래장터게시판 게시물 상세보기
		public BuyBoardVO detailBoard(int boardNo);

		// 거래장터게시판 게시물 수정
		public void updateBoard(BuyBoardVO board);

		// 거래장터게시판 게시물 삭제
		public void deleteBoard(int boardNo);

		// 거래장터게시판 검색된 게시물의 수 계산
		public int countListWithSearch(Map<String, Object> paramMap);
}
