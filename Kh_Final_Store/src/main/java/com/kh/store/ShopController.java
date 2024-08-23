package com.kh.store;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.PickDAO;
import dao.ProductDAO;
import vo.ProductVO;

@Controller
public class ShopController {
	// 지현 . SHOP
	// 컨트롤러 생성시 어노테이션 필수로 추가
	// service없다면 dao 참조, service 있다면 dao를 가지고 있는 service참조

	@Autowired
	ServletContext app;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	ProductDAO product_dao;
	PickDAO pick_dao;

	public ShopController(ProductDAO product_dao, PickDAO pick_dao) {
		this.product_dao = product_dao;
		this.pick_dao = pick_dao;
	}

	// shop 페이지의 전체목록 출력
	@RequestMapping("/shop_list.do")
	public String list(Model model, String[] brand, String[] scent, String[] price, String[] volume, String search,
			String gender, String optional) {

// 검색기준
		String[] array = { "brand", "scent", "volume" };

		// 검색기준 조회
		Map<String, String> standardMap = new HashMap<String, String>();
		for (int i = 0; i < array.length; i++) {
			standardMap.put("standard", array[i]);
			List<Object> standardList = product_dao.selectBrand(standardMap);

			model.addAttribute(array[i], standardList);

		} // for

		// 검색 기준 중 가격
		int productMax = product_dao.selectPrice();

		int max = 0;

		if (productMax % 20000 == 0) {
			max = productMax;
		} else {
			max = productMax + (20000 - productMax % 20000);
		}

		max /= 10000;
		model.addAttribute("price", max);

		List<Map<String, Integer>> priceList = new ArrayList<Map<String, Integer>>();

		int maxPrice = 0;
		int minPrice = 0;

		if (price != null) {
			for (String str : price) {

				if (str.equals("under_10")) {
					minPrice = 0;
					maxPrice = 100000;
					System.out.println("첫번째 요소");
				} else {

					minPrice = Integer.parseInt(str.substring(0, 2)) * 10000;
					maxPrice = Integer.parseInt(str.substring(str.length() - 2)) * 10000;
					System.out.println("두번째 요소");
				}
				Map<String, Integer> priceMap = new HashMap<String, Integer>();

				priceMap.put("min", minPrice);
				priceMap.put("max", maxPrice);

				System.out.println("min : " + minPrice + ", max : " + maxPrice);

				priceList.add(priceMap);
			} // for
		}

		// 상품 조회
		Map<String, Object> map = new HashMap<String, Object>();

		if (price != null) {
			for (String str : price) {
				System.out.println(str);
			}
		}

		// 검색
		map.put("brand", brand);
		map.put("scent", scent);
		map.put("volume", volume);
		map.put("price", priceList);
		map.put("search", search);
		map.put("gender", gender);

		// 정렬
		map.put("optional", optional);

		// 상품 조회
		List<ProductVO> list = product_dao.selectlist(map);

		model.addAttribute("list", list);

		return Common.Visit_shop.VIEW_PATH + "shop_list.jsp";

	}
	// adminController쪽으로 위치 변경 했습니다
	/*
	 * // 제품등록
	 * 
	 * @RequestMapping("/abdewsss.do") public String prod_insert(ProductVO vo) {
	 * String webPath = "/resources/upload/"; String savePath =
	 * app.getRealPath(webPath); System.out.println(savePath);
	 * 
	 * MultipartFile photo = vo.getPhoto();
	 * 
	 * String s_image = ""; String l_image = ""; String ad_image = "";
	 * 
	 * if (!photo.isEmpty()) { String originalFilename =
	 * photo.getOriginalFilename(); String fileExtension =
	 * FilenameUtils.getExtension(originalFilename);
	 * 
	 * // 파일명 중복 방지를 위해 UUID 사용 String s_saveFileName = "s_image_" +
	 * UUID.randomUUID().toString() + "." + fileExtension; String l_saveFileName =
	 * "l_image_" + UUID.randomUUID().toString() + "." + fileExtension; String
	 * ad_saveFileName = "ad_image_" + UUID.randomUUID().toString() + "." +
	 * fileExtension;
	 * 
	 * File s_saveFile = new File(savePath, s_saveFileName); File l_saveFile = new
	 * File(savePath, l_saveFileName); File ad_saveFile = new File(savePath,
	 * ad_saveFileName);
	 * 
	 * try { photo.transferTo(s_saveFile); s_image = s_saveFileName;
	 * 
	 * photo.transferTo(l_saveFile); l_image = l_saveFileName;
	 * 
	 * photo.transferTo(ad_saveFile); ad_image = ad_saveFileName;
	 * 
	 * } catch (IOException e) { e.printStackTrace(); } }else {
	 * System.out.println("안들어가무ㅡ"); }
	 * 
	 * System.out.println("s_image : " + s_image + "l_image : " + l_image + " " +
	 * "ad_image : " + ad_image);
	 * 
	 * vo.setS_image(s_image); vo.setL_image(l_image); vo.setAd_image(ad_image);
	 * product_dao.product_update(vo); return "redirect:shop_list.do"; }
	 */

	// cart controller여기에

	// pick조회
	@RequestMapping("/pick.do")
	public String pick(Model model) {

		String c_id = (String) session.getAttribute("user");
		
		if (c_id == null || c_id.isEmpty()) {
			return Common.index.VIEW_PATH + "login.jsp";
		}

		List<ProductVO> list = pick_dao.select(c_id);
		System.out.println("여기는?"+c_id);
		System.out.println("controller : " + c_id);

		model.addAttribute("list", list);

		return Common.Visit_Cart.VIEW_PATH + "pick.jsp";
	}

	// pick에서 cart에 담기
	@RequestMapping("pick_to_cart.do")
	public String pick_to_cart(int p_idx) {
		String user = (String) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", user);
		map.put("p_idx", p_idx);

		pick_dao.insert_pick(map);
		return "redirect:cart_list.do";
	}

	// pick 찜목록 삭제하기
	@RequestMapping("pick_to_delete.do")
	public String pick_to_delete(int p_idx) {
		System.out.println("p_idx:"+p_idx);
		String user = (String) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", user);
		map.put("p_idx", p_idx);
		pick_dao.delete_pick(map);
		
		return "redirect:pick.do";// 임시로 장바구니로 감
	}

	// 상세리스트 픽하기
	@RequestMapping("pick_check.do")
	public String pick_check(int p_idx) {
		
		String c_id = (String) session.getAttribute("user");
		if (c_id == null || c_id.isEmpty()) {
			return Common.index.VIEW_PATH + "login.jsp";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", c_id);
		map.put("p_idx", p_idx);

		pick_dao.pick_check(map);

		// p_idx 값을 전달하도록 리디렉션 URL을 수정합니다.
		return "redirect:PageProductList.do?p_idx=" + p_idx;
	}

	// 상세리스트 픽 취소
	@RequestMapping("pick_del.do")
	public String pick_del(int p_idx) {
		
		String user = (String) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_id", user);
		map.put("p_idx", p_idx);

		pick_dao.delete_pick(map);
		return "redirect:PageProductList.do?p_idx=" + p_idx;
	}


}
