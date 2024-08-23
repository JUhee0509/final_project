package com.kh.store;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.AddrDAO;
import dao.ConsumerDAO;
import vo.AddrVO;
import vo.ConsumerVO;
@Controller
public class MyPageController {
	
	@Autowired
	HttpSession session;
	
	//현준. myinfo
	ConsumerDAO consumer_dao;
	
	AddrDAO addr_dao;

	
	// 생성자
	public MyPageController(ConsumerDAO consumer_dao, AddrDAO addr_dao) {
		this.consumer_dao =consumer_dao;
		this.addr_dao = addr_dao;
	}
	
	
	//마이페이지 출력 매핑 변경했습니다.
	@RequestMapping("/mylist.do")
	public String Mypage(Model model) { 
		String c_id = (String) session.getAttribute("user");
		if(c_id == null || c_id.isEmpty() ) { 
			return Common.index.VIEW_PATH + "login.jsp"; 
			}
		List<AddrVO> list = addr_dao.selectList(c_id);
		ConsumerVO vo = consumer_dao.selectOneIDCheck(c_id);
		model.addAttribute("c_id", c_id);
		model.addAttribute("vo", vo); 
		model.addAttribute("list", list);
		return Common.Store.VIEW_PATH + "mypage.jsp"; 
		}
	
	//회원 정보 수정 폼 이동
		@RequestMapping("/modify_form.do")
		public String modify_form(Model model) {
			String c_id = (String) session.getAttribute("user");
			ConsumerVO vo = consumer_dao.member_modify_form(c_id);
			model.addAttribute("vo", vo);
			return Common.Store.VIEW_PATH + "member_modify.jsp";
		}
	
	 
}
