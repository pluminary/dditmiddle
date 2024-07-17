package kr.or.ddit.place.vo;

import lombok.Data;

@Data
public class PlaceVO {
	private String fcNo;
	private String fcName;
	private String fcAddr;
	private String fcTell;
	private String fcInfo;
	private int medicFcNo;
	private int rnum;
	private String code;	// 종목명
	private String gu;		// 자치구
	private String codeNo;	// 종목 코드
	
	public PlaceVO() {
		// TODO Auto-generated constructor stub
	}
	
	public PlaceVO(String fcName, String code, String gu) {
		this.fcName = fcName;
		this.code = code;
		this.gu = gu;
	}
	
	

}
