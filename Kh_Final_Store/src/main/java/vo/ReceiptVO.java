package vo;

public class ReceiptVO {
	private int amount, price, p_rate; 
	private String p_name, s_image, paytime, name, tel, email, addr, request, c_id, a_name;
	//총상품금액, 할인금액, 결제금액, 적립예정포인트
	private int total_price, total_sale_price;
	
	
	
	public int getTotal_price() {
		//판매가 sum(정가 * 수량)
		return total_price;
	}
	public int getTotal_sale_price() {
		//포인트 + sum(정가*할인률*수량)
		return total_sale_price;
	}

	
	public int getP_rate() {
		return p_rate;
	}
	public void setP_rate(int p_rate) {
		this.p_rate = p_rate;
	}
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getS_image() {
		return s_image;
	}
	public void setS_image(String s_image) {
		this.s_image = s_image;
	}
	public String getPaytime() {
		return paytime;
	}
	public void setPaytime(String paytime) {
		this.paytime = paytime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	private int sale_price;
	public int getSale_price() {
		//정가 * (100-할인률)/100
		return (int)(price * (100 - p_rate)/100); 
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	
	
	
	
}
