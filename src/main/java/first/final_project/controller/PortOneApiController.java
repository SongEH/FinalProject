// package first.final_project.controller;

// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

// import lombok.RequiredArgsConstructor;
// import lombok.extern.slf4j.Slf4j;

// @RestController
// @RequestMapping("api/v1")
// @RequiredArgsConstructor
// @Slf4j
// public class PortOneApiController {

// @Value("${IMP_API_KEY}")
// private String apiKey;

// @Value("${imp.api.secretkey}")
// private String secretKey;

// @PostConstruct
// public String init() {
// this.iamportClient = new IamportClient(apiKey, secretKey);
// }
// }
