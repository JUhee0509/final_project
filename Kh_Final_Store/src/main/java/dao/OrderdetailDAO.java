package dao;


import org.apache.ibatis.session.SqlSession;




public class OrderdetailDAO {
	SqlSession sqlSession;
	public OrderdetailDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int selectOne(String c_id) {
		int res = sqlSession.selectOne("od.select_one", c_id);
		return res;
	}
}
