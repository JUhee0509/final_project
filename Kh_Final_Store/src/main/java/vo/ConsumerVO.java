package vo;

public class ConsumerVO {
	private int  bonus_point, blacklist, del_info;
	private String c_id, name, pwd, email, gender, tel;


	public int getBonus_point() {
		return bonus_point;
	}

	public void setBonus_point(int bonus_point) {
		this.bonus_point = bonus_point;
	}

	public int getBlacklist() {
		return blacklist;
	}

	public void setBlacklist(int blacklist) {
		this.blacklist = blacklist;
	}

	public int getDel_info() {
		return del_info;
	}

	public void setDel_info(int del_info) {
		this.del_info = del_info;
	}

	public String getC_id() {
		return c_id;
	}

	public void setC_id(String c_id) {
		this.c_id = c_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
	    // VO에서 전화번호를 설정할 때, 하이픈을 제거한 숫자만 설정
	    this.tel = tel != null ? tel.replaceAll("-", "") : null;
	}

}
