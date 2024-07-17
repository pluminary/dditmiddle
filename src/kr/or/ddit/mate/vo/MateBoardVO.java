package kr.or.ddit.mate.vo;

import lombok.Data;

@Data
public class MateBoardVO {
	private int cbNo;
	private String cbTitle;
	private String cbContent;
	private String cbRegDate;
	private int memNo;
	private String clubNo;
	private int cbCount;
	private String memNick;
	private String clubName;
	private int rnum;
	
	public MateBoardVO() {
		// TODO Auto-generated constructor stub
	}
	
	public MateBoardVO(String cbTitle, String cbContent, int memNo, String clubNo) {
		this.cbTitle = cbTitle;
		this.cbContent = cbContent;
		this.memNo = memNo;
		this.clubNo = clubNo;
	}
	
	
}
