package first.final_project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import first.final_project.dao.AddrMapper;
import first.final_project.dao.CartsMapper;
import first.final_project.dao.OrderMapper;
import first.final_project.vo.AddrVo;
import first.final_project.vo.CartsVo;
import first.final_project.vo.MemberVo;
import first.final_project.vo.OrderVo;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order/")
public class OrderController {

	@Autowired
	OrderMapper order_mapper;

	@Autowired
	CartsMapper carts_mapper;

	@Autowired
	AddrMapper addr_mapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	// /menu/list.do
	// /menu/list.do?page=2
	@RequestMapping("list.do")
	public String list(@RequestParam(name = "page", defaultValue = "1") int nowPage,
			Model model) {

		List<OrderVo> list = order_mapper.selectList();

		// 전체 게시물수
		// int rowTotal = order_mapper.selectRowTotal();

		// System.out.println(rowTotal);
		System.out.println(list);

		// 결과적으로 request binding
		model.addAttribute("list", list);

		return "order/order_list";
	}

	// 주문대기 (주문 전)
	@RequestMapping("pending_order.do")
	public String insert(int shop_id, String shop_name, Model model) {

		int member_id = 98;

		// 장바구니 테이블에서 => 가게ID와 + 현재 사용자ID와 + orderID가 없는 것을 조회한 결과
		List<CartsVo> list = carts_mapper.findPendingOrders(member_id, shop_id);

		// 현재 로그인한 사용자
		MemberVo user = (MemberVo) session.getAttribute("user");

		// request binding
		model.addAttribute("list", list);
		model.addAttribute("user", user);
		model.addAttribute("shop_id", shop_id);
<<<<<<< HEAD

=======
		
>>>>>>> parent of b45aac4 (Merge pull request #35 from SongEH/한지혜브랜치2)
		model.addAttribute("shop_name", shop_name);

		// 주소 처리
		// 1. 현재 로그인한 사용자의 주소목록을 가져옴
		List<AddrVo> addr_list = addr_mapper.selectList(user.getMember_id());
		model.addAttribute("addr_list", addr_list);

		// 2. 등록된 주소 이외의 추가 주소정보 등록

		return "order/order_pending_list";
	}

	// 주문
	@RequestMapping("insert.do")
	public String insert(OrderVo vo) {

		String orders_drequest = vo.getOrders_drequest().replaceAll("\n", "<br>");
		vo.setOrders_drequest(orders_drequest);

		String orders_srequest = vo.getOrders_srequest().replaceAll("\n", "<br>");
		vo.setOrders_srequest(orders_srequest);

		// 아래 수동 setting 한건 추후 수정해야됨
		vo.setOrders_name("주문테스트");
		vo.setShop_id(1);
		vo.setOrders_price(100000);
		vo.setShop_name("맛집1");
		vo.setAddr_id(99); // 주소 기능 구현완료 되면 추가하기

		// 현재 로그인한 사용자
		MemberVo user = (MemberVo) session.getAttribute("user");
		vo.setMember_id(user.getMember_id());

		System.out.println(vo);
<<<<<<< HEAD

		// DB insert
		int res = order_mapper.insert(vo);

		return "redirect:list.do";
	}


=======

		// DB insert
		int res = order_mapper.insert(vo);

		return "redirect:list.do";
	}
>>>>>>> parent of b45aac4 (Merge pull request #35 from SongEH/한지혜브랜치2)

}
