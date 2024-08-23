package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.CartVO;

public class CartDAO {
	SqlSession sqlSession;
	public CartDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//장바구니 목록 조회
	public List<CartVO> selectList(String c_id){
		
		List<CartVO> list = sqlSession.selectList("ca.cart_list", c_id);
		
		return list;
	}
	
	//장바구니 목록 삭제
	public int delete(int c_idx) {
		int res = sqlSession.delete("ca.delete", c_idx);
		return res;
	}
	
	public int delete_order(int c_idx) {
		int res = sqlSession.delete("ca.delete_order", c_idx);
		return res;
	}
	
	//주소 목록 추가
	public List<CartVO> selectAddr(String c_id){
		List<CartVO> list = sqlSession.selectList("ca.addr", c_id);
		return list;
	}
	
	//총 금액 계산
	public int selectTotalprice(String c_id) {
		int res = sqlSession.selectOne("ca.cart_total_price", c_id);
		return res;
	}
	
	//결제 금액 계산
	public int selectPayprice(String c_id) {
		int res = sqlSession.selectOne("ca.cart_pay_price", c_id);
		return res;
	}
	
	//적립금
	public int selectPoint(String c_id) {
		int res = sqlSession.selectOne("ca.cart_bonus_point", c_id);
		return res;
	}
	
	//수량 더하기
	public int updatePlus(CartVO vo) {
		int res = sqlSession.update("ca.amount_plus", vo);
		return res;
	}
	
	//수량 빼기
	public int updateMinus(Integer p_idx) {
		int res = sqlSession.update("ca.amount_minus", p_idx);
		return res;
	}
	
	//체크시
	public int checkOn(CartVO vo) {
		int res = sqlSession.update("ca.check_on", vo);
		return res;
	}
	
	//체크 해제시
	public int checkOff(CartVO vo) {
		int res = sqlSession.update("ca.check_off", vo);
		return res;
	}
	
	//세부리스트에서 카트에 담기
	public int cart(Map<String, Object> map) {
		// 이미 장바구니에 해당 상품이 있는지 확인
	    int count = sqlSession.selectOne("p.check_pick_exists", map);
	    
	    // 이미 존재한다면, 추가하지 않고 -1을 리턴하거나 다른 방법으로 처리
	    if (count > 0) {
	        return -1; // 이미 장바구니에 있는 경우를 표시하는 값
	    }
	    
	    // 존재하지 않는다면 장바구니에 추가
	    int res = sqlSession.insert("ca.cart_insert", map);
	    return res;
	}
	
	
}
