package kr.or.ddit.member.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
// 1:1 문의 게시판 vo
public class askVO {
	private int askNo; // 문의글 번호
	private String askTitle; // 문의글 제목
	private String askContent; // 문의글 내용
	private String askAns; // 문의글 답변
	private String askClass; // 문의글 유형
	private int memNo; // 문의자
	private String memNick;	// 작성자
	private int adminNo; // 관리자
	private LocalDate askDate; // 문의날짜
	private String memId;	// 문의자id
	private int rnum; // 페이징번호
	
	public askVO() {
		// TODO Auto-generated constructor stub
	}
	
	public askVO(String askAnswer, String askClass) {
		this.askAns = askAnswer;
		this.askClass = askClass;
	}



	
	}

	



	

