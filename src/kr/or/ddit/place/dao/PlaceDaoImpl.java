package kr.or.ddit.place.dao;

import java.util.List;
import java.util.Map;


import kr.or.ddit.common.MyBatisDao;
import kr.or.ddit.place.vo.AthlVO;
import kr.or.ddit.place.vo.MedicalVO;
import kr.or.ddit.place.vo.PlaceVO;

public class PlaceDaoImpl extends MyBatisDao implements IPlaceDao{
	
	private static PlaceDaoImpl dao;
	
	private PlaceDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	public static PlaceDaoImpl getInstance() {
		if(dao == null) {
			dao = new PlaceDaoImpl();
		}
		return dao;
	}
	
	/////////////////////////////////////////////////////////////


	@Override
	public List<PlaceVO> getAllPlace(Map<String, Object> map) {
		return selectList("place.getAllPlace", map);
	}

	@Override
	public int getPlaceCount() {
		return selectOne("place.getPlaceCount");
	}

	@Override
	public List<PlaceVO> getAllPlaceBySearch(Map<String, Object> map) {
		return selectList("place.getAllPlaceBySearch", map);
	}

	@Override
	public int getPlaceCountBySearch(PlaceVO placeVO) {
		System.out.println("dao" + placeVO);
		return selectOne("place.getPlaceCountBySearch", placeVO);
	}

	@Override
	public List<AthlVO> getAthl() {
		return selectList("place.getAthl");
	}

	@Override
	public int insertPlace(PlaceVO placeVO) {
		return insert("place.insertPlace", placeVO);
	}

	@Override
	public PlaceVO detailPlace(String fcNo) {
		return selectOne("place.detailPlace", fcNo);
	}

	@Override
	public MedicalVO getMedicInfo(String fcNO) {
		return selectOne("place.getMedicInfo", fcNO);
	}

	@Override
	public int updatePlace(PlaceVO placeVO) {
		return update("place.updatePlace", placeVO);
	}

	@Override
	public List<MedicalVO> getAllMedic() {
		return selectList("place.getAllMedic");
	}

	@Override
	public int deletePlace(String fcNo) {
		return delete("place.deletePlace", fcNo);
	}
}
