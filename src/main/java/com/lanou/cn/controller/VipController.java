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
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by Lanou3G on 2017/7/24.
 */
@Controller
@RequestMapping("vip")
public class VipController {
    private static final String HOST_URL_VIP = "http://192.168.2.25:8888";

    /**
     * 注册添加数据
     *
     * @param params
     * @return
     */
    @RequestMapping("addVip")
    @ResponseBody
    public Map<String, Object> addVip(@RequestParam Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String, Object> result = restTemplate.postForObject(HOST_URL_VIP+"/rest/addVip.do", bodyMap, Map.class);
        return result;
    }

    /**
     * 退出登录
     * @param request
     * @return
     */
    @RequestMapping("logout")
    public ModelAndView logout(HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("login");
        HttpSession session=request.getSession();
        session.invalidate();

        return  modelAndView;
    }

    /**
     * 将省信息带到注册页面或个人信息添加地址页面
     *
     * @param id
     * @return
     */
    @RequestMapping("startregister")
    public ModelAndView findProvince(@RequestParam String id) {
        ModelAndView modelAndView = new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        List<Map<String, Object>> list = restTemplate.postForObject(HOST_URL_VIP + "/rest/findProvince.do", bodyMap, List.class);
        modelAndView.addObject("list", list);
        if ("" != id) {
            bodyMap.add("id", Integer.parseInt(id));
            Map<String, Object> map = restTemplate.postForObject(HOST_URL_VIP + "/rest/findAddress.do", bodyMap, Map.class);
            modelAndView.setViewName("messageAddress");
            modelAndView.addObject("result", map);
        } else {
            modelAndView.setViewName("register");
        }
        return modelAndView;
    }

    /**
     * 根据省查找城市信息
     *
     * @param provinceId
     * @return
     */
    @RequestMapping("findCity")
    @ResponseBody
    public List<Map<String, Object>> findCity(@RequestParam String provinceId) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        bodyMap.add("provinceId", provinceId);
        List<Map<String, Object>> findCity = restTemplate.postForObject(HOST_URL_VIP + "/rest/findCity.do", bodyMap, List.class);
        return findCity;
    }

    /**
     * 异步判断账号是否重复
     *
     * @param vipAccount
     * @return
     */
    @RequestMapping("findVipAccount")
    @ResponseBody
    public Map<String, Object> findVipAccount(@RequestParam String vipAccount) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.add("vipAccount", vipAccount);
        Map<String, Object> result = restTemplate.postForObject(HOST_URL_VIP + "/rest/findVipAccount.do", bodyMap, Map.class);
        return result;
    }

    /**
     * 异步判断身份证是否重复
     *
     * @param idCard
     * @return
     */
    @RequestMapping("findIdCard")
    @ResponseBody
    public Map<String, Object> findIdCard(@RequestParam String idCard) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.add("idCard", idCard);
        Map<String, Object> result = restTemplate.postForObject(HOST_URL_VIP + "/rest/findIdCard.do", bodyMap, Map.class);
        return result;
    }

}
