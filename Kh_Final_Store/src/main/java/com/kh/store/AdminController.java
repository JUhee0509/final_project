package com.kh.store;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import common.MailSendService;
import dao.AdministratorDAO;
import dao.BlacklistDAO;
import dao.ConsumerDAO;
import dao.InquireCommentDAO;
import dao.InquireDAO;
import dao.MdDAO;
import dao.NoticeDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.ReviewDAO;
import common.Paging;
import vo.AdministratorVO;
import vo.BlacklistVO;
import vo.ConsumerVO;
import vo.MdVO;
import vo.OrderVO;
import vo.ProductVO;
import vo.ReviewVO;

@Controller
public class AdminController {

	@Autowired
	ServletContext app;

	@Autowired
	HttpSession session;

	MdDAO md_dao;
	ProductDAO product_dao;
	AdministratorDAO admin_dao;
	ConsumerDAO consumer_dao;
	NoticeDAO notice_dao;
	OrderDAO order_dao;
	BlacklistDAO black_dao;
	MailSendService mss;
	ReviewDAO review_dao;

	// 생성자
	@Autowired
	public AdminController(AdministratorDAO admin_dao, MdDAO md_dao, ConsumerDAO consumer_dao, ProductDAO product_dao,
			MailSendService mss, OrderDAO order_dao, NoticeDAO notice_dao, BlacklistDAO black_dao,
			ReviewDAO review_dao) {
		this.admin_dao = admin_dao;
		this.md_dao = md_dao;
		this.product_dao = product_dao;
		this.consumer_dao = consumer_dao;
		this.mss = mss;
		this.order_dao = order_dao;
		this.notice_dao = notice_dao;
		this.black_dao = black_dao;
		this.review_dao = review_dao;
	}

	// --------------------------관리자 로그인 메인 페이지
	@RequestMapping("/admin_login_main.do")
	public String Admin_Main() {
		return Common.Admin.VIEW_PATH + "admin_login.jsp";
	}

	// --------------------------관리자 로그인 아이디 찾기.jsp
	@RequestMapping("admin_find_ID.do")
	public String Admin_findID() {
		return Common.Admin.VIEW_PATH + "admin_find_ID.jsp";
	}

	// --------------------------관리자 로그인 아이디 찾기
	@RequestMapping(value = "AdminFindId.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Admin_find_ID_jsp(AdministratorVO vo, String name, String email) {
		String resultStr = "";
		String result = "";

		AdministratorVO adminFindEmail = admin_dao.selectOneAdminEmail(vo.getEmail());
		System.out.println("입력 이메일 =" + email);

		if (adminFindEmail == null) {
			result = "email_no";

		} else if (!adminFindEmail.getName().equals(name)) {
			result = "user_no";

		} else {
			result = "user_yes";
		}

		resultStr = String.format("[{'result':'%s','email':'%s'}]", result, email);
		return resultStr;
	}

	// --------------------------관리자 로그인 아이디 결과.jsp
	@RequestMapping("Admin_show_Name_ID.do")
	public String Admin_showID(Model model, String email) {
		AdministratorVO admin = admin_dao.selectOneAdminEmail(email);
		model.addAttribute("admin", admin);
		return Common.Admin.VIEW_PATH + "admin_show_ID.jsp";
	}

	// --------------------------관리자 로그인 비밀번호 찾기.jsp
	@RequestMapping("admin_find_PWD.do")
	public String Admin_find_PWD() {
		return Common.Admin.VIEW_PATH + "admin_find_PWD.jsp";
	}

	// --------------------------관리자 로그인 비밀번호 찾기.jsp
	@RequestMapping(value = "/adminFindPwd.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Admin_show_PWD(AdministratorVO vo, String a_id, String name, String email) {
		String resultStr = "";
		String result = "";
		int res = 0;

		// 비밀번호 찾기 메서드 호출
		String findPWD = mss.findPWD_Email(email, name);
		AdministratorVO adminFindEmail = admin_dao.selectOneAdminIDCheck(vo.getA_id());

		// 아이디가 없는 경우
		if (adminFindEmail == null) {
			result = "a_id_no";

			// 이름이 일치하지 않는 경우
		} else if (!adminFindEmail.getName().equals(name)) {
			result = "name_no";

			// email이 없는 경우
		} else if (!adminFindEmail.getEmail().equals(email)) {
			result = "email_no";

			// 다 있는 경우
		} else {
			result = "user_exist";
			res = admin_dao.upwdatePWD(findPWD, adminFindEmail.getA_id());
			System.out.println("Controller비밀번호 찾기 findPWD = " + findPWD);
			System.out.println("Controller비밀번호 찾기2 userC_id = " + vo.getA_id());
		}

		resultStr = String.format("[{'result':'%s','findPWD':'%s','res':'%d'}]", result, findPWD, res);
		return resultStr;
	}

