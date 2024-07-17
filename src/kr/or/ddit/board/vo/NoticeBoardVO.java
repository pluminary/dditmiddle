package kr.or.ddit.board.vo;

import lombok.Data;

@Data
public class NoticeBoardVO {	// 공지 게시판

	private int noticeNo; // 공지 게시물 번호
	private String noticeTitle; // 공지 게시물 제목
	private String noticeContent; // 공지 게시물 내용
	private String noticeDate; // 공지 게시물 작성일자
	private int noticeCount; // 공지 게시판 조회수
	private int adminNo; // 관리자번호
	private int rnum;
}
