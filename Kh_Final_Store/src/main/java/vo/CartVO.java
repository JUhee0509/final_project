package vo;

public class CartVO {
	private int c_idx, amount, checkbox, p_idx;
	private String c_id, addr;
	//추가
	private String s_image, brand, p_name;
	private int price, p_rate, volume;
	
	private int sale_price;
	public int getSale_price() {
		//정가 * (100-할인률)/100
		return (int)(price * (100 - p_rate)/100); 
	}
	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}
	
	public String getS_image() {
		return s_image;
	}
	public void setS_image(String s_image) {
		this.s_image = s_image;
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
	
	public int getVolume() {
		return volume;
	}
	public void setVolume(int volume) {
		this.volume = volume;
	}
	
	
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getCheckbox() {
		return checkbox;
	}
	public void setCheckbox(int checkbox) {
		this.checkbox = checkbox;
	}
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
}
