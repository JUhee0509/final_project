package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.MdVO;

public class MdDAO {
	
	SqlSession sqlSession;
	
	public MdDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<MdVO> selectList(){ 
	List<MdVO> list = sqlSession.selectList("m.md_list"); 
	return list; 
	}
	//md 삭제
	public int md_delete(int p_idx) {
		int res = sqlSession.delete("m.md_delete", p_idx);
		return res;
	}
	// md 등록
	public int MD_update(MdVO vo) {
		int res = sqlSession.insert("m.md_insert", vo);
		return res;
	}
	// md 수정 폼
	public MdVO md_modify_form(int p_idx) {
		MdVO vo = sqlSession.selectOne("m.md_check", p_idx);
		return vo;
	}
	//제품 수정
	public int md_modify(MdVO vo) {
		int res = sqlSession.update("m.md_modify", vo);
		return res;
	}
}
