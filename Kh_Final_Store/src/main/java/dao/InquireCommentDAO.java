package dao;

import org.apache.ibatis.session.SqlSession;

import vo.InquirecommentVO;

public class InquireCommentDAO {

	SqlSession sqlSession;

	public InquireCommentDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 문의글의 답글 조회
	public InquirecommentVO selectlist(int i_idx) {
		InquirecommentVO vo = sqlSession.selectOne("ic.inqc_select", i_idx);
		return vo;
	}

	// 문의글 작성
	public int adminInqInsert(InquirecommentVO vo) {
		System.out.println("a_id : " + vo.getA_id());
		int res = sqlSession.insert("ic.inqc_insert", vo);
		return res;
	}

	// 문의글 수정을 위한 조회
	public InquirecommentVO selectOne(int i_idx) {
		InquirecommentVO vo = sqlSession.selectOne("ic.inqc_select_one", i_idx);
		return vo;
	}

	// 문의글 수정
	public int inq_update(InquirecommentVO vo) {
		System.out.println("content : " + vo.getContent() + "/a_id : " + vo.getA_id() + "/c_idx : " + vo.getC_idx());
		int res = sqlSession.update("ic.inqc_update", vo);
		System.out.println("dao의 결과 : " + res);
		return res;
	}

}
