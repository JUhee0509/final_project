package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVO;

public class NoticeDAO {

	SqlSession sqlSession;

	public NoticeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 전체글 조회
	public List<NoticeVO> selectlist(Map<String, Object> map) {
		List<NoticeVO> list = sqlSession.selectList("n.notice_list", map);
		return list;
	}

	// 상세글 조회
	public NoticeVO selectOne(int idx) {
		NoticeVO vo = sqlSession.selectOne("n.notice_one", idx);
		return vo;
	}

	// 전체 게시글 수
	public int getRowTotal(Map<String, Object> map) {
		int res = sqlSession.selectOne("n.notice_count", map);
		return res;
	}

	// 공지 등록
	public int insert(NoticeVO vo) {
		int res = sqlSession.insert("n.notice_insert", vo);
		return res;
	}

	// 공지 삭제
	public int delete_notice(int idx) {
		int res = sqlSession.delete("n.notice_delete", idx);
		return res;
	}

	// 공지 수정
	public int update_notice(NoticeVO vo) {
		int res = sqlSession.update("n.notice_update", vo);
		return res;
	}

	// 공지 수정
//	public NoticeVO noticeSelectOne(int idx) {
//		NoticeVO vo = sqlSession.selectOne("n.notice_one", idx);
//		return vo;
//	}

}
