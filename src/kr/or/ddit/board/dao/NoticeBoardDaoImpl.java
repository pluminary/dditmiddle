package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.common.MyBatisDao;


public class NoticeBoardDaoImpl extends MyBatisDao implements INoticeBoardDao{
	
	private static INoticeBoardDao noticeDao;
	
	private NoticeBoardDaoImpl() {
		
	}
	
	public static INoticeBoardDao getInstance() {
		if(noticeDao == null) {
			noticeDao = new NoticeBoardDaoImpl();
		}
		return noticeDao;
	}
	
	
	////////////////////////////////////////////////////////////////////

	
	@Override
	public List<NoticeBoardVO> getAllNotice(Map<String, Object> map) {
		return selectList("noticeboard.getAllNotice", map);
	}

	@Override
	public NoticeBoardVO getNoticeDetail(int noticeNo) {
		return selectOne("noticeboard.getNoticeDetail", noticeNo);
	}

	@Override
	public int insertNotice(NoticeBoardVO noticeBoardVO) {
		return insert("noticeboard.insertNotice", noticeBoardVO);
	}

	@Override
	public int updateNotice(NoticeBoardVO noticeBoardVO) {
		return update("noticeboard.updateNotice", noticeBoardVO);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return delete("noticeboard.deleteNotice", noticeNo);
	}

	@Override
	public int hitCount(int noticeNo) {
		return update("noticeboard.hitCount", noticeNo);
	}

	@Override
	public int getNoticeCount() {
		return selectOne("noticeboard.getNoticeCount");
	}
	
}
