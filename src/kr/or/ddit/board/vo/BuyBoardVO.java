package kr.or.ddit.board.vo;

import lombok.Data;

@Data
public class BuyBoardVO {	// 장터게시판

	private int boardNo;			// 자유게시판 게시물 번호
	 private String boardTitle; 	// 자유게시판 게시물 제목
	 private String boardContent; 	// 자유게시판 게시물 내용
	 private String boardDate; 	// 자유게시판 게시물 작성일자
	 private int bclassNo; 		// 자유게시판 게시물 분류번호
	 private int memNo; 			// 자유게시판 게시물 작성자 번호
	 private int boardCount; 		// 자유게시판 게시물 조회수
	 private int rnum;
	 private String memNick;
}
