package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.adminVO;

public class MemberServiceImpl implements IMemberService {
	
	private static IMemberService memService; 
	
	private IMemberDao memDao;
	
	private MemberServiceImpl() {
		memDao = MemberDaoImpl.getInstance();
		
	}
	
	public static IMemberService getInstance() {
		if(memService == null) {
			memService = new MemberServiceImpl();
		}
		return memService;
	}

	@Override
	public int insertMember(MemberVO memberVO) {
		
		return memDao.insertMember(memberVO);
	}

	@Override
	public int idCheck(String memId) {
		
		return memDao.idCheck(memId);
	}

	@Override
	public int nickCheck(String memNick) {
		
		return memDao.nickCheck(memNick);
	}


	// 로그인할때 쓰는 메서드 (username = 아이디를 뜻함)
	@Override
	public MemberVO getMember(String username) {
		return memDao.getMember(username);
	}

	@Override
	public int emailCheck(String memEmail) {
		
		return memDao.emailCheck(memEmail);
	}

	
	@Override
	public MemberVO searchId(MemberVO vo) {
		return memDao.searchId(vo);
	}

	@Override
	public MemberVO searchPw(MemberVO vo) {
		return memDao.searchPw(vo);
	}

	@Override
	public adminVO getAdmin(String adminId) {
		return memDao.getAdmin(adminId);
	}

	@Override
	public int updateMember(MemberVO mv) {
		return memDao.updateMember(mv);
	}

	@Override
	public int delMember(String memId) {
		return memDao.delMember(memId);
	}
	
	///////////////////////////////////////
	
	// 사용자 ID와 현재 비밀번호가 일치하는지 확인
	@Override
	public boolean verifyCurrentPassword(String memId, String currentPassword) {
		return memDao.verifyCurrentPassword(memId, currentPassword);
	}
}
