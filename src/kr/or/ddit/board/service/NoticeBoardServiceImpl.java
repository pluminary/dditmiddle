package kr.or.ddit.board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.INoticeBoardDao;
import kr.or.ddit.board.dao.NoticeBoardDaoImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;

public class NoticeBoardServiceImpl implements INoticeBoardService {
	
	private INoticeBoardDao noticeDao;
	
    private static NoticeBoardServiceImpl noticeService; 

    private NoticeBoardServiceImpl() {
    	noticeDao = NoticeBoardDaoImpl.getInstance();
    }
    
    public static INoticeBoardService getInstance() {
		if (noticeService == null) noticeService = new NoticeBoardServiceImpl();
		return noticeService;
	}
    
    
    ////////////////////////////////////////////////////////////////////
    
    
    @Override
    public List<NoticeBoardVO> getAllNotice(Map<String, Object> map) {
    	return noticeDao.getAllNotice(map);
    }

	@Override
	public NoticeBoardVO getNoticeDetail(int noticeNo) {
	    // 먼저 조회수를 증가시킵니다.
	    int updatedCount = hitCount(noticeNo);
	    // 그 다음에 상세 정보를 가져옵니다.
	    NoticeBoardVO notice = noticeDao.getNoticeDetail(noticeNo);
	    // 조회수가 증가된 상세 정보를 리턴합니다.
	    return notice;
	}

	@Override
	public int insertNotice(NoticeBoardVO noticeBoardVO) {
		return noticeDao.insertNotice(noticeBoardVO);
	}

	@Override
	public int updateNotice(NoticeBoardVO noticeBoardVO) {
		return noticeDao.updateNotice(noticeBoardVO);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(noticeNo);
	}

	@Override
	public int hitCount(int noticeNo) {
//		return noticeDao.hitCount(noticeNo);
		
		// 조회수를 증가시킵니다.
	    int updatedCount = noticeDao.hitCount(noticeNo);
	    // 증가된 조회수를 리턴합니다.
	    return updatedCount;
	}

	@Override
	public int getNoticeCount() {
		return noticeDao.getNoticeCount();
	}

}
