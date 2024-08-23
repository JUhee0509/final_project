package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdministratorVO;
import vo.ConsumerVO;

public class AdministratorDAO {

	SqlSession sqlSession;

	public AdministratorDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int insertAdmin(AdministratorVO vo) {
		int res = sqlSession.insert("ad.insert_admin", vo);
		return res;
	}

	// 관리자 로그인
	public AdministratorVO selectOneAdminIDCheck(String a_id) {
		AdministratorVO vo = sqlSession.selectOne("ad.admin_check_id", a_id);
		return vo;
	}

	// 관리자 비밀번호만 업데이트 하기위한 매서드
	public int upwdatePWD(String pwd, String a_id) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("pwd", pwd);
		param.put("a_id", a_id);
		int res = sqlSession.update("ad.findPWD_update_pwd", param);
		return res;
	}

	// 관리자 이메일 인증번호
	public AdministratorVO selectOneAdminEmail(String email) {
		AdministratorVO vo = sqlSession.selectOne("ad.selectOne_Email", email);
		return vo;
	}

	// 관리자 개인정보 수정
	public int amdminUpdate(AdministratorVO vo) {
		int res = sqlSession.update("ad.admin_update", vo);
		return res;
	}
}
