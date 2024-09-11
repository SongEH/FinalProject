package first.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("menu")
@Data
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

}
