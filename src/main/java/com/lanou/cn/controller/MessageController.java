package com.lanou.cn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Lanou3G on 2017/7/25.
 */
@Controller
@RequestMapping("message")
public class MessageController {
    private static final String HOST_URL = "http://192.168.2.25:8888";
    private static final String hostURL = "http://192.168.2.3:8088";

    /**
     * 个人信息页面添加地址
     * @param params
     * @return
     */
    @RequestMapping("messageAddress")
    @ResponseBody
    public Map<String,Object> messagePage(@RequestParam Map<String,Object> params){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String,Object> result = restTemplate.postForObject(HOST_URL+"/rest/addVipAddress.do",bodyMap,Map.class);
        return result;
    }

    /**
     * 根据id查找相关银行卡信息
     * @param id
     * @return
     */
    @RequestMapping("messageBank")
    public ModelAndView messageBank(@RequestParam String id){
        ModelAndView modelAndView=new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.add("id",Integer.parseInt(id));
        List<Map<String,Object>> result = restTemplate.postForObject(HOST_URL+"/rest/findBank.do",bodyMap,List.class);
        modelAndView.addObject("result",result);
        modelAndView.setViewName("messageBank");
        return modelAndView;
    }

    /**
     * 个人信息页面添加银行卡
     * @param params
     * @return
     */
    @RequestMapping("addBank")
    @ResponseBody
    public Map<String,Object> addBank(@RequestParam Map<String,Object> params){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String,Object> result = restTemplate.postForObject(HOST_URL+"/rest/addBankInfo.do",bodyMap,Map.class);
        return result;
    }

    /**
     * 登陆成功后根据id查找个人信息并进入个人信息页面
     * @param
     * @return
     */
    @RequestMapping("findMessage")
    public ModelAndView findMessage(@RequestParam Map<String,Object> params, HttpServletRequest request){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        List<Map<String,Object>> result = restTemplate.postForObject(HOST_URL+"/rest/findVipInfo.do",bodyMap,List.class);
        ModelAndView modelAndView=new ModelAndView();
        Map<String,Object> map= (Map<String, Object>) request.getSession().getAttribute("vipInfo");

        if(result.size()>0){
            Map<String,Object> param=result.get(0);
            modelAndView.addObject("result",param);
            modelAndView.addObject("id",map.get("vipId"));
            modelAndView.setViewName("message");
        }else{
            modelAndView.setViewName("page");
        }

        return modelAndView;
    }

    /**
     * 个人信息修改完成后返回success结果
     * @param params
     * @return
     */
    @RequestMapping("updateVipInfo")
    @ResponseBody
    public Map<String,String> updateVipInfo(@RequestParam Map<String,Object> params){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String,String> result = restTemplate.postForObject(HOST_URL+"/rest/updateVipInfo.do",bodyMap,Map.class);
        return result;
    }



}
