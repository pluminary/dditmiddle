package kr.or.ddit.place.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.place.vo.AthlVO;
import kr.or.ddit.place.vo.MedicalVO;
import kr.or.ddit.place.vo.PlaceVO;

public interface IPlaceService {
	
	// 운동종목 가져오기
	public List<AthlVO> getAthl();

	// 전체 운동시설 개수 가져오기
	public int getPlaceCount();

	// 전체 운동시설 리스트 가져오기
	public List<PlaceVO> getAllPlace(Map<String, Object> map);
	
	// 검색된 운동시설 개수 가져오기
	public int getPlaceCountBySearch(PlaceVO placeVO);
	
	// 검색된 운동시설 리스트 가져오기
	public List<PlaceVO> getAllPlaceBySearch(Map<String, Object> map);
	
	// 운동시설 상세보기
	public PlaceVO detailPlace(String fcNo);	
	
	// 인근 의료시설 정보 가져오기
	public MedicalVO getMedicInfo(String fcNO); 
	
	// 관리자 운동시설 등록
	public int insertPlace(PlaceVO placeVO);
	
	// 의료시설 정보 모두 가져오기
	public List<MedicalVO> getAllMedic();
	
	// 관리자 시설수정
	public int updatePlace(PlaceVO placeVO);
	
	// 관리자 시설삭제
	public int deletePlace(String fcNo);
}
