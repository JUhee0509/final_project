package vo;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
	// db의 컬럼명과 동일한 이름으로 생성함. 일반적으로 생성후 수정 할 일 없다
	private int p_idx, price, p_rate, volume, stock, sales, idx;
	private String brand, p_name, scent, s_image, l_image, ad_image, gender;
	// 관리자 페이지 사진 추가시 사진 주소
	private MultipartFile s_image_url, l_image_url, ad_image_url;

	public String getS_image() {
		return s_image;
	}

	public void setS_image(String s_image) {
		this.s_image = s_image;
	}

	public String getL_image() {
		return l_image;
	}

	public void setL_image(String l_image) {
		this.l_image = l_image;
	}

	public String getAd_image() {
		return ad_image;
	}

	public void setAd_image(String ad_image) {
		this.ad_image = ad_image;
	}

	public MultipartFile getS_image_url() {
		return s_image_url;
	}

	public void setS_image_url(MultipartFile s_image_url) {
		this.s_image_url = s_image_url;
	}

	public MultipartFile getL_image_url() {
		return l_image_url;
	}

	public void setL_image_url(MultipartFile l_image_url) {
		this.l_image_url = l_image_url;
	}

	public MultipartFile getAd_image_url() {
		return ad_image_url;
	}

	public void setAd_image_url(MultipartFile ad_image_url) {
		this.ad_image_url = ad_image_url;
	}

	public int getP_idx() {
		return p_idx;
	}

	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getP_rate() {
		return p_rate;
	}

	public void setP_rate(int p_rate) {
		this.p_rate = p_rate;
	}

	public int getSale_price() {
		//할인율이 0%인 경우
		   if(p_rate <= 0) {
		   return price;
		   }
		   //그외 할인이 있을시
		   //원가-(원가*할인율/100)
		   return (int)(price-(price*(float)p_rate / 100));
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getScent() {
		return scent;
	}

	public void setScent(String scent) {
		this.scent = scent;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}
	
}
