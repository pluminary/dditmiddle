package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.adminVO;

public interface IMemberDao {
	
	// 회원가입
	
	// 회원 등록
	public int insertMember(MemberVO mv);

	// 회원ID 중복체크
	public int idCheck(String memId);
	
	// 닉네임 중복체크	
	public int nickCheck(String memNick);
	
	// 이메일 중복체크
	public int emailCheck(String memEmail);
	
	// 회원정보수정
	public int updateMember(MemberVO mv);
	
	// 회원탈퇴 del_yn
	public int delMember(String memId);
	
	/*--------------------------------------------------*/
	
	// 로그인
	public MemberVO getMember(String memId);
	
	// 아이디 찾기
	public MemberVO searchId(MemberVO mv);
	
	// 비밀번호 찾기
	public MemberVO searchPw(MemberVO mv);
	
	// 관리자 로그인
	public adminVO getAdmin(String adminId);
	
	/*--------------------------------------------------*/
	
	// 사용자 ID와 현재 비밀번호가 일치하는지 확인
	public boolean verifyCurrentPassword(String memId, String currentPassword);
}
