package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.InquireVO;

public class InquireDAO {

	SqlSession sqlSession;

	public InquireDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 전체 게시글 조회
	public List<InquireVO> selectlist(Map<String, Object> map) {
		List<InquireVO> list = sqlSession.selectList("i.inquire_list", map);
		return list;
	}

	// 상세글 조회(글 하나 조회) 수정시 정보 조회할 때, 여기서 오류
	public InquireVO selectOne(int i_idx) {
		System.out.println("dao i_idx : " + i_idx);
		InquireVO vo = sqlSession.selectOne("i.inquire_view", i_idx);
		return vo;
	}

	// 문의글 수정
	public int inq_update(InquireVO vo) {
		int res = sqlSession.update("i.inquire_update", vo);
		return res;
	}

	// 문의글 작성
	public int inq_insert(InquireVO vo) {
		int res = sqlSession.insert("i.inquire_insert", vo);
		System.out.println("res : " + res);
		return res;
	}

	// 전체 게시글 수
	public int getRowTotal(Map<String, Object> map) {
		int res = sqlSession.selectOne("i.inquire_count", map);
		return res;
	}

	// 글 삭제
	public int inq_delete(int i_idx) {
		int res = sqlSession.delete("i.inquire_delete", i_idx);
		return res;
	}

	// 관리자용 조회
	public List<InquireVO> adminSelectlist(Map<String, Object> map) {
		List<InquireVO> list = sqlSession.selectList("i.admin_inquire_list", map);
		return list;
	}

	// 관리자용 전체 게시글 수
	public int adminGetRowTotal(Map<String, Object> map) {
		int res = sqlSession.selectOne("i.admin_inquire_count", map);
		return res;
	}

	// 관리자가 게시글 조회시 상태 수정중으로 변경
	public int update_status(int idx) {
		int res = sqlSession.update("i.admin_update_status", idx);
		return res;
	}

	// 관리자가 게시글 조회시 상태 수정중으로 변경
	public int update_status_fin(int idx) {
		int res = sqlSession.update("i.admin_fin_comment", idx);
		return res;
	}


}
