package dao;

import org.apache.ibatis.session.SqlSession;

import vo.BlacklistVO;

public class BlacklistDAO {
	SqlSession sqlSession;

	public BlacklistDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int blackinsert(BlacklistVO vo) {
		int res = sqlSession.insert("b.blacklist_insert", vo);
		return res;
	}
}
