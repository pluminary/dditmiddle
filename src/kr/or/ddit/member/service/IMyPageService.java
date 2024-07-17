package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MyPageVO;

public interface IMyPageService {
	
	// 나의 동호회 리스트 가져오기
	public List<MyPageVO> boardList(Map<String, Object> map);
	
	// 나의 동호회 게시물 개수 가져오기
	public int countList(Map<String, Object> paramMap);
}
