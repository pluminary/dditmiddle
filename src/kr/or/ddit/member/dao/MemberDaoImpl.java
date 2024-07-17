package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.adminVO;
import kr.or.ddit.util.MyBatisUtil;


public class MemberDaoImpl extends MyBatisDao implements IMemberDao{

	private static IMemberDao memDao;
	
	private MemberDaoImpl() {
		
	}
	
	public static IMemberDao getInstance() {
		if(memDao == null) {
			memDao = new MemberDaoImpl();
		}
		return memDao;
	}

	@Override
	public int insertMember(MemberVO memberVO) {
		
		return insert("member.insertMember", memberVO);
	}

	@Override
	public int idCheck(String memId) {
		
		return selectOne("member.checkId", memId);
	}

	@Override
	public int nickCheck(String memNick) {
		
		return selectOne("member.nickCheck", memNick);
	}

	// 관리자 로그인
	@Override
	public adminVO getAdmin(String adminId) {
		System.out.println("dao>>>>>>>>>>>>>>>>" +adminId );
		return selectOne("member.getAdmin", adminId);
	}
	
	// 로그인
	@Override
	public MemberVO getMember(String memId) {
		return selectOne("member.getMember", memId );
	}

	@Override
	public int emailCheck(String tEmail) {
		
		return selectOne("member.emailCheck", tEmail);
	}

	// 회원 아이디 찾기
	@Override
	public MemberVO searchId(MemberVO mv) {
		return selectOne("member.searchId", mv);
	}

	@Override
	public MemberVO searchPw(MemberVO mv) {
		return selectOne("member.searchPw", mv);
	}

	@Override
	public int updateMember(MemberVO mv) {
		return update("member.updateMember", mv);
	}

	
	@Override
	public int delMember(String memId) {
		return delete("member.delMember", memId);
	}
	
	// 사용자 ID와 현재 비밀번호가 일치하는지 확인
	@Override
	public boolean verifyCurrentPassword(String memId, String currentPassword) {
		SqlSession sqlSession = MyBatisUtil.getSqlSession();
	    try {
	        // 사용자 ID를 이용하여 사용자의 비밀번호를 조회합니다.
	        String storedPassword = sqlSession.selectOne("mypage.getStoredPassword", memId);

	        // 저장된 비밀번호와 입력된 비밀번호를 비교합니다.
	        return storedPassword != null && storedPassword.equals(currentPassword);
	    } catch (PersistenceException e) {
	        // 예외 처리: 로그 기록, null 반환, 또는 적절한 예외를 던집니다.
	        e.printStackTrace();
	        return false;
	    } finally {
	        sqlSession.close(); // SQL 세션을 닫습니다.
	    }
	}
}
