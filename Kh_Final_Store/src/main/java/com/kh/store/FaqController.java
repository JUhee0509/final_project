package com.kh.store;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.FaqDAO;
import vo.FaqVO;
import vo.ReviewVO;

@Controller
public class FaqController {

	// 지현
	FaqDAO faq_dao;

	@Autowired
	HttpSession session;

	public FaqController(FaqDAO faq_dao) {
		this.faq_dao = faq_dao;
	}

	// faq 첫페이지 출력
	@RequestMapping("/faq.do")
	public String select(Model model) {
		List<FaqVO> list = new ArrayList<FaqVO>();
		list = faq_dao.selectlist();
		model.addAttribute("list", list);
		return Common.Visit_faq.VIEW_PATH + "faq.jsp";
	}

	// 관리자 faq
	@RequestMapping("admin_faq.do")
	public String selectList(Model model) {
		List<FaqVO> list = new ArrayList<FaqVO>();
		list = faq_dao.selectlist();
		model.addAttribute("list", list);
		return Common.Admin.VIEW_PATH + "admin_faq.jsp";
	}

	// 새 글 등록 창 이동
	@RequestMapping("faq_reg_form.do")
	public String faq_reg_form(Model model) {
		String a_id = (String) session.getAttribute("admin");
		model.addAttribute("a_id", a_id);
		return Common.Visit_faq.VIEW_PATH + "faq_reg_form.jsp";
	}

	// 새 글 등록
	@RequestMapping("faq_insert.do")
	public String faq_insert(FaqVO vo) {
		String a_id = (String) session.getAttribute("admin");
		vo.setA_id(a_id);
		faq_dao.insert(vo);
		return "redirect:admin_faq.do";
	}

	// 질문 수정 페이지 이동
	@RequestMapping("faq_modify_form.do")
	public String review_modify_form(int idx, Model model) {
		FaqVO vo = faq_dao.selectOne(idx);
		model.addAttribute("vo", vo);
		return Common.Visit_faq.VIEW_PATH + "faq_modify.jsp";
	}

	// 수정
	@RequestMapping("faq_modify.do")
	public String faq_modify(FaqVO vo, Model model) {
		int res = faq_dao.update(vo);
		String resultstr = "";
		if (res == 1) {

			resultstr = "complete";
			model.addAttribute("resultstr", resultstr);
		}
		return "redirect:admin_faq.do";
	}

	// 삭제
	@RequestMapping("faq_del.do")
	public String delete(FaqVO vo) {
		faq_dao.delete(vo.getIdx());
		return "redirect:admin_faq.do";
	}

	// faq 조회
	@RequestMapping("faq_view.do")
	public String faq_view(int idx, Model model) {
		FaqVO vo = faq_dao.selectOne(idx);
		model.addAttribute("vo", vo);
		return Common.Admin.VIEW_PATH + "admin_faq_view.jsp";
	}

}
