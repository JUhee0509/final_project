package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.ProductVO;

public class ProductDAO {

	SqlSession sqlSession;

	// 생성자
	public ProductDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 전체목록 조회
		public List<ProductVO> selectlist(Map<String, Object> map) {
			List<ProductVO> list = sqlSession.selectList("pd.product_list", map);
			return list;
		}

	// 분류 기준 조회
	public List<String> v_select(String st) {
		List<String> list = sqlSession.selectOne("pd.prod_view", st);
		return list;
	}
	
	// 목록 : 가격낮은순
	public List<ProductVO> selectLow() {
		List<ProductVO> list = sqlSession.selectList("pd.product_low");
		return list;
	}

	// 목록 : 가격높은순
	public List<ProductVO> selectHigh() {
		List<ProductVO> list = sqlSession.selectList("pd.product_high");
		return list;
	}
		
	// 제품 등록
	public int product_update(ProductVO vo) {
		int res = sqlSession.update("pd.prod_update", vo);
		return res;
	}
		
	//브랜드별
	public List<ProductVO> selectthings(String brand){
		List<ProductVO> list = sqlSession.selectList("pd.selectbrand",brand);
		return list;
	}
	
	// 상품 상세 조회
	public ProductVO select_pro(int p_idx) {
		ProductVO vo = sqlSession.selectOne("pd.pro_view", p_idx);
		return vo;
	}
	

	// 분류기준 조회
	public List<Object> selectBrand(Map<String, String> standardMap) {

		List<Object> list = sqlSession.selectList("pd.select_things", standardMap);
		return list;
	}
	
	//분류기준 중 가격 조회
	public int selectPrice() {
		int res = sqlSession.selectOne("pd.select_price");
		return res;
	}
	//제품 삭제
	public int product_delete(int p_idx) {
		int res = sqlSession.delete("pd.product_delete", p_idx);
		return res;
	}
	//제품 수정 폼
	public ProductVO product_modify_form(int p_idx) {
		ProductVO vo = sqlSession.selectOne("pd.product_check", p_idx);
		return vo;
	}
	//제품 수정
	public int product_modify(ProductVO vo) {
		int res = sqlSession.update("pd.product_modify", vo);
		return res;
	}
	//판매량 상위 5
	public List<ProductVO> selectProduct(){
		List<ProductVO> list = sqlSession.selectList("pd.select_products");
		return list;
	}
	public int getRowTotal( Map<String, Object> map ) {
		int count = sqlSession.selectOne("pd.product_count", map);
		return count;
	}
	// 전체목록 조회
	public List<ProductVO> selectprolist(Map<String, Object> map) {
		List<ProductVO> list = sqlSession.selectList("pd.admin_product_list", map);
		return list;
	}
}
