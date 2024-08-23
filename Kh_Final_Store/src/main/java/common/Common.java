package common;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.AdministratorDAO;
import dao.ConsumerDAO;
import vo.AdministratorVO;
import vo.ConsumerVO;

public class Common {

	// SHOP과 관련된 경로(product)
	public static class Visit_shop {
		public static final String VIEW_PATH = "/WEB-INF/views/shop/";
	}

	// board 경로

	public static class Visit_board {
		public static final String VIEW_PATH = "/WEB-INF/views/board/";
	}

	// faq과 관련된 경로
	public static class Visit_faq {
		public static final String VIEW_PATH = "/WEB-INF/views/board/faq/";
	}

	// 공지와 관련된 경로
	public static class Visit_notice {
		public static final String VIEW_PATH = "/WEB-INF/views/board/notice/";
	}

	// 문의 관련된 경로
	public static class Visit_inquire {
		public static final String VIEW_PATH = "/WEB-INF/views/board/inquire/";
	}

	// 제품등록 경로
	public static class Visit_product {
		public static final String VIEW_PATH = "WEB-INF/views/product/";
	}

	// 찜 경로
	public static class Visit_Cart {
		public static final String VIEW_PATH = "WEB-INF/views/pick/";
	}

	// 관리자 고객관리 페이지
	public static class VisitAdminCumstomer {
		public static final String VIEW_PATH = "WEB-INF/views/admin_customer/";
	}

	// 통계
	public static class VisitStatic {
		public static final String VIEW_PATH = "WEB-INF/views/stats/";
	}

	// 관리자 공지
	public static class VisitAdminNotice {
		public static final String VIEW_PATH = "/WEB-INF/views/admin_boards/admin_notice/";
	}

	// 관리자 FAQ
	public static class VisitAdminFAQ {
		public static final String VIEW_PATH = "/WEB-INF/views/admin_boards/admin_faq/";
	}

	// 관리자 문의
	public static class VisitAdminInquire {
		public static final String VIEW_PATH = "/WEB-INF/views/admin_boards/admin_inquire/";
	}

	// 관리자 게시판
	public static class VisitAdminBoard {
		public static final String VIEW_PATH = "/WEB-INF/views/admin_boards/";
	}

	// 현준님 마이페이지 주소
	public static class Store {
		public static final String VIEW_PATH = "/WEB-INF/views/mypage/";

	}

	// 리뷰페이지 경로
	public static class Review {
		public static final String VIEW_PATH = "/WEB-INF/views/review/";
	}

	// 장바구니 경로
	public static class Cart {
		public static final String VIEW_PATH = "/WEB-INF/views/cart/";
	}

	// 영수증 경로
	public static class Receipt {
		public static final String VIEW_PATH = "/WEB-INF/views/receipt/";
	}

	// 준희님
	// 메인페이지
	public static class main {
		public static final String VIEW_PATH = "/WEB-INF/views/main/";
	}

	// 메뉴
	public static class index {
		public static final String VIEW_PATH = "/WEB-INF/views/index/";
	}

	// 상세보기
	public static class detail {
		public static final String VIEW_PATH = "/WEB-INF/views/detail/";
	}

	// 관리자 경로
	public static class Admin {
		public static final String VIEW_PATH = "/WEB-INF/views/admin/";
	}

	// 홍경님
	public static class Login {
		public static final String VIEW_PATH = "/WEB-INF/views/login/";

	}

	public static class SecurePwd {
		// 비밀 번호 암호화를 위한 메서드
		public static String encodePwd(String pwd) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodePwd = encoder.encode(pwd);
			return encodePwd;
		}

		// 비밀번호 복호화 메서드
		public static boolean decodePwd(String c_id, String pwd, ConsumerDAO consumer_dao) {
			boolean isValid = false;

			ConsumerVO resultVO = consumer_dao.selectOneIDCheck(c_id);

			System.out.println("복호화된 resultVO PWD= " + resultVO.getPwd());
			if (resultVO != null) {
				// 입력한 비밀번호와 db의 암호화된 비밀번호가 일치하다면
				// isValid가 true가 된다.
				isValid = BCrypt.checkpw(pwd, resultVO.getPwd());
			}
			return isValid;
		}

		// 비밀번호 복호화 관리자 메서드
		public static boolean decodePwd_admin(String c_id, String pwd, AdministratorDAO admin_dao) {
			boolean isValid = false;

			AdministratorVO resultVO = admin_dao.selectOneAdminIDCheck(c_id);

			System.out.println("복호화된 resultVO PWD= " + resultVO.getPwd());
			if (resultVO != null) {
				// 입력한 비밀번호와 db의 암호화된 비밀번호가 일치하다면
				// isValid가 true가 된다.
				isValid = BCrypt.checkpw(pwd, resultVO.getPwd());
			}
			return isValid;
		}
	}

	// 문의 전체조회 중 페이징처리
	public static class Board {
		public static final int BLOCKLIST = 5;

		public static final int BLOCKPAGE = 3;
	}

}
