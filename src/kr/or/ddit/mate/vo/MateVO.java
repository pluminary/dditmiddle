package kr.or.ddit.mate.vo;

import lombok.Data;

@Data
public class MateVO {
	private String clubNo;			// 동호회 번호 
	private String clubName;	// 동호회명
	private String clubFarea;	// 주요활동구역
	private String clubAge;		// 연령대
	private String clubFtzone;	// 주활동시간
	private String clubMemo;	// 기타비고란
	private int clubTotalmem;	// 모집인원
	private int clubCurrmem;	// 현인원
	private String clubEndyn;	// 모집마감여부
	private String athlName;	// 종목 이름
	private String athlId;
	private int rnum;
	private boolean liked;      // 찜하기 상태
	private String memNo;       // 회원 번호
	
	private int count; 			// 나의 동호회 찜 게시물 개수
}
