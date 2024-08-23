package com.kh.store;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import common.MailSendService;
import dao.AdministratorDAO;
import dao.ConsumerDAO;
import vo.ConsumerVO;

@Controller
public class LoginController {

	// 홍경
	@Autowired
	HttpSession session;

	// 고객 DAO생성자,이메일 생성자
	ConsumerDAO consumer_dao;
	MailSendService mss;
	AdministratorDAO administrator_dao;

	public LoginController(ConsumerDAO consumer_dao, MailSendService mss, AdministratorDAO administrator_dao) {
		this.consumer_dao = consumer_dao;
		this.mss = mss;
		this.administrator_dao = administrator_dao;
	}

	// --------------------------로그인 메인 페이지
	@RequestMapping("/login_main.do")
	public String Main() {
		return Common.Login.VIEW_PATH + "login.jsp";
	}

	// -------------------로그인 아이디 찾기 페이지------------------
	// --------------------------로그인 페이지에서 회원 아이디 찾기 jsp이동.
	@RequestMapping("/storeUserFindIDForm.do")
	public String userFindID() {
		return Common.Login.VIEW_PATH + "find_ID.jsp";
	}

	// --------------------------아이디 찾기 jsp 유효성 체크.
	@RequestMapping(value = "/storeUserFindId.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userCheckID(ConsumerVO vo, String name, String email) {

		String userName = vo.getName();
		String userEmail = vo.getEmail();
		String resultStr = "";
		String result = "";

		ConsumerVO userFindEmail = consumer_dao.selectOneEmailFind(userEmail);

		System.out.println("아이디찾기 userName= " + userName);
		System.out.println("아이디찾기 userEmail= " + userEmail);

		if (userFindEmail == null) {
			result = "email_no";

		} else if (!userFindEmail.getName().equals(name)) {
			result = "user_no";

		} else {
			result = "user_yes";
		}

		resultStr = String.format("[{'result':'%s','email':'%s'}]", result, email);
		return resultStr;
	}

	// --------------------------아이디 찾기 페이지에서 회원 이름 아이디 알려주기
	@RequestMapping("show_Name_ID.do")
	public String show_ID_Name(Model model, String email) {
		ConsumerVO user = consumer_dao.selectOneEmailFind(email);
		model.addAttribute("user", user);

		return Common.Login.VIEW_PATH + "show_User_Name_ID.jsp";
	}

	// -------------------로그인 비밀번호 찾기 페이지------------------
	// --------------------------로그인 페이지에서 회원 비밀번호 찾기.
	@RequestMapping("/storeUserFindPWD.do")
	public String userFindPWD() {
		return Common.Login.VIEW_PATH + "find_PWD.jsp";
	}

	// --------------------------로그인 페이지에서 회원 비밀번호 찾기 Ajax사용.
	@RequestMapping(value = "/storeUserFindPwd.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userCheckPwd(ConsumerVO vo, String c_id, String name, String email) {

		String userC_id = vo.getC_id();
		String userName = vo.getName();
		String userEmail = vo.getEmail();

		String resultStr = "";
		String result = "";
		int res = 0;

		// 비밀번호 찾기 메서드 호출
		String findPWD = mss.findPWD_Email(email, name);
		ConsumerVO userFindEmail = consumer_dao.selectOneIDCheck(userC_id);

		System.out.println("Controller비밀번호찾기1 userC_id= " + userC_id);
		System.out.println("Controller비밀번호찾기 userName= " + userName);
		System.out.println("Controller비밀번호찾기 userEmail= " + userEmail);

		// 아이디가 없는 경우
		if (userFindEmail == null) {
			result = "c_id_no";

			// 이름이 일치하지 않는 경우
		} else if (!userFindEmail.getName().equals(name)) {
			result = "name_no";

			// email이 없는 경우
		} else if (!userFindEmail.getEmail().equals(email)) {
			result = "email_no";

			// 다 있는 경우
		} else {
			result = "user_exist";
			res = consumer_dao.upwdatePWD(findPWD, userFindEmail.getC_id());
			System.out.println("Controller비밀번호 찾기 findPWD = " + findPWD);
			System.out.println("Controller비밀번호 찾기2 userC_id = " + userC_id);
		}

		resultStr = String.format("[{'result':'%s','findPWD':'%s','res':'%d'}]", result, findPWD, res);
		return resultStr;
	}

	// -------------------로그인 메인 폼 페이지------------------
	// --------------------------로그인을 위한 페이지
	@RequestMapping("/login_form.do")
	public String LoginForm() {
		return Common.Login.VIEW_PATH + "login.jsp";
	}

