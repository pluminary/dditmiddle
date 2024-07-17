package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.NoticeBoardVO;

public interface INoticeBoardDao {
	
	//공지사항 조회
	public List<NoticeBoardVO> getAllNotice(Map<String, Object> map);
	
	//공지사항 상세조회
	public NoticeBoardVO getNoticeDetail(int noticeNo);
	
	//공지사항 글 등록 
	public int insertNotice(NoticeBoardVO noticeBoardVO);
	
	//공지사항 글 수정
	public int updateNotice(NoticeBoardVO noticeBoardVO);
	
	//공지사항 글 삭제
	public int deleteNotice(int noticeNo);
	
	//조회수 증가
	public int hitCount(int noticeNo);
	
	//전체 글 수
	public int getNoticeCount(); 
	
}