	// ------------------------------------------관리자 로그인
	@RequestMapping(value = "/admin_login.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Admin_Login(String a_id, String pwd) {
		AdministratorVO storeAdmin = admin_dao.selectOneAdminIDCheck(a_id);
		System.out.println("Controller 내가 입력한 a_id = " + a_id);
		String resultStr = "";
		String result = "";

		// 로그인 아이디가 없을 때
		if (storeAdmin == null) {
			result = "no_id";
			resultStr = String.format("[{'result':'%s'}]", result);
			return resultStr;
		}

		// 관리자 로그인 중 비밀번호가 일치하지 않을때
		// 비밀번호 복호화
		boolean isValid = Common.SecurePwd.decodePwd_admin(a_id, pwd, admin_dao);
		System.out.println("Controller isValid = " + isValid);
		if (!isValid) {
			result = "no_pwd";
			resultStr = String.format("[{'result':'%s'}]", result);
			return resultStr;
		}

		// 로그인 성공했을 때
		result = "success";
		session.setAttribute("admin", storeAdmin.getA_id()); // 여기 수정함.

		resultStr = String.format("[{'result':'%s','a_id':'%s'}]", result, a_id);
		return resultStr;
	}

	// --------------------------------관리자 정보 수정 메서드
	@RequestMapping("admin_modify_form.do")
	public String admin_modify_form(Model model, String a_id) {
		String admin_id = (String) session.getAttribute("admin");
		AdministratorVO vo = admin_dao.selectOneAdminIDCheck(admin_id);
		model.addAttribute("vo", vo);

		return Common.Admin.VIEW_PATH + "admin_modify_form.jsp";
	}

	// 관리자 정보 수정
	@RequestMapping(value = "/admin_modify.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String admin_modify(AdministratorVO vo, String c_id) {
		String resultStr = "";
		String result = "fail";

		// 비밀번호 암호화를 위한 클래스 호출
		String encodePwd = Common.SecurePwd.encodePwd(vo.getPwd());
		vo.setPwd(encodePwd);

		int res = admin_dao.amdminUpdate(vo);
		if (res == 1) {
			result = "success";
		}
		resultStr = String.format("[{'result':'%s','name':'%s'}]", result, vo.getName());
		return resultStr;
	}

	// --------------------------관리자 정보 수정을 위한 메서드
	@RequestMapping("/modify_admin_mailCheck.do")
	@ResponseBody
	public String ModifyAdminemailCheck(AdministratorVO vo, String email) {
		System.out.println("인증요청 받음 : " + email);
		String res = "";
		String resultStr = "";
		String result = "fail";
		String admin_id = (String) session.getAttribute("admin");

		// 중복 이메일 확인을 위해 불러옴.
		AdministratorVO check_adminEmail = admin_dao.selectOneAdminIDCheck(admin_id);

		if (check_adminEmail.getEmail().equals(email)) {
			result = "success";
			res = mss.modifyAdminEmail(email);
		} else if (!check_adminEmail.getEmail().equals(email)) {
			result = "fail";
		}
		resultStr = String.format("[{'result':'%s','res':'%s'}]", result, res);
		System.out.println("res = " + res);
		return resultStr;
	}

	// --------------------------------관리자 메인 페이지
	@RequestMapping("admin_mainPage.do")
	public String list(Model model) {
		List<MdVO> list = md_dao.selectList();
		model.addAttribute("list", list);
		return Common.Admin.VIEW_PATH + "admin_main.jsp";
	}

	// 로그아웃클릭시
	@RequestMapping("admin_logout.do")
	public String logout() {
		System.out.println("로그아웃");
		session.removeAttribute("admin");// 아예 지우는 걸로 변경함
		return "redirect:mainPage.do";
	}

	// 관리자 회원가입 페이지로 이동하는 메서드
	@RequestMapping("/admin_join_form.do")
	public String adminPage() {
		return Common.Admin.VIEW_PATH + "admin_join_page.jsp";
	}

