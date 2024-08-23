package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ReviewVO;

public class ReviewDAO {
	SqlSession sqlSession;
	public ReviewDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//상세페이지 미니리뷰
	public List<ReviewVO> selectreview(int p_idx) {
		List<ReviewVO> list = sqlSession.selectList("r.pro_review", p_idx);
		return list;
	}
	
	//
	public ReviewVO selectPidx(String c_id) {
		ReviewVO vo = sqlSession.selectOne("r.select_pidx", c_id);
		return vo;
	}
	
	//리뷰 작성
	public int insert(ReviewVO vo) {
		int res = sqlSession.insert("r.review_insert", vo);
		return res;
	}
	
	//리뷰 수정을 위해 조회
	public ReviewVO selectOne(int r_idx) {
		ReviewVO vo = sqlSession.selectOne("r.select_one", r_idx);
		return vo;
	}
	
	//리뷰 수정
	public int update(ReviewVO vo) {
		int res = sqlSession.update("r.review_update", vo);
		return res;
	}
	
	//내 리뷰 조회
	public List<ReviewVO> selectList(String c_id) {
		List<ReviewVO> list = sqlSession.selectList("r.review_list", c_id);
		return list;
	}
	
	//리뷰 삭제
	public int delete(int r_idx) {
		int res = sqlSession.delete("r.review_delete", r_idx);
		return res;
	}
	
	//관리자 리뷰 조회
	public List<ReviewVO> selectList(){
		List<ReviewVO> list = sqlSession.selectList("r.review_manager");
		return list;
	}
}
