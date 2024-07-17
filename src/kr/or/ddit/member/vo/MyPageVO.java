package kr.or.ddit.member.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MyPageVO {

	 private int rnum;
	 
	 private int joinNo;		// 가입 번호
	 private String headYn;		// 모임장 여부
	 private String jdeleteYn;	// 동호회 탈퇴 여부
	 private int memNo;			// 회원 번호
	 private String clubNo;		// 동호회 번호
	 private String joinDate;	// 가입일
	 
	 private String clubName;	// 동호회 명
	 private String code;		// 종목 이름
	 private String clubFarea; 	// 주활동구역
	 
	 private String clubAge; 	// 연령대
	 private String clubFtzone; // 주활동시간
	 private String clubMemo; 	// 기타비고란
	 private int clubTotalmem;  // 모집인원
	 private int clubCurrmem; 	// 현인원
	 private String clubEndyn; 	// 모집마감여부
	 private String athlName; 	// 종목 이름
	 private boolean liked; 	// 찜하기 상태
	 
	 private String memId;		// 사용자 ID
	 private String memPw;		// 사용자 비밀번호
	 private String memEmail;	// 사용자 이메일
	 
}