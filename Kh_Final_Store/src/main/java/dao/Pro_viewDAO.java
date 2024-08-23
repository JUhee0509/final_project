package dao;

import org.apache.ibatis.session.SqlSession;

public class Pro_viewDAO {
	// 삭제바람
	SqlSession sqlSession;

	public Pro_viewDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
}
