package kr.or.ddit.mate.service;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import com.sun.mail.handlers.message_rfc822;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.mate.dao.IMateBoardDao;
import kr.or.ddit.mate.dao.MateBoardDaoImpl;
import kr.or.ddit.mate.vo.MBoardFileVO;
import kr.or.ddit.mate.vo.MateBoardVO;
import kr.or.ddit.mate.vo.MateMemberVO;
import kr.or.ddit.mate.vo.MateNoticeVO;

public class MateBoardServiceImpl extends MyBatisDao implements IMateBoardService {
	
	private IMateBoardDao dao;
	
	private static MateBoardServiceImpl service;
	
	private MateBoardServiceImpl() {
		dao = MateBoardDaoImpl.getInstance();
	}
	
	public static MateBoardServiceImpl getInstance() {
		if(service == null) service = new MateBoardServiceImpl();
		return service;
	}

	/////////////////////////////////////////////////////////////////////////////
	
	@Override
	public List<MateMemberVO> getMateMember(Map<String, Object> map) {
		return dao.getMateMember(map);
	}

	@Override
	public int getMemberCount(String clubNo) {
		return dao.getMemberCount(clubNo);
	}

	@Override
	public int getNoticeCount(Map<String, Object> map) {
		return dao.getNoticeCount(map);
	}

	@Override
	public List<MateNoticeVO> getAllNotice(Map<String, Object> map) {
		return dao.getAllNotice(map);
	}

	@Override
	public MateNoticeVO getDetailNotice(int no) {
		return dao.getDetailNotice(no);
	}

	@Override
	public int noticeUpdate(MateNoticeVO mv) {
		return dao.noticeUpdate(mv);
	}

	@Override
	public int noticeDelete(int no) {
		return dao.noticeDelete(no);
	}

	@Override
	public int noticeInsert(MateNoticeVO mv) {
		return dao.noticeInsert(mv);
	}

	@Override
	public int noticeIncreaseCount(int no) {
		return dao.noticeIncreaseCount(no);
	}

	@Override
	public int getBoardCount(Map<String, Object> map) {
		return dao.getBoardCount(map);
	}

	@Override
	public List<MateBoardVO> getAllBoard(Map<String, Object> map) {
		return dao.getAllBoard(map);
	}

	@Override
	public MateBoardVO getDetailBoard(int no) {
		return dao.getDetailBoard(no);
	}

	@Override
	public int boardUpdate(MateBoardVO mv) {
		return dao.boardUpdate(mv);
	}

	@Override
	public int boardDelete(int no) {
		return dao.boardDelete(no);
	}

	@Override
	public int boardInsert(MateBoardVO mv) {
		return dao.boardInsert(mv);
	}

	@Override
	public int boardIncreaseCount(int no) {
		return dao.boardIncreaseCount(no);
	}

	
	@Override
	public MBoardFileVO insertFile(Collection<Part> parts) throws Exception {
		String src = "d:/database/D_setting/A_TeachingMaterial/04_MiddelProject/documents/이미지/메이트게시판";
		File uploadDir = new File(src);
		if(!uploadDir.exists()) {
			uploadDir.mkdir();
		}
		
		MBoardFileVO mBoardFileVO = new MBoardFileVO();
		
		for (Part part : parts) {
			System.out.println("Content-Disposition => " + part.getHeader("Content-Disposition"));
			String fileName = part.getSubmittedFileName();
			System.out.println(fileName);
			
			if(fileName != null && !fileName.equals("")) {
				String cbfileName = fileName;
				String cbfileSrc = src + "/" + cbfileName;
				
				
				part.write(cbfileSrc);	// 파일 저장
				mBoardFileVO.setCbfileName(cbfileName);
				mBoardFileVO.setCbfileSrc(cbfileSrc);
				dao.insertFile(mBoardFileVO);
				
				part.delete();
				
			}
		}
		return mBoardFileVO;
	}

	@Override
	public List<MBoardFileVO> getFile(int no) {
		return dao.getFile(no);
	}

	@Override
	public MBoardFileVO getFileDetail(int fileNo) {
		return dao.getFileDetail(fileNo);
	}

	@Override
	public int boardDeleteFile(int no) {
		return dao.boardDeleteFile(no);
	}

	
	
}
