package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.AddrVO;

public class AddrDAO {
	SqlSession sqlSession;
	public AddrDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//새 주소 등록
	public int insert(AddrVO vo) {
		int res = sqlSession.insert("a.addr_reg", vo);
		return res;
	}
	
	//주소 불러오기
	public List<AddrVO> selectList(String c_id){
		List<AddrVO> list = sqlSession.selectList("a.addr_list", c_id);
		return list;
	}
	
	//주소 삭제
	public int delete(int idx) {
		int res = sqlSession.delete("a.addr_del", idx);
		return res;
	}
}
