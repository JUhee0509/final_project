package dao;

import org.apache.ibatis.session.SqlSession;

public class ReviewcommentDAO {
	SqlSession sqlSession;
	public ReviewcommentDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
}
