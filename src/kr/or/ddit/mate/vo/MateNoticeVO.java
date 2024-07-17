package kr.or.ddit.mate.vo;

import lombok.Data;

@Data
public class MateNoticeVO {
	private int cnoticeNo;
	private String cnoticeTitle;
	private String cnoticeContent;
	private String cnoticeDate;
	private String clubNo;
	private int cnoticeCount;
	private int rnum;
	private String clubName;
	private int memNo;
	
	public MateNoticeVO() {
		// TODO Auto-generated constructor stub
	}
	
	public MateNoticeVO(String cnoticeTitle, String cnoticeContent, String clubNo, int memNo) {
		this.cnoticeTitle = cnoticeTitle;
		this.cnoticeContent = cnoticeContent;
		this.clubNo = clubNo;
		this.memNo = memNo;
	}
	
}
