package kr.or.ddit.mate.vo;

import lombok.Data;

@Data
public class MateMemberVO {
	private int memNo;
	private String memNick;
	private String memName;
	private String memPhone;
	private String joinDate;
	private String levelName;
	private int rnum;
	private String headYn;
	private String jdeleteYn;
}
