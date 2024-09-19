package first.final_project.vo;

import org.apache.ibatis.type.Alias;

@Alias("menu")
public class MenuVo {
	int no;
	int menu_id;
	String menu_category;
	String menu_name;
	String menu_content;
	int menu_price;
	String menu_img;
	int menu_popularity;
	String menu_cdate;
	int menu_status;
	int menu_hidden;
	int menu_soldout;
	int shop_id;

	public MenuVo() {
	}

	public MenuVo(int menu_id, String menu_category, String menu_name, String menu_content, int menu_price,
			String menu_img, int menu_popularity, String menu_cdate, int menu_status, int menu_hidden, int menu_soldout,
			int shop_id) {
		this.menu_id = menu_id;
		this.menu_category = menu_category;
		this.menu_name = menu_name;
		this.menu_content = menu_content;
		this.menu_price = menu_price;
		this.menu_img = menu_img;
		this.menu_popularity = menu_popularity;
		this.menu_cdate = menu_cdate;
		this.menu_status = menu_status;
		this.menu_hidden = menu_hidden;
		this.menu_soldout = menu_soldout;
		this.shop_id = shop_id;
	}

	public int getMenu_hidden() {
		return menu_hidden;
	}

	public void setMenu_hidden(int menu_hidden) {
		this.menu_hidden = menu_hidden;
	}

	public int getMenu_soldout() {
		return menu_soldout;
	}

	public void setMenu_soldout(int menu_soldout) {
		this.menu_soldout = menu_soldout;
	}

	public int getShop_id() {
		return shop_id;
	}

	public void setShop_id(int shop_id) {
		this.shop_id = shop_id;
	}

	public int getNo() {
		return this.no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMenu_id() {
		return this.menu_id;
	}

	public void setMenu_id(int menu_id) {
		this.menu_id = menu_id;
	}

	public String getMenu_category() {
		return this.menu_category;
	}

	public void setMenu_category(String menu_category) {
		this.menu_category = menu_category;
	}

	public String getMenu_name() {
		return this.menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_content() {
		return this.menu_content;
	}

	public void setMenu_content(String menu_content) {
		this.menu_content = menu_content;
	}

	public int getMenu_price() {
		return this.menu_price;
	}

	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}

	public String getMenu_img() {
		return this.menu_img;
	}

	public void setMenu_img(String menu_img) {
		this.menu_img = menu_img;
	}

	public int getMenu_popularity() {
		return this.menu_popularity;
	}

	public void setMenu_popularity(int menu_popularity) {
		this.menu_popularity = menu_popularity;
	}

	public String getMenu_cdate() {
		return this.menu_cdate;
	}

	public void setMenu_cdate(String menu_cdate) {
		this.menu_cdate = menu_cdate;
	}

	public int getMenu_status() {
		return this.menu_status;
	}

	public void setMenu_status(int menu_status) {
		this.menu_status = menu_status;
	}

	
}
