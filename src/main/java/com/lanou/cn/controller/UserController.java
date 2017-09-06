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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/8.
 */
@Controller
@RequestMapping("/")
public class UserController {

    public static final String HOST_URL_LH="http://192.168.2.9:8888";

//    @Resource
//    private UService uService;

    @RequestMapping("logintwo")
    public String logintwo(){
        return "login";
    }

//    @RequestMapping("login")
//    public ModelAndView login(@RequestParam Map<String,String> params){
//        ModelAndView modelAndView = new ModelAndView();
////        boolean flage = uService.getUser(params);
//        if(true==flage){
//            modelAndView.setViewName("page");
//            modelAndView.addObject("account",uService.getAccount());
//        }else{
//            modelAndView.setViewName("login");
//        }
//        return modelAndView;
//    }

//    @RequestMapping("register")
//    public String register(@RequestParam Map<String,Object> params){
//        uService.inUser(params);
//        return "login";
//    }


    /*
    * 进购物车
    * */
    @RequestMapping("shopcar")
    public ModelAndView getCar(@RequestParam Map<String,Object> params, HttpServletRequest request){

        List<Map<String, Object>> result1 = new ArrayList<>();
       /* Map<String, Object> result1 = new HashMap<>();*/

        ModelAndView modelAndView = new ModelAndView();
        Object result = request.getSession().getAttribute((String) params.get("vipAccount"));
        if(null != result){
            modelAndView.setViewName("shopcar");
            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap<String, Object> bodyMap1 = new LinkedMultiValueMap<String, Object>();
            bodyMap1.add("vipNo", (String) params.get("vipNo"));
            List<Map<String,Object>> list=restTemplate.postForObject(HOST_URL_LH + "/rest/getAllShop.do",bodyMap1,List.class);
            /*List<Map<String,Object>> list = uService.getAllShop(params);*/
            for(int i=0;i<list.size();i++){
                int num = (int) list.get(i).get("num");
                int summation = 0;
                MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
                bodyMap.add("prdDtlNo", (String) list.get(i).get("prdDtlNo"));
                result1 = restTemplate.postForObject(HOST_URL_LH+"/rest/getWare.do", bodyMap, List.class);
                for(int j=0;j<result1.size();j++){
                    int num1 = (int) result1.get(j).get("wCount");
                    summation = summation+num1;
                }
                if (num>summation){
                    list.get(i).put("storage","存货不足，请删除商品重新添加");
                }

            }
            modelAndView.addObject("list",list);
            return modelAndView;
        }else{
            modelAndView.setViewName("login");
            return modelAndView;
        }
    }


    @RequestMapping("price")
    public ModelAndView getprice(@RequestParam Map<String,Object> params){
        ModelAndView modelAndView = new ModelAndView();
        return modelAndView;
    }

//    @RequestMapping("toCar")
//    @ResponseBody
//    public Map<String,String> toCar(@RequestParam Map<String,Object> params){
//        System.out.println(params.get("goods_id"));
//        return uService.toCar(params);
//    }

//    @RequestMapping("registerajax")
//    @ResponseBody
//    public boolean registerAjax(@RequestParam Map<String,Object> params){
//        return uService.registerAjax(params);
//    }

    /**
     * 删除按钮
     * @param params
     * @return
     */
    @RequestMapping("deleteShopCarProducts")
    @ResponseBody
    public Map<String,Object> deleteShopCarProducts(@RequestParam Map<String,Object> params){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        bodyMap.add("id", params.get("id"));
        Map<String,Object> result=restTemplate.postForObject(HOST_URL_LH + "/rest/deleteShopCar.do",bodyMap,Map.class);
        /*uService.outCar(params);*/
        /*result.put("result","success");*/
        return result;
    }
    /**
     * 积分查询分页
     * @param params
     * @return
     */
//    @RequestMapping("findPointRcd")
//    public ModelAndView findPointRcd(@RequestParam Map<String,Object> params){
//        ModelAndView modelAndView=new ModelAndView();
//        modelAndView.setViewName("findPointRcd");
//        Map<String,Object> result=uService.vipIntegral(params);
//        System.out.println(result);
//        modelAndView.addObject("result",result);
////        modelAndView.addObject("currentPage",2);
//        modelAndView.addObject("total",result.get("total"));
//        modelAndView.addObject("list",result.get("list"));
//        modelAndView.addObject("pages",result.get("pages"));
//        modelAndView.addObject("pageNum",result.get("pageNum"));
//        return modelAndView;
//    }
}