	@RequestMapping(value = "/login.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Login(String c_id, String pwd) {
		ConsumerVO storeUser = consumer_dao.selectOneIDCheck(c_id);
		System.out.println("Controller 내가 입력한 c_id = " + c_id);
		String resultStr = "";
		String result = "";

		// 로그인 아이디가 없을 때
		if (storeUser == null) {
			result = "no_id";
			resultStr = String.format("[{'result':'%s'}]", result);
			return resultStr;
		}

		// 블랙리스트 여부가 있을 때
		if (storeUser.getBlacklist() == 1) {
			result = "blacklist_user";
			resultStr = String.format("[{'result':'%s'}]", result);
			return resultStr;
		}

		// 비밀번호가 일치하지 않을 때
		boolean isValid = Common.SecurePwd.decodePwd(c_id, pwd, consumer_dao);
		System.out.println("Controller isValid = " + isValid);
		if (!isValid) {
			result = "no_pwd";
			resultStr = String.format("[{'result':'%s'}]", result);
			return resultStr;
		}

		// 로그인 성공했을 때
		result = "success";
		session.setAttribute("user", storeUser.getC_id());// 여기 수정함.

		resultStr = String.format("[{'result':'%s','c_id':'%s'}]", result, c_id);
		return resultStr;
	}

	// 로그아웃클릭시
	@RequestMapping("logout.do")
	public String logout() {
		System.out.println("로그아웃");
		session.setAttribute("user", null);
		return "redirect:mainPage.do";
	}

	// --------------------------회원가입을 위한 페이지
	@RequestMapping("/member_join_form.do")
	public String MemberJoinForm() {
		return Common.Login.VIEW_PATH + "join.jsp";
	}

	// --------------------------회원가입 아이디 중복체크 메서드
	@RequestMapping("/duplicate_checkID.do")
	@ResponseBody
	public String MemberJoinCheckID(String c_id) {
		ConsumerVO vo = new ConsumerVO();
		vo.setC_id(c_id);
		System.out.println(c_id);

		ConsumerVO userID_Check = consumer_dao.selectOneIDCheck(c_id);
		System.out.println("userID_Check = " + userID_Check);
		// 입력한 id가 사용 가능할 때
		if (userID_Check == null) {
			return "[{'param':'success'}]";
		} else {
			return "[{'param':'fail'}]";
		}

	}

	// -----------------------회원가입 이메일 인증번호 메서드
	@RequestMapping("/mailCheck.do")
	@ResponseBody
	public String emailCheck(ConsumerVO vo, String email) {
		System.out.println("인증요청 받음 : " + email);
		String res = "";
		String resultStr = "";
		String result = "fail";

		// 중복 이메일 확인을 위해 불러옴.
		ConsumerVO check_userEmail = consumer_dao.selectOneEmailFind(email);

		if (check_userEmail == null) {
			result = "success";
			res = mss.joinEmail(email);
		} else {
			result = "fail";
		}
		resultStr = String.format("[{'result':'%s','res':'%s'}]", result, res);
		System.out.println("res = " + res);
		return resultStr;
	}

	// ----------------------회원가입 전제정보 저장 메서드
	// produces="application/json;charset=UTF-8"
	// 매핑 앞에 value값을 넣어주고 위의 코드를 추가해 줘야
	// json으로 넘어올 때 한글 오류가 안난다.
	@RequestMapping(value = "/join_insert.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String joinResult(ConsumerVO vo) {
		System.out.println("con : " + vo.getC_id());

		System.out.println("회원가입 이메일= " + vo.getEmail());

		String resultStr = "";
		String result = "fail";

		System.out.println("name=" + vo.getName());

		// 비밀번호 암호화를 위한 클래스 호출
		String encodePwd = Common.SecurePwd.encodePwd(vo.getPwd());
		vo.setPwd(encodePwd);
		System.out.println("encodePwd, vo.getPwd= " + vo.getPwd());

		int res = consumer_dao.insert(vo);
		if (res == 1) {
			result = "success";
		}
		resultStr = String.format("[{'result':'%s','name':'%s'}]", result, vo.getName());
		return resultStr;
	}

	// 회원정보 수정
	@RequestMapping(value = "/member_modify.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String member_modify(ConsumerVO vo, String c_id) {
		String resultStr = "";
		String result = "fail";

		// 비밀번호 암호화를 위한 클래스 호출
		String encodePwd = Common.SecurePwd.encodePwd(vo.getPwd());
		vo.setPwd(encodePwd);

		int res = consumer_dao.memberUpdate(vo);
		if (res == 1) {
			result = "success";
		}
		resultStr = String.format("[{'result':'%s','name':'%s'}]", result, vo.getName());
		return resultStr;
	}

	// --------------------------회원정보 수정을 위한 메서드
	@RequestMapping("/modify_user_mailCheck.do")
	@ResponseBody
	public String ModifyemailCheck(ConsumerVO vo, String email) {
		System.out.println("인증요청 받음 : " + email);
		String res = "";
		String resultStr = "";
		String result = "fail";
		String user_id = (String)session.getAttribute("user");
		System.out.println("user_id= "+user_id);
		
		// 중복 이메일 확인을 위해 불러옴.
		ConsumerVO check_userEmail = consumer_dao.member_modify_form(user_id);

		if (check_userEmail.getEmail().equals(email)) {
			result = "success";
			res = mss.modifyUserEmail(email);
		} else {
			result = "fail";
		}
		resultStr = String.format("[{'result':'%s','res':'%s'}]", result, res);
		System.out.println("res = " + res);
		return resultStr;
	}

}
