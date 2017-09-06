package com.lanou.cn.controller;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
@RestController
@RequestMapping("/")
public class AccountController {

    public static final String HOST_URL="http://192.168.2.25:8888";

    public static void main(String[] args){
        //vipAccountPage();
       // vipIntegral();
    }

    /**
     * 后台返回账户，代金券，银行卡信息
     * @return
     */
    @RequestMapping("vipAccountPage")
    public  ModelAndView vipAccountPage(){
        ModelAndView modelAndView=new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> bodyMap = new LinkedMultiValueMap<String, String>();
        bodyMap.add("currentPage","1");
        Map<String,Object> result=restTemplate.postForObject(HOST_URL + "/rest/vipAccountPage.do",bodyMap,Map.class);
        List<Map<String,Object>> list= (List<Map<String, Object>>) result.get("list");
        modelAndView.addObject("list",list);
        modelAndView.setViewName("findAccount");
        return modelAndView;
    }

    @RequestMapping("aaa")
    public  ModelAndView aaa(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("success");
        return modelAndView;
    }
}
