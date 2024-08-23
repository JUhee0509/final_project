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
import dao.CartDAO;
import dao.ConsumerDAO;
import dao.OrderDAO;
import dao.OrderdetailDAO;
import dao.ReceiptDAO;
import vo.CartVO;
import vo.ConsumerVO;
import vo.ReceiptVO;

@Controller
public class CartController {
	@Autowired
	HttpSession session;
	//장바구니 목록
	
	CartDAO cart_dao;
	
	ReceiptDAO receipt_dao;
	
	OrderdetailDAO orderdetail_dao;
	
	OrderDAO order_dao;
	
	ConsumerDAO consumer_dao;
	
	public CartController(CartDAO cart_dao, ReceiptDAO receipt_dao, OrderdetailDAO orderdetail_dao, OrderDAO order_dao, ConsumerDAO consumer_dao) {
		this.cart_dao = cart_dao;
		this.receipt_dao = receipt_dao;
		this.orderdetail_dao = orderdetail_dao;
		this.order_dao = order_dao; 
		this.consumer_dao = consumer_dao;
	}
	
	//장바구니 목록 불러오기
	@RequestMapping("cart_list.do")
	public String list(Model model) {
		String c_id = (String) session.getAttribute("user");
		
		if(c_id == null || c_id.isEmpty() ) {
			return Common.index.VIEW_PATH + "login.jsp";
		}
		List<CartVO> list = cart_dao.selectList(c_id);
		int total_price = cart_dao.selectTotalprice(c_id);
		model.addAttribute("c_id", c_id);
		model.addAttribute("total_price", total_price);
		model.addAttribute("list", list);
		for(int i = 0; list.size()>i; i++) {
			list.get(i).getC_id();
		}
		return Common.Cart.VIEW_PATH + "cartList.jsp";
	}
	
	//장바구니 목록 삭제하기
	@RequestMapping("cart_delete.do")
	public String cart_to_delete(CartVO vo) {
		
		cart_dao.delete(vo.getC_idx());
		return "redirect:cart_list.do";
	}
	
	//수량 빼기
	@RequestMapping("amount_minus.do")
	public String minus(Integer p_idx, Model model) {
		int res = cart_dao.updateMinus(p_idx); 
		String resultstr = "";
		if(res == 1) {
			
			resultstr = "complete";
			model.addAttribute("resultstr", resultstr);
		}
		
		return "redirect:cart_list.do";
	}
	
	//수량 더하기
	@RequestMapping("amount_plus.do")
	public String plus(CartVO vo, Model model) {
		cart_dao.updatePlus(vo);
		return "redirect:cart_list.do";
	}
	
	//체크시
	@RequestMapping("indi_check_on.do")
	public String checkOn(CartVO vo, Model model) {
		cart_dao.checkOn(vo);
		return "redirect:cart_list.do";
	}
	
	//체크 해제시
	@RequestMapping("indi_check_off.do")
	public String checkOff(CartVO vo, Model model) {
		cart_dao.checkOff(vo);
		return "redirect:cart_list.do";
	}
	
	//주문서 이동
	@RequestMapping("order_sheet.do")
	public String sheet(Model model) {
		String c_id = (String) session.getAttribute("user");
		List<CartVO> list = cart_dao.selectList(c_id);
		int total_price = cart_dao.selectTotalprice(c_id);
		int pay_price = cart_dao.selectPayprice(c_id);
		int bonus_point = cart_dao.selectPoint(c_id);
		List<CartVO> addr = cart_dao.selectAddr(c_id);
		
		model.addAttribute("c_id", c_id);
		model.addAttribute("total_price", total_price);
		model.addAttribute("list", list);
		model.addAttribute("pay_price", pay_price);
		model.addAttribute("bonus_point", bonus_point);
		model.addAttribute("addr", addr);
		return Common.Cart.VIEW_PATH + "order_sheet.jsp";
	}
	
	//주문완료(영수증) 이동
	@RequestMapping("pay_complete.do")
	public String pay_complete(Model model, String select, String addr, Integer[] c_idx, Integer[] p_idx, ConsumerVO cvo) {
		
		
		String c_id = (String) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", c_id);
		map.put("addr", addr);
		
		List<ReceiptVO> list = receipt_dao.selectList(map);
		ReceiptVO vo = receipt_dao.selectOne(map);
		int total_price = receipt_dao.selectTotalprice(c_id);
		int total_sale_price = receipt_dao.selectTotalsaleprice(c_id);
		consumer_dao.updatePoint(cvo);
		
		for (Integer idx : c_idx) {
		        cart_dao.delete_order(idx);
		    }
		
		for (Integer idx : p_idx) {
	        Map<String, Object> order = new HashMap<String, Object>();
	        order.put("c_id", c_id);
	        order.put("p_idx", idx);
	        order_dao.insert_order(order);
	    }
		
		model.addAttribute("addr", addr);
		model.addAttribute("select", select);
		model.addAttribute("map", map);
		model.addAttribute("list", list);
		model.addAttribute("vo", vo);
		model.addAttribute("total_price", total_price);
		model.addAttribute("total_sale_price", total_sale_price);
		return Common.Receipt.VIEW_PATH + "receipt.jsp";
	}
	
	//상세페이지에서 카트 담기
	@RequestMapping("cart.do")
	public String cart(int p_idx) { 
		String c_id = (String) session.getAttribute("user");
		if(c_id == null || c_id.isEmpty() ) {
			return Common.index.VIEW_PATH + "login.jsp";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", c_id);
		map.put("p_idx", p_idx);
			
		cart_dao.cart(map);
		return "redirect:PageProductList.do?p_idx=" + p_idx;
	}
	//상세페이지에서 주문하기
	@RequestMapping("product_order_sheet.do")
	public String product_order_sheet(int p_idx, String c_id) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", c_id);
		map.put("p_idx", p_idx);
							
		cart_dao.cart(map);
		return "redirect:order_sheet.do?c_id=" + c_id;
	}
}
