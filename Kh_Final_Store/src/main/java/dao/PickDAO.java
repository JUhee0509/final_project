package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.PickVO;
import vo.ProductVO;

public class PickDAO {
	SqlSession sqlSession;

	public PickDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<ProductVO> select(String c_id) {
		List<ProductVO> list = sqlSession.selectList("pd.pick_select", c_id);
		return list;
	}

	public int insert_pick(Map<String, Object> map) {
		// 이미 장바구니에 해당 상품이 있는지 확인
	    int count = sqlSession.selectOne("p.check_pick_exists", map);
	    
	    // 이미 존재한다면, 추가하지 않고 -1을 리턴하거나 다른 방법으로 처리
	    if (count > 0) {
	        return -1; // 이미 장바구니에 있는 경우를 표시하는 값
	    }
	    
	    // 존재하지 않는다면 장바구니에 추가
	    int res = sqlSession.insert("p.pick_insert", map);
	    return res;
	}

	// 찜 추가
	public int pick_check(Map<String, Object> map) {
		int res = sqlSession.insert("p.pick_JJIM", map);
		return res;
	}

	// 찜 목록 삭제
	public int delete_pick(Map<String, Object> map) {
		int res = sqlSession.delete("p.pick_delete", map);
		return res;
	}

	// 찜확인
	public PickVO select_pick(Map<String, Object> map) {
		PickVO vo = sqlSession.selectOne("p.pick_check", map);
		return vo;
	}
}
