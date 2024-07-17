package kr.or.ddit.mate.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.mate.dao.IMateDao;
import kr.or.ddit.mate.dao.MateDaoImpl;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;

public class MateServiceImpl implements IMateService{
	
	private IMateDao mateDao;
	
    private static MateServiceImpl mateService; 

    private MateServiceImpl() {
    	mateDao = MateDaoImpl.getInstance();
    }
    
    public static IMateService getInstance() {
		if (mateService == null) mateService = new MateServiceImpl();
		return mateService;
	}
	
	
	////////////////////////////////////////////////////////////////////

	@Override
	public List<MateVO> getAllMate(Map<String, Object> map) {
		return mateDao.getAllMate(map);
	}

	@Override
	public MateVO getMateDetail(String clubNo) {
		return mateDao.getMateDetail(clubNo);
	}

	@Override
	public int getMateCount(Map<String, Object> paramMap) {
		return mateDao.getMateCount(paramMap);
	}
	
	@Override
    public int insertMate(MateVO mateVO) {
        // 동호회 정보를 clubs 테이블에 삽입
        // MyBatis의 selectKey를 사용하여 clubNo는 자동으로 설정됨
        return mateDao.insertMate(mateVO);
    }
	
	// join 테이블에 리더 정보 삽입을 처리하는 새로운 메서드
    public void insertLeaderInfo(MateVO mateVO) {
        // 동호회 정보 삽입 후 생성된 clubNo를 사용하여 리더 정보 삽입
        mateDao.insertJoinLeader(mateVO);
    }
    
    @Override
    public int insertJoinLeader(MateVO mateVO) {
        // join 테이블에 리더 정보 삽입
        return mateDao.insertJoinLeader(mateVO);
    }
	
	@Override
    public int insertLike(Map<String, Object> paramMap) {
        return mateDao.insertLike(paramMap);
    }

    @Override
    public int deleteLike(Map<String, Object> paramMap) {
        return mateDao.deleteLike(paramMap);
    }

    @Override
    public int checkLike(Map<String, Object> paramMap) {
        return mateDao.checkLike(paramMap);
    }

    @Override
    public boolean isClubLikedByUser(int memNo, String clubNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memNo", memNo);
        paramMap.put("clubNo", clubNo);
        int count = mateDao.checkLike(paramMap);
        return count > 0;
    }

	@Override
	public int checkJoin(Map<String, Object> pamMap) {
		return mateDao.checkJoin(pamMap);
	}

	@Override
	public MemberVO getLeaderInfo(int no) {
		return mateDao.getLeaderInfo(no);
	}
	
	@Override
	public int insertClubMember(Map<String, Object> map) {
		return mateDao.insertClubMember(map);
	}

	@Override
	public int updateMate(MateVO mv) {
		return mateDao.updateMate(mv);
	}

	@Override
	public int deleteMate(Map<String, Object> map) {
		return mateDao.deleteMate(map);
	}				

	@Override
	public List<MateVO> likeList(Map<String, Object> paramMap) {
		return mateDao.likeList(paramMap);
	}

	@Override
	public int countList(Map<String, Object> paramMap) {
		return mateDao.countList(paramMap);
	}
}
