package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.OrderVO;

public class OrderDAO {
	SqlSession sqlSession;

	public OrderDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//주문 내역 보기
	public List<OrderVO> selectList(String c_id){ 
		List<OrderVO> list = sqlSession.selectList("o.order_detail", c_id); 
		return list; 
	}
	
	//배송 완료 내역 보기
	public List<OrderVO> selectFin(String c_id){
		List<OrderVO> list = sqlSession.selectList("o.order_fin", c_id);
		return list;
	}
	
	//배송 중 내역 보기
	public List<OrderVO> selectShip(String c_id){
		List<OrderVO> list = sqlSession.selectList("o.order_ship", c_id);
		return list;
	}
	
	//배송 준비중 내역 보기
	public List<OrderVO> selectReady(String c_id){
		List<OrderVO> list = sqlSession.selectList("o.order_ready", c_id);
		return list;
	}
	
	//교환 환불 내역 보기
	public List<OrderVO> selectRefund(String c_id){
		List<OrderVO> list = sqlSession.selectList("o.order_refund", c_id);
		return list;
	}
	
	//관리자 주문 내역
	public List<OrderVO> selectadminList(){
		List<OrderVO> list = sqlSession.selectList("o.order_list");
		return list;
	}
	
	//전체 주문수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("o.order_count", map);
		return count;
	}
	
	//배송 전 주문 취소같은 수정
	public int updatePay(int o_idx) {
		int res = sqlSession.update("o.pay_update", o_idx);
		return res;
	}
	
	//교환
	public int updateEx(int o_idx) {
		int res = sqlSession.update("o.ex_update", o_idx);
		return res;
	}
	
	//환불
	public int updateRefund(int o_idx) {
		int res = sqlSession.update("o.update_refund", o_idx);
		return res;
	}
	
	//추가
	public int insert_order(Map<String, Object> order) {
		int res = sqlSession.insert("o.insert_order", order);
		return res;
	}
	
	//배송준비중으로 변경(관리자)
	public int updateReady(int o_idx) {
		int res = sqlSession.update("o.update_ready", o_idx);
		return res;
	}
	
	//배송중으로 변경(관리자)
	public int updateShip(int o_idx) {
		int res = sqlSession.update("o.update_shipping", o_idx);
		return res;
	}
	
	//배송완료로 변경(관리자)
	public int updateComplete(int o_idx) {
		int res = sqlSession.update("o.update_complete", o_idx);
		return res;
	}
}
