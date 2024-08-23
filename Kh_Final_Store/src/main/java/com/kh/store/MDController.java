package com.kh.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import common.Paging;
import dao.MdDAO;
import dao.PickDAO;
import dao.ProductDAO;
import dao.ReviewDAO;
import vo.MdVO;
import vo.PickVO;
import vo.ProductVO;
import vo.ReviewVO;

@Controller
public class MDController {
	@Autowired
	HttpSession session;
	
	MdDAO Md_dao;
	ProductDAO product_dao;
	ReviewDAO review_dao;
	PickDAO pick_dao;
	
	public MDController(MdDAO Md_dao, ProductDAO product_dao, ReviewDAO review_dao, PickDAO pick_dao) {
		this.Md_dao = Md_dao;
		this.product_dao = product_dao;
		this.review_dao = review_dao;
		this.pick_dao = pick_dao;
	}
	
//-------------------------------------------메인페이지 가는 메서드
	@RequestMapping(value = {"/","mainPage.do"})
	public String list(Model model) {
		
		List<MdVO> list = Md_dao.selectList();
		
		model.addAttribute("list", list);
		//포워딩
		return Common.main.VIEW_PATH + "homePage_main.jsp";
	}
	
//-------------------------------------------물건 상세페이지 메서드	
	 @RequestMapping("/PageProductList.do")
	 //원래 view.do
	 public String view(Model model, int p_idx) {	
    String c_id = (String) session.getAttribute("user");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("c_id", c_id);
    map.put("p_idx", p_idx);
    
	ProductVO vo = product_dao.select_pro(p_idx);
	List<ReviewVO> list = review_dao.selectreview(p_idx);
	//바인딩 
	model.addAttribute("vo", vo);
	model.addAttribute("c_id", c_id);
	model.addAttribute("list", list);
	
	//로그인 되었을때만 map으로 조회
	if( ((String)map.get("c_id")) != null ) {
		PickVO pick_vo = pick_dao.select_pick(map);		
		model.addAttribute("pick", pick_vo);
	}

	 //포워딩 
	 return Common.detail.VIEW_PATH + "product_detail.jsp";
	 //원래 view.jsp
	 
	 }
//-------------------------------------------관리자 물건 상세페이지 메서드	
	@RequestMapping("/adminProductList.do")
	public String admin_view(Model model, int p_idx) {	
	String c_id = (String) session.getAttribute("user");
		    
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("c_id", c_id);
	map.put("p_idx", p_idx);
		    
	ProductVO vo = product_dao.select_pro(p_idx);
	List<ReviewVO> list = review_dao.selectreview(p_idx);
	//바인딩 
	model.addAttribute("vo", vo);
	model.addAttribute("list", list);
			
	//로그인 되었을때만 map으로 조회
	if( ((String)map.get("c_id")) != null ) {
		PickVO pick_vo = pick_dao.select_pick(map);		
		model.addAttribute("pick", pick_vo);
	}
	//포워딩 
	return Common.Admin.VIEW_PATH + "admin_product_detail.jsp";
	}
//------------------------------------------md 상품 삭제
	@RequestMapping("MD_delete.do")
	public String md_delete(int p_idx) {
		Md_dao.md_delete(p_idx);
		return "redirect:product_md_check.do";
	}
//------------------------------------------md 추가
	@RequestMapping("md_insert_form.do")
	public String md_insert_form(Model model, String page) {
		
		int nowPage = 1;
		if( page != null && !page.isEmpty() ) {
			nowPage = Integer.parseInt(page);
		}
		
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<ProductVO> list = product_dao.selectprolist(map);
		
		int row_total = product_dao.getRowTotal(map);
		
		String pageMenu = Paging.getPaging(
				"md_insert_form.do", nowPage, row_total, 
				Common.Board.BLOCKLIST, 
				Common.Board.BLOCKPAGE);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
			
		return Common.Visit_product.VIEW_PATH + "md_insert.jsp";
	}
	//md 추가
	@RequestMapping("md_insert.do")
	public String md_insert(MdVO vo) {
			
		Md_dao.MD_update(vo);
			
		return "redirect:product_md_check.do";
	}
//------------------------------------------md 상품 수정
	@RequestMapping("md_modify_form.do")
	public String md_modify_form(int p_idx, Model model, String page) {
		int nowPage = 1;
		if( page != null && !page.isEmpty() ) {
			nowPage = Integer.parseInt(page);
		}
		
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
			
		List<ProductVO> list = product_dao.selectprolist(map);
		
		int row_total = product_dao.getRowTotal(map);
		
		String pageMenu = Paging.getPaging(
				"md_modify_form.do", nowPage, row_total, 
				Common.Board.BLOCKLIST, 
				Common.Board.BLOCKPAGE);
		
		MdVO vo = Md_dao.md_modify_form(p_idx);

		model.addAttribute("list", list);
		model.addAttribute("vo", vo);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.Visit_product.VIEW_PATH + "md_modify.jsp";
	}
	@RequestMapping("md_modify.do")
	public String md_modify(MdVO vo) {
		Md_dao.md_modify(vo);
		return "redirect:product_md_check.do";
	}
}
