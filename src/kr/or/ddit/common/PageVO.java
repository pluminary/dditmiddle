package kr.or.ddit.common;


import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // 기본 생성자를 위한 Lombok 어노테이션
public class PageVO {
	private int start;		// 페이지의 시작글번호
	private int end;		// 페이지의 마지막글번호
	private int startPage;	// 시작페이지
	private int endPage;	// 마지막페이지
	private int totalPage;	// 전체페이지
	private int pageNo;		// 현재 페이지 번호
	
	private int count; // 전체 글 개수
	private int perList; // 페이지당 글 개수
	private static int perPage = 5; // 페이지 묶음 개수
	
				  
	public PageVO(int count, int pageNo, int perList) {
		this.pageNo = pageNo;
		this.count = count;
		this.perList = perList;

		// 전체글 수가 0이면?
		if (count == 0) {
			totalPage = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
				// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수(글 개수)
			this.totalPage = count / perList;

			// 나머지가 있다면, 페이지를 1 증가
			if (count % perList > 0) {
				totalPage++;
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = pageNo / perPage * perPage + 1;

			// 현재페이지 % 페이지크기 => 0일 때 보정
			/*
			 * 2 / 3 * 3 + 1 => 1 (o) 6 / 3 * 3 + 1 => 7 (x) => [4]가 되어야하므로 보정 필요 [1][2*][3]
			 * [4][5][6*] [7][8][9]
			 */
			if (pageNo % perPage == 0) {
				startPage -= perPage;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			endPage = startPage + (perPage - 1);

			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPage) {
				endPage = totalPage;
			}
		}
		// 전체 글이 25개일 때
		// end = 전체개수 - (현재페이지번호-1)*글개수
		// 1 => 16~25  25 - 0  (25 - (1-1)*10)
		// 2 => 6~15   25 - 10 (25 - (2-1)*10)
		// 3 -> 1~5    25 - 20 (25 - (3-1)*10)
		
		// 전체 글이 16개일 때
		// 1 => 7~16   15-0
		// 2 => 1~6	   16-10
		
		// 전체 글이 30개일 때
		// 1 => 21~30	(30 - (1-1)*10)
		// 2 => 11~20   (30 - (2-1)*10)
		// 3 => 1~10    (30 - (3-1)*10)
		// 페이지 당 출력할 게시글의 범위(start ~ end) 구하기
		end = count - (pageNo-1)*perList;
		if(end > count) end = count;
		start = end - perList + 1;
		if(start <= 0) start = 1;
	}


}
