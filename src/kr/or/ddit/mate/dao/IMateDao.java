package kr.or.ddit.mate.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.mate.vo.MateVO;
import kr.or.ddit.member.vo.MemberVO;

public interface IMateDao {
	// 동호회 조회
	public List<MateVO> getAllMate(Map<String, Object> map);
	
	//동호회 상세조회
	public MateVO getMateDetail(String clubNo);
	
	// 동호호 회장 정보 조회
	public MemberVO getLeaderInfo(int no);
	
	// 전체 글 수
	public int getMateCount(Map<String, Object> paramMap);
	
	// 동호회 등록 
	public int insertMate(MateVO MateVO);
	
	// 동호회 번호 생성을 위한 메소드
    public String getLatestClubNo(String athlId);

    // join 테이블에 리더 정보 삽입
    public int insertJoinLeader(MateVO mateVO);
	
	// 찜하기 추가
    public int insertLike(Map<String, Object> paramMap);
    
    // 찜하기 삭제
    public int deleteLike(Map<String, Object> paramMap);
    
    // 찜하기 상태 확인
    public int checkLike(Map<String, Object> paramMap);
    
    // 가입 상태 확인
    public int checkJoin(Map<String, Object> paMap);

    // 나의 동호회 찜 목록
	public List<MateVO> likeList(Map<String, Object> paramMap);

	// 나의 찜관리 게시물 개수 가져오기
	public int countList(Map<String, Object> paramMap);
    // 동호회 가입
    public int insertClubMember(Map<String, Object> map);
    
    // 동호회 수정
    public int updateMate(MateVO mv);
    
    // 동호회 탈퇴
    public int deleteMate(Map<String, Object> map);
    
}
