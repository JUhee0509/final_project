package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.ReceiptVO;

public class ReceiptDAO {
	SqlSession sqlSession;
	public ReceiptDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//영수증 내역
	public List<ReceiptVO> selectList(Map<String, Object> map){
		List<ReceiptVO> list = sqlSession.selectList("re.receipt", map);
		return list;
	}
	//영수증 주문자, 주소지 정보
	public ReceiptVO selectOne(Map<String, Object> map) {
		ReceiptVO vo = sqlSession.selectOne("re.receipt_one", map);
		return vo;
		
	}
	
	//총 상품 금액
	public int selectTotalprice(String c_id) {
		int res = sqlSession.selectOne("re.total_price", c_id);
		return res;
	}
	
	//총 할인 금액
	public int selectTotalsaleprice(String c_id) {
		int res = sqlSession.selectOne("re.total_sale_price", c_id);
		return res;
	}

}
