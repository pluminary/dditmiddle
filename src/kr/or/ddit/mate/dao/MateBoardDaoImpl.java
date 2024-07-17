package kr.or.ddit.mate.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.mate.vo.MBoardFileVO;
import kr.or.ddit.mate.vo.MateBoardVO;
import kr.or.ddit.mate.vo.MateMemberVO;
import kr.or.ddit.mate.vo.MateNoticeVO;

public class MateBoardDaoImpl extends MyBatisDao implements IMateBoardDao {

	private static MateBoardDaoImpl dao;
	
	private MateBoardDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	public static MateBoardDaoImpl getInstance() {
		if(dao == null) dao = new MateBoardDaoImpl();
		return dao;
	}
	
	/////////////////////////////////////////////////////////////////////
	
	@Override
	public List<MateMemberVO> getMateMember(Map<String, Object> map) {
		return selectList("mateBoard.getMateMember", map);
	}

	@Override
	public int getMemberCount(String clubNo) {
		return selectOne("mateBoard.getMemberCount", clubNo);
	}

	@Override
	public int getNoticeCount(Map<String, Object> map) {
		return selectOne("mateBoard.getNoticeCount", map);
	}

	@Override
	public List<MateNoticeVO> getAllNotice(Map<String, Object> map) {
		return selectList("mateBoard.getAllNotice", map);
	}

	@Override
	public MateNoticeVO getDetailNotice(int no) {
		return selectOne("mateBoard.getDetailNotice", no);
	}

	@Override
	public int noticeUpdate(MateNoticeVO mv) {
		return update("mateBoard.noticeUpdate", mv);
	}

	@Override
	public int noticeDelete(int no) {
		return delete("mateBoard.noticeDelete", no);
	}

	@Override
	public int noticeInsert(MateNoticeVO mv) {
		return insert("mateBoard.noticeInsert", mv);
	}

	@Override
	public int noticeIncreaseCount(int no) {
		return update("mateBoard.increaseCount", no);
	}

	@Override
	public int getBoardCount(Map<String, Object> map) {
		return selectOne("mateBoard.getBoardCount", map);
	}

	@Override
	public List<MateBoardVO> getAllBoard(Map<String, Object> map) {
		return selectList("mateBoard.getAllBoard", map);
	}

	@Override
	public MateBoardVO getDetailBoard(int no) {
		return selectOne("mateBoard.getDetailBoard", no);
	}

	@Override
	public int boardUpdate(MateBoardVO mv) {
		return update("mateBoard.boardUpdate", mv);
	}

	@Override
	public int boardDelete(int no) {
		return delete("mateBoard.boardDelete", no);
	}

	@Override
	public int boardInsert(MateBoardVO mv) {
		return insert("mateBoard.boardInsert", mv);
	}

	@Override
	public int boardIncreaseCount(int no) {
		return update("mateBoard.increaseBoardCount", no);
	}

	@Override
	public int insertFile(MBoardFileVO fv) {
		return insert("mateBoard.insertFile", fv);
	}

	@Override
	public List<MBoardFileVO> getFile(int no) {
		return selectList("mateBoard.getFile", no);
	}

	@Override
	public MBoardFileVO getFileDetail(int fileNo) {
		return selectOne("mateBoard.getFileDetail", fileNo);
	}

	@Override
	public int boardDeleteFile(int no) {
		return delete("mateBoard.boardDeleteFile", no);
	}

}
