package com.lanou.cn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Lanou3G on 2017/7/25.
 */
@Controller
@RequestMapping("login")
public class LoginController {
    private static final String HOST_URL = "http://192.168.2.3:8088";
    private static final String hostUrl = "http://192.168.2.25:8888";
    /**
     * 进入登录页面
     * @return
     */
    @RequestMapping("loginPage")
    public String loginPage(){
        return "login";
    }

    /**
     * 判断登录者是否在数据库中有记录
     * @param params
     * @return
     */
    @RequestMapping("loginFrom")
    public ModelAndView loginFrom(@RequestParam Map<String,Object> params, HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.addObject(params);
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String,Object> result = restTemplate.postForObject(hostUrl+"/rest/loginFrom.do",bodyMap,Map.class);
        if (CollectionUtils.isEmpty(result)){
            modelAndView.setViewName("login");//如果返回结果为空则说明没有此账户
        }else {
            request.getSession().setAttribute((String)result.get("vip_account"),"123");
            request.getSession().setAttribute("vipNo",result.get("vip_no"));
            // 添加会员登录信息到前端商城系统session中
            Map<String,Object> vipInfo = new HashMap<String,Object>();
            vipInfo.put("vipAccount",result.get("vip_account"));
            vipInfo.put("vipId",result.get("id"));
            vipInfo.put("vipNo",result.get("vip_no"));
            request.getSession().setAttribute("vipInfo",vipInfo);

            modelAndView.setViewName("page");//如果返回结果不为空则说明此账户存在
            modelAndView.addObject("id",result.get("id"));
            modelAndView.addObject("vipAccount",result.get("vip_account"));
      }
        return modelAndView;
    }


}
