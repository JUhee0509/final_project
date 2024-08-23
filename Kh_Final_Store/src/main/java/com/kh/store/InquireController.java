package com.kh.store;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import common.Paging;
import dao.InquireCommentDAO;
import dao.InquireDAO;
import vo.InquireVO;
import vo.InquirecommentVO;

@Controller
//@SessionAttributes("user") // session에 저장된 정보 가져옴
public class InquireController {

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext app;

	// 지현. 문의(+관리자 댓글포함)
	InquireDAO inq_dao;

	InquireCommentDAO inq_comm_dao;

	public InquireController(InquireDAO inq_dao, InquireCommentDAO inq_comm_dao) {
		this.inq_dao = inq_dao;
		this.inq_comm_dao = inq_comm_dao;

	}

	// 전체글 조회
	@RequestMapping("/inquire.do")
	public String selectlist(Model model, String page) {
		// @ModelAttribute("user") String user : 로그인 정보 자동으로 파라미터 받지만 안씀

		String user = (String) session.getAttribute("user");

		if (user == null || user.isEmpty()) {
			return Common.index.VIEW_PATH + "login.jsp";
		}

		int nowPage = 1;

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("start", start);
		map.put("end", end);
		map.put("user", user);

		List<InquireVO> list = inq_dao.selectlist(map);

		int row_total = inq_dao.getRowTotal(map);

		String pageMenu = Paging.getPaging("inquire.do", nowPage, row_total, Common.Board.BLOCKLIST,
				Common.Board.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Visit_inquire.VIEW_PATH + "inquire.jsp";
	}

	// 상세보기(+관리자 답변 조회)
	@RequestMapping("/inquire_view.do")
	public String admin_inqurie_view(int i_idx, Model model) {
		// 문의 조회
		InquireVO vo = inq_dao.selectOne(i_idx);
		model.addAttribute("vo", vo);

		// 답글 조회
		InquirecommentVO a_vo = inq_comm_dao.selectlist(i_idx);

		if (a_vo != null) {
			model.addAttribute("a_vo", a_vo);

		}
		return Common.Visit_inquire.VIEW_PATH + "inquire_view.jsp";
	}

	// 문의글 작성 페이지로 이동
	@RequestMapping("/inquire_write.do")
	public String inquire_write() {
		return Common.Visit_inquire.VIEW_PATH + "inquire_write.jsp";
	}

	// 문의글 작성(DB등록)
	@RequestMapping("/inq_write.do")
	public String inq_write(InquireVO vo) {

		String webPath = "/resources/upload/";
		// upload까지의 절대경로를 가져온다
		String savePath = app.getRealPath(webPath);
		System.out.println(savePath);

		// 업로드 된 파일 정보
		MultipartFile photo = vo.getPhoto();

		String image = "no_file";
		if (!photo.isEmpty()) {
			// 업로드 된 실제 파일명
			image = photo.getOriginalFilename();

			// 파일을 저장할 경로 생성
			File saveFile = new File(savePath, image);

			if (!saveFile.exists()) {
				saveFile.mkdirs();
			} else {
				// 동일 파일명이 존재하는 경우 업로드 시간을 추가하여 중복을 방지
				long time = System.currentTimeMillis();
				image = String.format("%d_%s", time, image);
				saveFile = new File(savePath, image);
			}

			try {
				photo.transferTo(saveFile);
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

		vo.setImage(image);

		inq_dao.inq_insert(vo);
		return "redirect:inquire.do";
	}

	// 문의글 수정을 위해 db조회 후 수정 폼으로 이동.
	@RequestMapping("/inq_modify.do")
	public String inq_modify(int i_idx, Model model) {
		System.out.println("수정 i_idx : " + i_idx);

		InquireVO vo = inq_dao.selectOne(i_idx);
		model.addAttribute("vo", vo);
		return Common.Visit_inquire.VIEW_PATH + "inq_modify.jsp";
	}

	// 문의글 수정(값 db에 update후 원 페이지로 복귀)
	@RequestMapping("/inq_modify_fin.do")
	@ResponseBody
	public String inq_modify_fin(InquireVO vo) {
		int res = inq_dao.inq_update(vo);

		// String result = "";
		if (res == 1) {
			return "complete";
		}

		return null;
	}

	// 문의글 삭제
	@RequestMapping("inq_del.do")
	@ResponseBody
	public String inq_del(int i_idx) {
		int res = inq_dao.inq_delete(i_idx);
		if (res == 1) {
			return "[{'result':'complete'}]";
		}

		return null;

	}

	// 관리자 문의글 조회
	@RequestMapping("/admin_inquire.do")
	public String adminSelectlist(Model model, String page) {

		int nowPage = 1;

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("start", start);
		map.put("end", end);

		List<InquireVO> list = inq_dao.adminSelectlist(map);
		System.out.println("inquire_controller : " + list.size());

		int row_total = inq_dao.adminGetRowTotal(map);

		String pageMenu = Paging.getPaging("inquire.do", nowPage, row_total, Common.Board.BLOCKLIST,
				Common.Board.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.VisitAdminInquire.VIEW_PATH + "admin_inquire.jsp";
	}

	// 관리자 문의 상세조회+관리자 답변 조회
	@RequestMapping("/admin_inquire_view.do")
	public String inqurie_view(int i_idx, Model model) {
		// 문의 조회
		InquireVO vo = inq_dao.selectOne(i_idx);
		model.addAttribute("vo", vo);

		// 답글 조회
		InquirecommentVO a_vo = inq_comm_dao.selectlist(i_idx);

		if (a_vo != null) {
			model.addAttribute("a_vo", a_vo);

		}
		return Common.VisitAdminInquire.VIEW_PATH + "admin_inquire_view.jsp";
	}

	// 관리자 답변 작성 페이지 이동
	@RequestMapping("/admin_inquire_write.do")
	public String inquire_write(int i_idx, Model model) {
		// 조회시 상태 '수정중'으로 변경
		int res = inq_dao.update_status(i_idx);

		// 답변조회
		InquireVO vo = inq_dao.selectOne(i_idx);
		model.addAttribute("vo", vo);

		model.addAttribute("i_idx", i_idx);
		return Common.VisitAdminInquire.VIEW_PATH + "admin_inquire_write.jsp";
	}

	// 관리자 답변 작성(DB등록)
	@RequestMapping("/admin_inq_write.do")
	public String inq_write(InquirecommentVO vo) {
		inq_comm_dao.adminInqInsert(vo);
		// 답변의 상태 답변완료로 전환
		inq_dao.update_status_fin(vo.getI_idx());
		return "redirect:admin_inquire.do";
	}

	// 답변 수정 페이지로 이동
	@RequestMapping("/admin_inq_modify.do")
	public String inq_modify(Integer i_idx, Model model) {// 왜 여기는 integer인지...?
		System.out.println("수정 i_idx : " + i_idx);

		// 수정하는 답변의 원본글
		InquireVO vo = inq_dao.selectOne(i_idx);
		model.addAttribute("vo", vo);

		// 수정할 답변 데이터
		InquirecommentVO a_vo = inq_comm_dao.selectOne(i_idx);
		model.addAttribute("a_vo", a_vo);
		return Common.VisitAdminInquire.VIEW_PATH + "admin_inq_modify.jsp";
	}

	// 답변 수정 완료
	@RequestMapping("/admin_inq_modify_fin.do")
	@ResponseBody
	public String inq_modify_fin(InquirecommentVO vo) {
		String admin = (String) session.getAttribute("admin");
		vo.setA_id(admin);
		int res = inq_comm_dao.inq_update(vo);
		System.out.println("수정결과(CON) : " + res);

		if (res == 1) {
			return "complete";
		}

		return null;
	}

}
