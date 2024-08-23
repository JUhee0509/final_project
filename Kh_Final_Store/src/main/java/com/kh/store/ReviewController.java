package com.kh.store;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.ProductDAO;
import dao.ReviewDAO;
import vo.ProductVO;
import vo.ReviewVO;

@Controller
public class ReviewController {
	ReviewDAO review_dao;
	ProductDAO product_dao;
	public ReviewController(ReviewDAO review_dao, ProductDAO product_dao) {
		this.review_dao = review_dao;
		this.product_dao = product_dao;
	}
	@Autowired
	HttpSession session;
	
	@Autowired
	ServletContext app;
	
	//내 리뷰 페이지 이동
	@RequestMapping("/review_move.do")
	public String review_list(Model model) {
		String c_id = (String) session.getAttribute("user");
		List<ReviewVO> list = review_dao.selectList(c_id);
		model.addAttribute("c_id", c_id);			
		model.addAttribute("list", list);
		return Common.Review.VIEW_PATH + "my_review_list.jsp";
	}
		
		//리뷰 작성 페이지 이동
	@RequestMapping("review_write.do")
	public String review_write(Model model, int p_idx) {
		String c_id = (String) session.getAttribute("user");
		model.addAttribute("c_id", c_id);
		model.addAttribute("p_idx", p_idx);
		return Common.Review.VIEW_PATH + "review_write.jsp";
	}
		
		//리뷰 작성
		@RequestMapping("review_insert.do")
		public String review_insert(ReviewVO vo ) {
			
			String webPath = "/resources/upload/";
			//upload까지의 절대경로를 가져온다
			String savePath = app.getRealPath(webPath);
			System.out.println(savePath);
			
			//업로드 된 파일 정보
			MultipartFile photo = vo.getPhoto();
			
			String image = "no_file";
			if( !photo.isEmpty() ) {
				//업로드 된 실제 파일명
				image = photo.getOriginalFilename();
				
				//파일을 저장할 경로 생성
				File saveFile = new File(savePath, image);
				
				if(!saveFile.exists()) {
					saveFile.mkdirs();
				}else {
					//동일 파일명이 존재하는 경우 업로드 시간을 추가하여 중복을 방지
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
			String c_id = (String) session.getAttribute("user");
			vo.setImage(image);	
			vo.setC_id(c_id);
			
			review_dao.insert(vo);
			return "redirect:review_move.do";
		}
		
		//리뷰 수정 페이지 이동
		@RequestMapping("review_modify_form.do")
		public String review_modify_form(int r_idx, Model model){
			ReviewVO vo = review_dao.selectOne(r_idx);
			model.addAttribute("vo", vo);
			return Common.Review.VIEW_PATH + "review_modify.jsp";
		}
		
		//리뷰 수정
		@RequestMapping("review_modify.do")
		public String review_modify(ReviewVO vo, Model model) {
			int res = review_dao.update(vo);
			String resultstr = "";
			if(res == 1) {
				
				resultstr = "complete";
				model.addAttribute("resultstr", resultstr);
			}
			return "redirect:review_move.do";
		}
		
		//리뷰 삭제
		@RequestMapping("review_del.do")
		public String delete(ReviewVO vo) {
			review_dao.delete(vo.getR_idx());
			return "redirect:review_move.do";
		}
		//상세페이지 리뷰
		@RequestMapping("/review.do")
		public String list(Model model, int p_idx) {
					
		ProductVO vo = product_dao.select_pro(p_idx);
					
		List<ReviewVO> list = review_dao.selectreview(p_idx);
					
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);
		//포워딩
		return Common.Review.VIEW_PATH + "review_item.jsp";
		}
		//리뷰 상세페이지
		@RequestMapping("/review_detail.do")
		public String view(Model model, int r_idx, int p_idx) {
			
		ReviewVO vo = review_dao.selectOne(r_idx);
		ProductVO vf = product_dao.select_pro(p_idx);
			
		model.addAttribute("vo", vo);
		model.addAttribute("vf", vf);
		//포워딩
		return Common.Review.VIEW_PATH + "review_detail.jsp";
		}
}
