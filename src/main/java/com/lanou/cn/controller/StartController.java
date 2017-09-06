package com.lanou.cn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by landfash on 2017/7/8.
 */
@Controller
@RequestMapping("/")
public class StartController {

    @RequestMapping("start")
    public String start(){
        return "page";
    }

    @RequestMapping("startregister")
    public String startgister(){
        return "register";
    }

    @RequestMapping("startlogin")
    public String startlogin(){
        return "login";
    }
}
