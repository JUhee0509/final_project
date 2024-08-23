package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.ConsumerVO;

public class ConsumerDAO {
	SqlSession sqlSession;

	public ConsumerDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 마이페이지 정보 조회
	public List<ConsumerVO> selectList() {
		List<ConsumerVO> list = sqlSession.selectList("c.mypage_list");
		return list;
	}

	// 아이디 중복 확인 및 비밀번호 복호화 확인을 위한 호출
	public ConsumerVO selectOneIDCheck(String c_id) {
		ConsumerVO vo = sqlSession.selectOne("c.check_id", c_id);
		return vo;
	}

	// 회원가입 정보 저장 메서드
	public int insert(ConsumerVO vo) {
		int res = sqlSession.insert("c.insert_user", vo);
		return res;
	}

	// 아이디 찾기 메서드
	public ConsumerVO selectOneEmailFind(String email) {
		ConsumerVO vo = sqlSession.selectOne("c.ID_find_email", email);
		return vo;
	}

	// 비밀번호만 업데이트 하기위한 매서드
	public int upwdatePWD(String pwd, String c_id) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("pwd", pwd);
		param.put("c_id", c_id);
		int res = sqlSession.update("c.findPWD_update_pwd", param);
		return res;
	}

	// 개인 정보 수정 페이지로 가져오기
	public ConsumerVO member_modify_form(String c_id) {
		ConsumerVO vo = sqlSession.selectOne("c.check_id", c_id);
		return vo;
	}

	// 개인정보 수정
	public int memberUpdate(ConsumerVO vo) {
		int res = sqlSession.update("c.member_update", vo);
		return res;
	}

	// 회원 목록 가져오기
	public List<ConsumerVO> select_member_List() {
		List<ConsumerVO> list = sqlSession.selectList("c.member_list");
		return list;
	}

	// 관리자에서 회원정보 업데이트 메서드
	public int updateUserInfo(ConsumerVO vo) {
		int res = sqlSession.update("c.member_list_update", vo);
		return res;
	}

	// 관리자에서 회원정보 삭제 메서드
	public int deleteUserInfo(String c_id) {
		int res = sqlSession.delete("c.member_list_delete", c_id);
		return res;
	}

	// 관리자에서 블랙리스트 정보만 업데이트
	public int blackupdate(ConsumerVO vo) {
		int res = sqlSession.update("c.consumer_black_update", vo);
		return res;
	}	
	
	//적립금
	public int updatePoint(ConsumerVO cvo) {
		int res = sqlSession.update("c.bonus_point", cvo);
		return res;
	}
}
