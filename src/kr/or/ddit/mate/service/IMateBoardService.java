package kr.or.ddit.mate.service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import kr.or.ddit.mate.vo.MBoardFileVO;
import kr.or.ddit.mate.vo.MateBoardVO;
import kr.or.ddit.mate.vo.MateMemberVO;
import kr.or.ddit.mate.vo.MateNoticeVO;

public interface IMateBoardService {
	
	// 동호회 회원수 가져오기
	public int getMemberCount(String clubNo);	
	
	// 동호회 회원을 가져오는 메서드
	public List<MateMemberVO> getMateMember(Map<String, Object> map);
	
	///////////////////////////////////////////////////////////////////////

	// 동호회 공지사항 전체개수 가져오기
	public int getNoticeCount(Map<String, Object> map);

	// 동호회 공지사항 가져오기
	public List<MateNoticeVO> getAllNotice(Map<String, Object> map);
	
	// 동호회 공지사항 상세보기
	public MateNoticeVO getDetailNotice(int no);
	
	// 동호회 공지사항 수정
	public int noticeUpdate(MateNoticeVO mv);
	
	// 동호회 공지사항 삭제
	public int noticeDelete(int no);
	
	// 동호회 공지사항 등록
	public int noticeInsert(MateNoticeVO mv);

	// 동호회 공지사항 조회수 증가
	public int noticeIncreaseCount(int no);
	
	////////////////////////////////////////////////////////////////////////
	
	// 동호회 자유게시판 전체개수 가져오기
	public int getBoardCount(Map<String, Object> map);
	
	// 동호회 자유게시판 가져오기
	public List<MateBoardVO> getAllBoard(Map<String, Object> map);
	
	// 동호회 자유게시판 상세보기
	public MateBoardVO getDetailBoard(int no);
	
	// 동호회 자유게시판 수정
	public int boardUpdate(MateBoardVO mv);
	
	// 동호회 자유게시판 삭제
	public int boardDelete(int no);
	
	// 동호회 자유게시판 파일 삭제
	public int boardDeleteFile(int no);
	
	// 동호회 자유게시판 등록
	public int boardInsert(MateBoardVO mv);
	
	// 동호회 자유게시판 조회수 증가
	public int boardIncreaseCount(int no);
	
	// 동호회 자유게시판 첨부파일 등록
	public MBoardFileVO insertFile(Collection<Part> parts) throws Exception;
	
	// 동호회 자유게시판 첨부파일 상세정보
	public List<MBoardFileVO> getFile(int bNo);
	
	// 사진 가져오기
	public MBoardFileVO getFileDetail(int fileNo);
}
