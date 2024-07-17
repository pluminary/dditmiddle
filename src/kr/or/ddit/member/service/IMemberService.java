package kr.or.ddit.member.service;

import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.adminVO;

public interface IMemberService {

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
	
	// 관리자 로그인
	public adminVO getAdmin(String adminId);
	
	// 회원상세정보
	public MemberVO getMember(String username);

	// 회원 아이디 찾기
	public MemberVO searchId(MemberVO vo);
	
	// 회원 비밀번호 찾기
	public MemberVO searchPw(MemberVO vo);

	
	/*--------------------------------------------------*/
	
	// 사용자 ID와 현재 비밀번호가 일치하는지 확인 
	public boolean verifyCurrentPassword(String memId, String currentPassword);
}
