// package first.final_project.controller;

// import org.springframework.stereotype.Controller;
// import org.springframework.web.bind.annotation.RequestMapping;

// @Controller
// public class OrderController {

//     // // private final IamportClient iamportClient;

//     public Or_derController() {
//     // // this.iamportClient = new IamportClient("REST_API_KEY", "REST_API_SECRET");
//     // // }

//     // // private PayService paymentService = new PayService

//     @RequestMapping("/order/find_addr")
//     public String find_addr() {

//         return "order/pay";
//     }
// }

// // @RequestMapping("order/pay_do")
// // public String order_pay (String amount, String token, Model model) {

// // model.addAttribute("amount", amount);
// // model.addAttribute("token", token);

// // return "order/pay_result";
// // }

// // // // @RequestMapping("/order/pay_test.do/{imp_uid}")
// // // @RequestMapping("/order/pay_test.do")
// // // // @ResponseBody
// // // public IamportResponse<Payment>
// paymentByImpUid(@PathVariable("imp_uid")
// // String imp_uid)
// // // throws IamportResponseException, IOException {
// // // return iamportClient.paymentByImpUid(imp_uid);
// // // }

// // @ResponseBody
// // @RequestMapping(value = "/verify_iamport/{imp_uid}", method =
// // RequestMethod.POST)
// // public IamportResponse<Payment> verifyIamportPOST(@PathVariable(value =
// // "imp_uid") String imp_uid) throws IamportResponseException, IOException {

// // return client.paymentByImpUid(imp_uid);
// // }

// // @RequestMapping(value ="complete", method = RequestMethod.POST)
// // @ResponseBody
// // public int paymentComplete(String imp_uid, String merchant_uid,String
// // totalPrice,HttpSession session
// // ,@RequestBody OrderDTO orderDTO) throws Exception {

// // String token = payService.getToken();

// // // 결제 완료된 금액
// // String amount = payService.paymentInfo(orderDTO.getImp_uid(), token);

// // int res = 1;

// // if (orderDTO.getTotalPrice() != Long.parseLong(amount)) {
// // res = 0;
// // // 결제 취소
// // payService.payMentCancle(token, orderDTO.getImp_uid(), amount,"결제 금액 오류");
// // return res;
// // }
// // orderService.insert_pay(orderDTO);
// // return res;

// // }

// }