package com.delivery.finalproject.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.delivery.finalproject.service.KakaoMapService;

@Controller
@RequestMapping("/map")
public class KakaoMapController {

    private final KakaoMapService kakaoMapService;

    @Autowired
    public KakaoMapController(KakaoMapService kakaoMapService) {
        this.kakaoMapService = kakaoMapService;
    }

    @GetMapping("/getRoute")
    @ResponseBody
    public Map<String, Object> getRoute(
            @RequestParam("shopAddress") String shopAddress,
            @RequestParam("customerAddress") String customerAddress) {

        Map<String, Object> response = new HashMap<>();

        try {
            double[] shopCoordinates = kakaoMapService.getCoordinates(shopAddress);
            double[] customerCoordinates = kakaoMapService.getCoordinates(customerAddress);

            response.put("shopLat", shopCoordinates[0]);
            response.put("shopLng", shopCoordinates[1]);
            response.put("customerLat", customerCoordinates[0]);
            response.put("customerLng", customerCoordinates[1]);

        } catch (RuntimeException e) {
            response.put("error", e.getMessage());
        } catch (Exception e) {
            response.put("error", "알 수 없는 오류가 발생했습니다. 다시 시도해주세요.");
        }

        return response;
    }
}
