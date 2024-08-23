package vo;

public class OrderVO {
	
	//주문내역 join
	private int o_idx, p_idx, price, p_rate, volume, amount, sale_price;
	private String status, p_name, paytime, brand, s_image, c_id;
	public int getO_idx() {
		return o_idx;
	}
	public void setO_idx(int o_idx) {
		this.o_idx = o_idx;
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
	public int getVolume() {
		return volume;
	}
	public void setVolume(int volume) {
		this.volume = volume;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
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
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getPaytime() {
		return paytime;
	}
	public void setPaytime(String paytime) {
		this.paytime = paytime;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getS_image() {
		return s_image;
	}
	public void setS_image(String s_image) {
		this.s_image = s_image;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	
	
}
