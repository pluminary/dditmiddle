package kr.or.ddit.board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.FreeBoardVO;

public interface IFreeBoardService {

	// 자유게시판 게시물 카운트 증가
	public void increaseViewCount(int boardNo);
	
	// 자유게시판 게시물 개수 가져오기
	public int countList(Map<String, Object> paramMap);

	// 자유게시판 게시물 조회
	public List<FreeBoardVO> boardList(Map<String, Object> map);
	
	// 자유게시판 게시물 등록
	public FreeBoardVO insertBoard(FreeBoardVO board);

	// 자유게시판 게시물 상세보기
	public FreeBoardVO detailBoard(int boardNo);

	// 자유게시판 게시물 수정
	public void updateBoard(FreeBoardVO board);

	// 자유게시판 게시물 삭제
	public void deleteBoard(int boardNo);

	// 자유게시판 검색된 게시물의 수 계산
	public int countListWithSearch(Map<String, Object> paramMap);
}