package vo;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
	private int r_idx, p_idx, reviewscore, volume;
	private String c_id, content, regdate, p_name, image;
	private MultipartFile photo;
	
	public int getR_idx() {
		return r_idx;
	}
	public int getVolume() {
		return volume;
	}
	public void setVolume(int volume) {
		this.volume = volume;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public int getReviewscore() {
		return reviewscore;
	}
	public void setReviewscore(int reviewscore) {
		this.reviewscore = reviewscore;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