	// 관리자 아이디 중복확인 메서드
	@RequestMapping("/duplicate_check_adminID.do")
	@ResponseBody
	public String AdminJoinCheckID(String a_id) {
		AdministratorVO vo = new AdministratorVO();
		vo.setA_id(a_id);
		System.out.println("a_id = " + a_id);

		AdministratorVO adminID_Check = admin_dao.selectOneAdminIDCheck(a_id);

		if (adminID_Check == null) {
			return "[{'result':'success'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}

	// ------------------관리자 회원가입 메서드
	@RequestMapping(value = "/join_admin_insert.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String joinResult(AdministratorVO vo) {
		System.out.println("con : " + vo.getA_id());

		System.out.println("관리자 회원가입 이메일= " + vo.getEmail());

		String resultStr = "";
		String result = "fail";

		System.out.println("name=" + vo.getName());

		// 관리자 회원가입 중 비밀번호 암호화를 위한 클래스 호출
		String encodePwd = Common.SecurePwd.encodePwd(vo.getPwd());
		vo.setPwd(encodePwd);
		System.out.println("encodePwd, vo.getPwd= " + vo.getPwd());

		int res = admin_dao.insertAdmin(vo);
		if (res == 1) {
			result = "success";
		}
		resultStr = String.format("[{'result':'%s','name':'%s'}]", result, vo.getName());
		return resultStr;
	}

	// 관리자 회원가입 이메일 인증번호 메서드
	@RequestMapping("/admin_mailCheck.do")
	@ResponseBody
	public String admin_email_check(AdministratorVO vo, String email) {
		System.out.println("인증요청 받음 : " + email);
		String res = "";
		String resultStr = "";
		String result = "fail";

		AdministratorVO check_adminEMail = admin_dao.selectOneAdminEmail(email);

		if (check_adminEMail == null) {
			result = "success";
			res = mss.AdminCheckEmail(email);
		} else {
			result = "fail";
		}
		resultStr = String.format("[{'result':'%s','res':'%s'}]", result, res);
		System.out.println("관리자 res = " + res);
		return resultStr;

	}

	// -------------------------고객 리스트 가져오기 위한 메서드 board.jsp파일에서 가져옴
	// -------------------------추후 admin페이지로 옮겨야 함.
	// ---------------고객센터---------------
	// 고객관리 페이지 이동
	@RequestMapping("/customer_admin.do")
	public String cumstomer_admin(Model model) {

		List<ConsumerVO> list = consumer_dao.select_member_List();
		model.addAttribute("list", list);

		return Common.VisitAdminCumstomer.VIEW_PATH + "customer_admin.jsp";
	}

	// ---------------고객센터---------------
	// selectOne으로 수정 버튼 누른 회원 정보 가져오기
	@RequestMapping("/user_modifyForm_admin.do")
	public String modify_user_admin(Model model, String c_id) {
		ConsumerVO vo = consumer_dao.selectOneIDCheck(c_id);
		model.addAttribute("vo", vo);

		return Common.VisitAdminCumstomer.VIEW_PATH + "admin_member_update_form.jsp";
	}

	// ---------------고객센터---------------
	// 회원정보 업데이트 하기 위한 메서드
	@RequestMapping("/update_member_input.do")
	@ResponseBody
	public String update_member_info(ConsumerVO vo) {
		int res = consumer_dao.updateUserInfo(vo);
		System.out.println("res = " + res);
		String result = "no";
		if (res > 0) {
			result = "yes";
			return result;
		}
		return result;
	}

	// ---------------고객센터---------------
	// 회원정보 삭제를 위한 메서드
	@RequestMapping("user_deleteForm_admin.do")
	@ResponseBody
	public String delete_member_info(String c_id) {
		int res = consumer_dao.deleteUserInfo(c_id);

		String result = "no";
		if (res > 0) {
			result = "yes";
			return result;
		}
		return result;
	}

	// --------------고객센터-------------
	// 회원 블랙리스트 추가
	@RequestMapping("/member_black_form.do")
	public String blacklist_form(Model model, String c_id) {
		ConsumerVO vo = consumer_dao.selectOneIDCheck(c_id);
		model.addAttribute("vo", vo);

		return Common.VisitAdminCumstomer.VIEW_PATH + "blacklist_form_admin.jsp";
	}

	// 블랙리스트 form 작성 후 아이디 체크
	@RequestMapping("blacklist_insert_form.do")
	@ResponseBody
	public String blacklist_insert(ConsumerVO consumer, BlacklistVO black, String a_id) {
		String resultStr = "";
		String result = "";
		String admin_id = (String) session.getAttribute("admin");

		if (a_id.equals(admin_id)) {
			int user_black_reason = black_dao.blackinsert(black); // 회원 사유 작성
			int user_black = consumer_dao.blackupdate(consumer); // 회원 blacklist컬럼 업데이트
			result = "success";
		} else {
			result = "fail";
		}
		resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}

	// ----------제품리스트------------------
	@RequestMapping("/product_check.do")
	public String product_list_check(Model model, String page, String[] brand, String search) {
		
		int nowPage = 1;
		if( page != null && !page.isEmpty() ) {
			nowPage = Integer.parseInt(page);
		}
		
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		
		String[] array = { "brand" };
		// 검색기준 조회
		Map<String, String> standardMap = new HashMap<String, String>();
		for (int i = 0; i < array.length; i++) {
			standardMap.put("standard", array[i]);
			List<Object> standardList = product_dao.selectBrand(standardMap);

			model.addAttribute(array[i], standardList);

		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("brand", brand);
		map.put("start", start);
		map.put("end", end);
		List<ProductVO> list = product_dao.selectprolist(map);
		
		int row_total = product_dao.getRowTotal(map);
		
		String pageMenu = Paging.getPaging(
				"product_check.do", nowPage, row_total, 
				Common.Board.BLOCKLIST, 
				Common.Board.BLOCKPAGE);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.Admin.VIEW_PATH + "admin_product_list.jsp";
	}

	// ---------제품 등록 페이지로 이동-----------------
	@RequestMapping("product_insert_form.do")
	public String product_insert_form() {
		return Common.Visit_product.VIEW_PATH + "product_insert.jsp";
	}

	// ---------새 제품 등록-----------------
	@RequestMapping("/product_insert.do")
	public String product_insert(ProductVO vo) {

		// upload까지의 절대경로를 가져온다
		String webPath = "/resources/upload/";
		String savePath = app.getRealPath(webPath);

		// 업로드된 파일 주소
		System.out.println(savePath);

		// 업로드된 파일 정보
		MultipartFile s_image_url = vo.getS_image_url();
		MultipartFile l_image_url = vo.getL_image_url();
		MultipartFile ad_image_url = vo.getAd_image_url();

		String s_image = "no_file";
		String l_image = "no_file";
		String ad_image = "no_file";

		if (!s_image_url.isEmpty() && !l_image_url.isEmpty() && !ad_image_url.isEmpty()) {
			// 업로드 된 실제 파일명
			s_image = s_image_url.getOriginalFilename();
			l_image = l_image_url.getOriginalFilename();
			ad_image = ad_image_url.getOriginalFilename();

			// 파일을 저장할 경로 생성
			File s_saveFile = new File(savePath, s_image);
			File l_saveFile = new File(savePath, l_image);
			File ad_saveFile = new File(savePath, ad_image);

			// ......resources/upload/a.jpg
			if (!s_saveFile.exists()) {
				s_saveFile.mkdirs();
			}

			if (!l_saveFile.exists()) {
				l_saveFile.mkdirs();
			}

			if (!ad_saveFile.exists()) {
				ad_saveFile.mkdirs();
			}

			// 동일파일명이 존재하는 경우 업로드시간을 추가하여 중복을 방지하자
			long time = System.currentTimeMillis();
			s_image = String.format("%d_%s", time, s_image);
			l_image = String.format("%d_%s", time, l_image);
			ad_image = String.format("%d_%s", time, ad_image);
			s_saveFile = new File(savePath, s_image);
			l_saveFile = new File(savePath, l_image);
			ad_saveFile = new File(savePath, ad_image);

			try {
				s_image_url.transferTo(s_saveFile);
				l_image_url.transferTo(l_saveFile);
				ad_image_url.transferTo(ad_saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		vo.setS_image(s_image);
		vo.setL_image(l_image);
		vo.setAd_image(ad_image);
		product_dao.product_update(vo);

		return "redirect:product_check.do";
	}

	// 제품 삭제
	@RequestMapping("product_delete.do")
	public String product_delete(int p_idx) {
		product_dao.product_delete(p_idx);
		return "redirect:product_check.do";
	}

	// 제품 수정 폼 이동
	@RequestMapping("product_modify_form.do")
	public String product_modify_form(int p_idx, Model model) {
		ProductVO vo = product_dao.product_modify_form(p_idx);
		model.addAttribute("vo", vo);
		return Common.Visit_product.VIEW_PATH + "product_modify.jsp";
	}

	// 제품 수정
	@RequestMapping("product_modify.do")
	public String product_modify(ProductVO vo) {
		// upload까지의 절대경로를 가져온다
		String webPath = "/resources/upload/";
		String savePath = app.getRealPath(webPath);

		// 업로드된 파일 주소
		System.out.println(savePath);

		// 업로드된 파일 정보
		MultipartFile s_image_url = vo.getS_image_url();
		MultipartFile l_image_url = vo.getL_image_url();
		MultipartFile ad_image_url = vo.getAd_image_url();

		String s_image = "no_file";
		String l_image = "no_file";
		String ad_image = "no_file";

		if (!s_image_url.isEmpty() && !l_image_url.isEmpty() && !ad_image_url.isEmpty()) {
			// 업로드 된 실제 파일명
			s_image = s_image_url.getOriginalFilename();
			l_image = l_image_url.getOriginalFilename();
			ad_image = ad_image_url.getOriginalFilename();

			// 파일을 저장할 경로 생성
			File s_saveFile = new File(savePath, s_image);
			File l_saveFile = new File(savePath, l_image);
			File ad_saveFile = new File(savePath, ad_image);

			if (!s_saveFile.exists()) {
				s_saveFile.mkdirs();
			}

			if (!l_saveFile.exists()) {
				l_saveFile.mkdirs();
			}

			if (!ad_saveFile.exists()) {
				ad_saveFile.mkdirs();
			}

			// 동일파일명이 존재하는 경우 업로드시간을 추가하여 중복을 방지하자
			long time = System.currentTimeMillis();
			s_image = String.format("%d_%s", time, s_image);
			l_image = String.format("%d_%s", time, l_image);
			ad_image = String.format("%d_%s", time, ad_image);
			s_saveFile = new File(savePath, s_image);
			l_saveFile = new File(savePath, l_image);
			ad_saveFile = new File(savePath, ad_image);

			try {
				s_image_url.transferTo(s_saveFile);
				l_image_url.transferTo(l_saveFile);
				ad_image_url.transferTo(ad_saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		vo.setS_image(s_image);
		vo.setL_image(l_image);
		vo.setAd_image(ad_image);
		int res = product_dao.product_modify(vo);

		return "redirect:product_check.do";
	}

	// 주문 관리 페이지 이동
	@RequestMapping("order_manager.do")
	public String adminorder(Model model) {
		
		List<OrderVO> list = order_dao.selectadminList();
		
		model.addAttribute("list", list);
		
		return Common.Admin.VIEW_PATH + "admin_order.jsp";
	}

	// 배송준비중으로 변경(관리자)
	@RequestMapping("order_ready.do")
	public String order_ready(int o_idx) {
		order_dao.updateReady(o_idx);
		return "redirect:order_manager.do";
	}

	// 배송중으로 변경
	@RequestMapping("order_shipping.do")
	public String order_shipping(int o_idx) {
		order_dao.updateShip(o_idx);
		return "redirect:order_manager.do";
	}

	// 배송중으로 변경
	@RequestMapping("order_complete.do")
	public String order_complete(int o_idx) {
		order_dao.updateComplete(o_idx);
		return "redirect:order_manager.do";
	}

	// 교환으로 변경
	@RequestMapping("order_exchange.do")
	public String order_exchange(int o_idx) {
		order_dao.updateEx(o_idx);
		return "redirect:order_manager.do";
	}

	// 환불로 변경
	@RequestMapping("order_refund.do")
	public String order_refund(int o_idx) {
		order_dao.updateRefund(o_idx);
		return "redirect:order_manager.do";
	}

	// 취소로 변경
	@RequestMapping("order_cancel.do")
	public String order_cancel(int o_idx) {
		order_dao.updatePay(o_idx);
		return "redirect:order_manager.do";
	}

	// MD 관리 페이지 이동
	@RequestMapping("product_md_check.do")
	public String product_md_check(Model model) {
		List<MdVO> list = md_dao.selectList();

		model.addAttribute("list", list);
		// 포워딩
		return Common.Admin.VIEW_PATH + "admin_product_md.jsp";
	}

	// 통계 페이지로 이동
	@RequestMapping("chart.do")
	public String chart() {
		return Common.VisitStatic.VIEW_PATH + "chart.jsp";
	}

	// chart

	@RequestMapping("chart_select.do")
	@ResponseBody
	public List<ProductVO> chart_select() {
		List<ProductVO> list = product_dao.selectProduct();
		return list;
	}

	// 관리자 리뷰 관리
	@RequestMapping("review_check.do")
	public String review_list(Model model) {
		List<ReviewVO> list = review_dao.selectList();
		model.addAttribute("list", list);
		return Common.Admin.VIEW_PATH + "admin_review.jsp";
	}

	// 관리자 리뷰 삭제
	@RequestMapping("review_delete.do")
	public String review_delete(int r_idx) {
		review_dao.delete(r_idx);
		return "redirect:review_check.do";
	}

	// 관리자메뉴>게시판 관리
	@RequestMapping("admin_board.do")
	public String admin_board() {
		return "redirect:admin_notice.do";
	}
}
