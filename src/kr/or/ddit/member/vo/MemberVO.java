package kr.or.ddit.member.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MemberVO {
	private int memNo;
	private String memId;
	private String memPw;
	private String memName;
	private LocalDate memBirth;
	private String memPhone;
	private String memEmail;
	private String memNick;
	private String mDeleteYn;
	private int levelNo;

}
