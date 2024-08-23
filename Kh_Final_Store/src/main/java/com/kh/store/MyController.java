package com.kh.store;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.AddrDAO;
import dao.OrderDAO;
import vo.AddrVO;
import vo.OrderVO;

@Controller
public class MyController {

	@Autowired
	HttpSession session;
	
	OrderDAO order_dao;
	AddrDAO addr_dao;
	public void setOrder_dao(OrderDAO order_dao) {
		this.order_dao = order_dao;
	}
	public void setAddr_dao(AddrDAO addr_dao) {
		this.addr_dao = addr_dao;
	}

	//현준
	//주문 내역 상세 보기
	@RequestMapping("/detail.do") 
	public String list(Model model) { 
		String c_id = (String) session.getAttribute("user");
		
		List<OrderVO> list = order_dao.selectList(c_id);
		model.addAttribute("list", list);
		model.addAttribute("c_id", c_id);
	return Common.Store.VIEW_PATH + "orderlist_pay.jsp"; 
	}

	// 배송 완료 내역
	@RequestMapping("/fin.do")
	public String fin(Model model) {
		String c_id = (String) session.getAttribute("user");
		List<OrderVO> list = order_dao.selectFin(c_id);
		model.addAttribute("list", list);
		model.addAttribute("c_id", c_id);
		return Common.Store.VIEW_PATH + "orderlist_fin.jsp";
	}

	// 배송중 내역
	@RequestMapping("/ship.do")
	public String ship(Model model) {
		String c_id = (String) session.getAttribute("user");
		List<OrderVO> list = order_dao.selectShip(c_id);
		model.addAttribute("list", list);
		model.addAttribute("c_id", c_id);
		return Common.Store.VIEW_PATH + "orderlist_shipping.jsp";
	}

	// 배송 준비중 내역
	@RequestMapping("/ready.do")
	public String ready(Model model) {
		String c_id = (String) session.getAttribute("user");
		List<OrderVO> list = order_dao.selectReady(c_id);
		model.addAttribute("list", list);
		model.addAttribute("c_id", c_id);
		return Common.Store.VIEW_PATH + "orderlist_ready.jsp";
	}

	// 교환,환불 내역
	@RequestMapping("/refund.do")
	public String refund(Model model) {
		String c_id = (String) session.getAttribute("user");
		List<OrderVO> list = order_dao.selectRefund(c_id);
		model.addAttribute("list", list);
		model.addAttribute("c_id", c_id);
		return Common.Store.VIEW_PATH + "orderlist_refund.jsp";
	}

	// 주소지 추가 팝업창
	@RequestMapping("/addr_add.do")
	public String add(Model model) {
		String c_id = (String) session.getAttribute("user");
		model.addAttribute("c_id", c_id);
		return Common.Store.VIEW_PATH + "addr.jsp";
	}
	
	// 주소지 추가 등록
	@RequestMapping("addr_reg.do")
	@ResponseBody
	public String addr_reg(AddrVO vo) {
		
		addr_dao.insert(vo);
		return "<script type='text/javascript'>"
        + "window.close();" 
        + "</script>";
	}
	
	// 주소지 삭제
	@RequestMapping("addr_del.do")
	public String addr_del(AddrVO vo) {
		addr_dao.delete(vo.getIdx());
		return "redirect:mylist.do";
	}

	// 내 문의 페이지 이동
	@RequestMapping("/require_move.do")
	public String require_move() {
		return "redirect:inquire.do";
	}
	
	//배송 전 결제 취소같은 수정
	@RequestMapping("pay_del.do")
	public String pay_del(int o_idx) {
		order_dao.updatePay(o_idx);
		return "redirect:detail.do";
	}
	
	//교환(추후 교환 페이지)
	@RequestMapping("exchange.do")
	public String exchange(int o_idx) {
		order_dao.updateEx(o_idx);
		return "redirect:refund.do";
	}
	
	//환불
	@RequestMapping("refund_update.do")
	public String refund_update(int o_idx) {
		order_dao.updateRefund(o_idx);
		return "redirect:refund.do";
	}
	
}
