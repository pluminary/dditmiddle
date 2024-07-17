package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.askVO;

public interface askBoardService {
	
	// 글 등록
	public askVO insertAsk(askVO askvo);
	
	// 글 삭제
	public void deleteAsk(int boardNo);
	
	// 글 수정
	public void updateAsk(askVO ask);
	/* ---------------------------공통--------------------------------- */

	// 1:1 문의 답변
	public void updateAnswer(askVO ask);
		
	// 글 상세보기
	public askVO detailAsk(int boardNo);
	
	// 1:1 문의 게시물 갯수 가져오기
	public int countList(Map<String, Object> paramMap);	
	
	// 1:1 문의 유형가져오기
	public List<askVO> getAskType();

	// 전체 1:1 문의 가져오기
	public int getAskCount();
	
	// 1:1 문의 전체 리스트 가져오기
	public List<askVO> getAlldata(Map<String, Object> map);
	
	// 검색된 1:1 문의 게시글 갯수 가져오기
	public int getAskCountBySearch(Map<String, Object> paramMap);
	
	// 검색된 1:1 문의 리스트 가져오기
	public List<askVO> getAskListBySearch(Map<String, Object> map);
	
	// 내가쓴 1:1 문의 글만 보기
	public List<askVO> getMydata(int memNo);
	
 
	/* ---------------------------관리자영역--------------------------------- */

}
