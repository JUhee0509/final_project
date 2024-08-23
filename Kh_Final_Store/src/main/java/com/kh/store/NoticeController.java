package com.kh.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import common.Paging;
import dao.NoticeDAO;
import vo.NoticeVO;

@Controller
public class NoticeController {

	// 지현. 공지사항
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;

	NoticeDAO notice_dao;

	// 생성자
	public NoticeController(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}

	// 공지사항 첫 페이지 전체 목록 출력
	@RequestMapping("/notice.do")
	public String notice_list(Model model, String page) {

		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		System.out.println("start/end : " + start + "/" + end);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		List<NoticeVO> list = notice_dao.selectlist(map);

		int row_total = notice_dao.getRowTotal(map);

		String pageMenu = Paging.getPaging("notice.do", nowPage, row_total, Common.Board.BLOCKLIST,
				Common.Board.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Visit_notice.VIEW_PATH + "notice.jsp";
	}

	// 공지사항 상세보기
	@RequestMapping("/notice_view.do")
	public String notice_view(int idx, Model model) {
		NoticeVO vo = notice_dao.selectOne(idx);
		model.addAttribute("vo", vo);
		return Common.Visit_notice.VIEW_PATH + "notice_view.jsp";
	}

	/*
	 * // board 메뉴 이동. 추후 수정예정
	 * 
	 * @RequestMapping("/board.do") public String board() { return
	 * Common.Visit_board.VIEW_PATH + "board.jsp"; }
	 */

	/*
	 * // 공지 등록
	 * 
	 * @RequestMapping("/notice_fin.do") public String notice_fin(NoticeVO vo) {
	 * System.out.println("con : " + vo.getTitle() + "/" + vo.getContent());
	 * notice_dao.insert(vo); return "redirect:notice.do"; }
	 */

	// 관리자 notice
	// 공지사항 첫 페이지 전체 목록 출력
	@RequestMapping("/admin_notice.do")
	public String admin_notice_list(Model model, String page) {

		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		System.out.println("start/end : " + start + "/" + end);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		List<NoticeVO> list = notice_dao.selectlist(map);
		System.out.println("controller : " + list.size());

		int row_total = notice_dao.getRowTotal(map);

		String pageMenu = Paging.getPaging("notice.do", nowPage, row_total, Common.Board.BLOCKLIST,
				Common.Board.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.VisitAdminNotice.VIEW_PATH + "admin_notice.jsp";
	}

	// 공지사항 상세보기
	@RequestMapping("/admin_notice_view.do")
	public String admin_notice_view(int idx, Model model) {
		NoticeVO vo = notice_dao.selectOne(idx);
		model.addAttribute("vo", vo);
		return Common.VisitAdminNotice.VIEW_PATH + "admin_notice_view.jsp";
	}

	// 관리자 권한 : 공지작성
	@RequestMapping("/admin_notice_form.do")
	public String admin_notice_form() {
		return Common.VisitAdminNotice.VIEW_PATH + "admin_notice_form.jsp";
	}
	

	// 공지 등록
	@RequestMapping("/notice_fin.do")
	public String admin_notice_fin(NoticeVO vo) {
		String admin = (String) session.getAttribute("admin");
		vo.setA_id(admin);
		System.out.println("con : " + vo.getTitle() + "/" + vo.getContent());
		notice_dao.insert(vo);
		return "redirect:admin_notice.do";
	}

	// 공지 삭제
	@RequestMapping("admin_delete_notice.do")
	@ResponseBody
	public String admin_delete_notice(int idx) {
		int res = notice_dao.delete_notice(idx);

		if (res == 1) {
			return "complete";
		}

		return null;
	}

	// 공지 수정으로 이동
	@RequestMapping("admin_modify_notice.do")
	public String admin_modify_notice(int idx, Model model) {
		NoticeVO vo = notice_dao.selectOne(idx);
		model.addAttribute("vo", vo);
		return Common.VisitAdminNotice.VIEW_PATH + "admin_notice_modify.jsp";
	}

	// 공지 수정
	@RequestMapping("admin_modify_fin.do")
	public String admin_modify_fin(NoticeVO vo, Model model) {
		String admin = (String) session.getAttribute("admin");
		vo.setA_id(admin);

		System.out.println("controller의 idx : " + vo.getIdx());
		notice_dao.update_notice(vo);
		model.addAttribute("vo", vo);

		return "redirect:admin_notice_view.do";
	}
}
