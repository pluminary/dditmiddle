package kr.or.ddit.place.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.place.dao.IPlaceDao;
import kr.or.ddit.place.dao.PlaceDaoImpl;
import kr.or.ddit.place.vo.AthlVO;
import kr.or.ddit.place.vo.MedicalVO;
import kr.or.ddit.place.vo.PlaceVO;

public class PlaceServiceImpl implements IPlaceService {
	
	private IPlaceDao dao;
	
	private static PlaceServiceImpl placeService;
	
	private PlaceServiceImpl() {
		dao = PlaceDaoImpl.getInstance();
	}
	
	public static PlaceServiceImpl getInstance() {
		if(placeService == null) {
			placeService = new PlaceServiceImpl();
		}
		return placeService;
	}
	
	////////////////////////////////////////////////////////////////////
	
	@Override
	public int insertPlace(PlaceVO placeVO) {
		return dao.insertPlace(placeVO);
	}

	@Override
	public int getPlaceCount() {
		return dao.getPlaceCount();
	}

	@Override
	public List<PlaceVO> getAllPlace(Map<String, Object> map) {
		return dao.getAllPlace(map);
	}

	@Override
	public List<PlaceVO> getAllPlaceBySearch(Map<String, Object> map) {
		return dao.getAllPlaceBySearch(map);
	}

	@Override
	public int getPlaceCountBySearch(PlaceVO placeVO) {
		System.out.println(placeVO);
		return dao.getPlaceCountBySearch(placeVO);
	}

	@Override
	public List<AthlVO> getAthl() {
		return dao.getAthl();
	}

	@Override
	public PlaceVO detailPlace(String fcNo) {
		return dao.detailPlace(fcNo);
	}

	@Override
	public MedicalVO getMedicInfo(String fcNO) {
		return dao.getMedicInfo(fcNO);
	}

	@Override
	public int updatePlace(PlaceVO placeVO) {
		return dao.updatePlace(placeVO);
	}

	@Override
	public List<MedicalVO> getAllMedic() {
		return dao.getAllMedic();
	}

	@Override
	public int deletePlace(String fcNo) {
		return dao.deletePlace(fcNo);
	}

}
