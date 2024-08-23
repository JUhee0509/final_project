package common;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import vo.ConsumerVO;

public class MailSendService {
	private JavaMailSender javaMailSender;
	private int authNumber = 0;
	public static String randomPWD = "";
	Random rnd = new Random();

	// 생성자 인젝션으로 JavaMailSender받을 준비
	public MailSendService(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	// 난수로 인증번호 만들기
	public void makeRandomNumber() {
		//난수범위 111111 ~ 999999
		int checkNum = rnd.nextInt(999999 - 111111 + 1) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
	
	//랜덤 비밀번호 보내기
	public String makeRandomPWD() {
		char[] charSet = new char[] { 
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
		        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
		        'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
		        'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
		        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
		        'y', 'z' };
		
		StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 10; i++) { //비밀번호 길이 10까지만 반복
            int randomIndex = rnd.nextInt(charSet.length);
            sb.append(charSet[randomIndex]);
        }
        randomPWD = sb.toString();
        String edcodePwd = Common.SecurePwd.encodePwd(randomPWD);
        System.out.println("MailSenderService clsaa 랜덤 비밀번호: " + randomPWD);
        return edcodePwd;
	}//makeRandomPWD

// 회원가입 이메일을 보낼 양식
	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = "hrtartb@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "Eclat de Luxe 회원 가입 인증 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = "인증번호는 <b>" + authNumber + "</b>입니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(authNumber);
	} // joinEmail
	
//----------------------------------------------------	
// 회원 정보 수정을 위한 이메일을 보낼 양식
	public String modifyUserEmail(String email) {
		makeRandomNumber();
		String setFrom = "hrtartb@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "Eclat de Luxe 회원 정보 수정 인증 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = "인증번호는 <b>" + authNumber + "</b>입니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(authNumber);
	} // joinEmail
	
//----------------------------------------------------	
// 회원 정보 수정을 위한 이메일을 보낼 양식
	public String modifyAdminEmail(String email) {
		makeRandomNumber();
		String setFrom = "hrtartb@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "Eclat de Luxe 관리자 정보 수정 인증 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = "인증번호는 <b>" + authNumber + "</b>입니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(authNumber);
	} // modifyAdminEmail

	//관리자 회원가입 인증 메서드
	public String AdminCheckEmail(String email) {
		makeRandomNumber();
		String setFrom = "hrtartb@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "Eclat de Luxe 관리자 회원가입 인증 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = "인증번호는 <b>" + authNumber + "</b>입니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(authNumber);
	} // joinEmail

	
//------------------------------------------	
// 비밀번호 이메일을 보낼 양식
	public String findPWD_Email(String email, String name) {
		ConsumerVO vo = new ConsumerVO();
		vo.setName(name);
		String tempPWD = makeRandomPWD();
		String setFrom = "hrtartb@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "Eclat de Luxe 비밀번호 찾기 인증 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = vo.getName()+ "님의 임시 비밀번호는 <b>" + randomPWD + "</b>입니다.";
		
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return tempPWD;
	} // findPWD_Email
}
