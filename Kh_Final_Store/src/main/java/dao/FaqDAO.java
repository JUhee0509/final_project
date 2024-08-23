package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;


import vo.FaqVO;

public class FaqDAO {
	
	SqlSession sqlSession;
	
	
	
	public FaqDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	// 전체 게시글 조회
	public List<FaqVO> selectlist(){
		List<FaqVO> list = sqlSession.selectList("f.faq_list");
		return list;
	}

	// 새 글 등록
	public int insert(FaqVO vo) {
		int res = sqlSession.insert("f.faq_insert", vo);
		return res;
	}
		
	// 수정 조회
	public FaqVO selectOne(int idx) {
		FaqVO vo = sqlSession.selectOne("f.select_one", idx);
		return vo;
	}
		
	// 수정
	public int update(FaqVO vo) {
		int res = sqlSession.update("f.faq_update", vo);
		return res;
	}
		
	// 삭제
	public int delete(int idx) {
		int res = sqlSession.delete("f.faq_delete", idx);
		return res;
	}	
}
