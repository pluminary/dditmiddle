package kr.or.ddit.mate.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;

public class MateDaoImpl extends MyBatisDao implements IMateDao{
	
	private static IMateDao mateDao;
	
	private MateDaoImpl() {
		
	}
	
	public static IMateDao getInstance() {
		if(mateDao == null) {
			mateDao = new MateDaoImpl();
		}
		return mateDao;
	}
	
	
	////////////////////////////////////////////////////////////////////

	
	@Override
	public List<MateVO> getAllMate(Map<String, Object> map) {
		return selectList("mate.getAllMate", map);
	}

	@Override
	public MateVO getMateDetail(String clubNo) {
		return selectOne("mate.getMateDetail", clubNo);
	}

	@Override
	public int getMateCount(Map<String, Object> paramMap) {
		return selectOne("mate.getMateCount", paramMap);
	}

	@Override
	public int insertMate(MateVO mateVO) {
		return insert("mate.insertMate", mateVO);
	}
	
	@Override
    public String getLatestClubNo(String athlId) {
        return selectOne("mate.getLatestClubNo", athlId);
    }

    @Override
    public int insertJoinLeader(MateVO mateVO) {
        return insert("mate.insertJoinLeader", mateVO);
    }
	
	@Override
    public int insertLike(Map<String, Object> paramMap) {
        return insert("mate.insertLike", paramMap);
    }

    @Override
    public int deleteLike(Map<String, Object> paramMap) {
        return delete("mate.deleteLike", paramMap);
    }

    @Override
    public int checkLike(Map<String, Object> paramMap) {
        return selectOne("mate.checkLike", paramMap);
    }

	@Override
	public int checkJoin(Map<String, Object> paMap) {
		return selectOne("mate.isMemberOfClub", paMap);
	}

	@Override
	public MemberVO getLeaderInfo(int no) {
		return selectOne("mate.getLeaderInfo", no);
	}
	
	@Override
	public int insertClubMember(Map<String, Object> map) {
		return insert("mate.insertClubMember", map);
	}

	@Override
	public int updateMate(MateVO mv) {
		return update("mate.updateMate", mv);
	}

	@Override
	public int deleteMate(Map<String, Object> map) {
		return update("mate.deleteMate", map);
	}

	@Override
	public List<MateVO> likeList(Map<String, Object> paramMap) {
		return selectList("mate.likeList", paramMap);
	}

	@Override
	public int countList(Map<String, Object> paramMap) {
		return selectOne("mate.countList", paramMap);
	}
}
