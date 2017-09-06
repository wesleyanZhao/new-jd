package com.lanou.cn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/8.
 */
@Controller
@RequestMapping("/")
public class  GoodsController {

    private static List<Map<String,Object>> result = null;

    public static final String HOST_URL_PRD = "http://192.168.2.9:8888";

    public static final String HOST_URL_PRDCOM = "http://192.168.2.3:8888";

    static final String HOST_URL_VIP = "http://192.168.2.25:8888";

//    @Resource
//    private SService splitService;
//    @Resource
//    private GService goodsService;

    @RequestMapping("search")
    public ModelAndView getSearch(@RequestParam Map<String,Object> params){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("allgoods");
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        if(null==params.get("currentPage")){
            bodyMap.add("prdName",params.get("prdName"));
        }else {
            bodyMap.add("prdName",null);
            bodyMap.add("currentPage",params.get("currentPage"));
            bodyMap.add("tpCd",params.get("tpCd"));
            bodyMap.add("salePriceBegin",params.get("salePriceBegin"));
            bodyMap.add("salePriceEnd",params.get("salePriceEnd"));
        }
        Map<String,Object> result = restTemplate.postForObject(HOST_URL_PRD+"/rest/getProduct.do",bodyMap,Map.class);
        modelAndView.addObject("page",result);
        modelAndView.addObject("params",params);
        return modelAndView;
    }

//    @RequestMapping("splitPage")
//    @ResponseBody
//    public Map<String,Object> splitPage(@RequestParam Map<String,Object> params){
//        splitService.splitPage(params);
//        Map<String,Object> mapPage = new HashMap();
//        mapPage.put("allNum",splitService.getAllNum());
//        return mapPage;
//    }

//    @RequestMapping("inputsearch")
//    @ResponseBody
//    public List<String> inputSearch(@RequestParam Map<String,Object> params){
//        return goodsService.getSearch(params);
//    }

    @RequestMapping("goDetailed")
    public ModelAndView goDetailed(@RequestParam Map<String,Object> params,HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("detailedProduct");
        RestTemplate restTemplateType = new RestTemplate();
        MultiValueMap<String,Object> bodyMapType = new LinkedMultiValueMap<>();
        if(null == params.get("id")){
            params.put("id",request.getSession().getAttribute("id"));
        }else{
            request.getSession().setAttribute("id",params.get("id"));
        }
        if(null != request.getSession().getAttribute("vipInfo")){
            Map<String,Object> vipInfo = (Map<String, Object>) request.getSession().getAttribute("vipInfo");
            RestTemplate restTemplate = new RestTemplate();
//            List<Map<String,Object>> type = goodsService.getProductType(params);
            List<Map<String,Object>> type = restTemplate.getForObject(HOST_URL_PRD+"/rest/getType.do",List.class);
//            String tpCd = (String) type.get(0).get("tpCd");
            String tpCd = (String) type.get(0).get("tpCd");
            bodyMapType.add("vipNo",vipInfo.get("vipNo"));
//            bodyMapType.add("vipNo","1004");
            bodyMapType.add("tpCd",tpCd);
            bodyMapType.add("cpnTypeNo","100");
            List<Map<String,Object>> result = restTemplateType.postForObject(HOST_URL_VIP+"/rest/findCpnInfo.do",bodyMapType,List.class);
            System.out.println("result::::"+result);
            modelAndView.addObject("cpn",result);
            modelAndView.addObject("length",result.size());
        }
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
        bodyMap.add("id",params.get("id"));
        result = restTemplate.postForObject(HOST_URL_PRD+"/rest/getDetailedProduct.do",bodyMap,List.class);
        modelAndView.addObject("detailed",result);
        if(null != params.get("prdDtlName")){
            for(int i = 0 ; i < result.size() ; i ++){
                if(((String)params.get("prdDtlName")).equals((String)result.get(i).get("prdDtlName"))){
                    modelAndView.addObject("nowDetailed",result.get(i));
                    String prdName = (String) result.get(i).get("prdName");
                    modelAndView.addObject("prdName",prdName);
                    break;
                }
            }
        }else {
            modelAndView.addObject("nowDetailed",result.get(0));
            String prdName = (String) result.get(0).get("prdName");
            modelAndView.addObject("prdName",prdName);
        }

        //评论内容
        RestTemplate restTemplatePrdNo = new RestTemplate();
        MultiValueMap<String,Object> bodyMapPrdNo = new LinkedMultiValueMap<>();
        bodyMapPrdNo.add("id",params.get("id"));
        //通过商品的id 获取商品编号 在获取评论内容
        List<Map<String, Object>> resultPrdNo = restTemplatePrdNo.postForObject(HOST_URL_PRD+"/rest/getPrdNoPrdDtlName.do",bodyMapPrdNo,List.class);
        String prdNo1 = "";
        if(!CollectionUtils.isEmpty(resultPrdNo)){
            prdNo1 = (String) resultPrdNo.get(0).get("prdNo");
        }
        //调订单接口通过商品编号查评论
        RestTemplate restTemplatePrdCom = new RestTemplate();
        MultiValueMap<String,Object> bodyMapPrdCom = new LinkedMultiValueMap<>();
        bodyMapPrdCom.add("prdNo",prdNo1);
        //通过商品的id 获取商品编号 在获取评论内容
        List<Map<String, Object>> resultPrdCom = restTemplatePrdCom.postForObject(HOST_URL_PRDCOM+"/rest/getPrdCom.do",bodyMapPrdCom,List.class);
        //获取会员名称
        for (int i = 0;i < resultPrdCom.size();i++) {
            String vipNo = (String) resultPrdCom.get(i).get("vipNo");
            RestTemplate restTemplateVipAccount = new RestTemplate();
            MultiValueMap<String, Object> bodyMapVipAccount = new LinkedMultiValueMap<>();
            bodyMapVipAccount.add("vipNo", vipNo);
            //通过vipNo获取会员名
            List<Map<String, Object>> resultVipAccount = restTemplateVipAccount.postForObject(HOST_URL_VIP + "/rest/findVipInfo.do", bodyMapVipAccount, List.class);
            for (int j = 0; j < resultVipAccount.size(); j++) {
                String vipAccount = (String) resultVipAccount.get(j).get("vipAccount");
                resultPrdCom.get(i).put("vipAccount", vipAccount);
            }
        }
        //把商品明细名称放到集合
        for(int i = 0;i < resultPrdCom.size();i++){
            String prdDtlNo = (String) resultPrdCom.get(i).get("prdDtlNo");
            for(int j = 0;j < resultPrdNo.size();j++){
                String prdDtlNo1 = (String) resultPrdNo.get(j).get("prdDtlNo");
                if(prdDtlNo.equals(prdDtlNo1)){
                    String prdDtlName = (String) resultPrdNo.get(j).get("prdDtlName");
                    resultPrdCom.get(i).put("prdDtlName",prdDtlName);
                    break;
                }
            }
        }
        //评论内容放到页面
        modelAndView.addObject("resultPrdCom",resultPrdCom);
        //评论条数
        int resultPrdComSize = resultPrdCom.size();
        modelAndView.addObject("resultPrdComSize",resultPrdComSize);
        int goodCom = 0;//好
        int midCom = 0;//中
        int badCom = 0;//差
        int sumComLevel = 0;
        if (resultPrdComSize != 0) {
            for (int i = 0;i < resultPrdCom.size();i++) {
                int cmmLevel = (int) resultPrdCom.get(i).get("cmmLevel");
                sumComLevel = sumComLevel + cmmLevel;
                //好评
                if (cmmLevel == 5 || cmmLevel == 4) {
                    goodCom = goodCom + 1;
                }
                //中评
                if (cmmLevel == 3 || cmmLevel == 2) {
                    midCom =midCom + 1;
                }
                //差评
                if (cmmLevel == 1) {
                    badCom = badCom + 1;
                }
            }
            BigDecimal sumComLevel1 = new BigDecimal(String.valueOf((double) sumComLevel));
            BigDecimal resultPrdComSize1 = new BigDecimal(String.valueOf((double) resultPrdComSize));
            double aveComLevel = sumComLevel1.divide(resultPrdComSize1,1,BigDecimal.ROUND_HALF_UP).doubleValue();
            //BigDecimal aveComLevel = new BigDecimal((float) sumComLevel/(float) resultPrdComSize).setScale(1, RoundingMode.UP);
            //把好评度返回到页面
            modelAndView.addObject("aveComLevel",aveComLevel);
        }else {
            goodCom = 0;
            midCom = 0;
            badCom = 0;
            BigDecimal aveComLevel = new BigDecimal(String.valueOf((double) 0)).setScale(1, RoundingMode.UP);
            modelAndView.addObject("aveComLevel",aveComLevel);
        }
        modelAndView.addObject("goodCom",goodCom);
        modelAndView.addObject("midCom",midCom);
        modelAndView.addObject("badCom",badCom);
        return modelAndView;
    }

    @RequestMapping("goDetailed1")
    @ResponseBody
    public Map<String,Object> goDetailed1(@RequestParam Map<String,Object> params, HttpServletRequest request){
        Map<String,Object> map1=new HashMap<>();
        if("" != params.get("productName") && null != params.get("productName")) {
            String vipNo= (String) request.getSession().getAttribute("vipNo");
            params.put("vipNo",vipNo);
            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap<String, String> bodyMap = new LinkedMultiValueMap<String, String>();
            bodyMap.add("vipNo", (String) params.get("vipNo"));
            bodyMap.add("prdDtlNo", (String) params.get("prdDtlNo"));
            Map<String,Object> map=restTemplate.postForObject(HOST_URL_PRD + "/rest/findShopCar.do",bodyMap,Map.class);

           /* Map<String,Object> map = goodsService.findShopCar(params);*/
            if(!CollectionUtils.isEmpty(map)) {
                if (params.get("prdDtlNo").equals(map.get("prdDtlNo"))) {
                    int num1 = (int) map.get("num");
                    int num2 = Integer.parseInt((String) params.get("num"));
                    int newNum = num1 + num2;
                    params.put("newNum", newNum);
                    MultiValueMap<String, Object> bodyMap1 = new LinkedMultiValueMap<String, Object>();
                    bodyMap1.add("vipNo", (String) params.get("vipNo"));
                    bodyMap1.add("prdDtlNo", (String) params.get("prdDtlNo"));
                    bodyMap1.add("newNum", newNum);
                    map1=restTemplate.postForObject(HOST_URL_PRD + "/rest/updateShopCar.do",bodyMap1,Map.class);
                    /*goodsService.updateShopCar(params);*/
                    /*map1.put("result","success");*/

                }
            }else{
                /*map1.put("result","success");*/
                MultiValueMap<String, String> bodyMap2 = new LinkedMultiValueMap<String, String>();
                bodyMap2.add("phone", (String) params.get("phone"));
                bodyMap2.add("prdDtlName", (String) params.get("prdDtlName"));
                bodyMap2.add("salePrice", (String) params.get("salePrice"));
                bodyMap2.add("cpnContent", (String) params.get("cpnContent"));
                bodyMap2.add("prdDtlNo", (String) params.get("prdDtlNo"));
                bodyMap2.add("num", (String) params.get("num"));
                bodyMap2.add("vipNo", (String) params.get("vipNo"));
                map1=restTemplate.postForObject(HOST_URL_PRD + "/rest/addShopCar.do",bodyMap2,Map.class);
                /*goodsService.getShopCar(params);*/

            }
        }
        return map1;
    }


    @RequestMapping("addCpn")
    @ResponseBody
    public Map<String,Object> addCpn(@RequestParam Map<String,Object> params,HttpServletRequest request){
        Map<String,Object> cpnResult = new HashMap<>();
        if(null != request.getSession().getAttribute("vipInfo")){
            Map<String,Object> vipInfo = (Map<String, Object>) request.getSession().getAttribute("vipInfo");
            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
            params.put("id",request.getSession().getAttribute("id"));
//            List<Map<String,Object>> type = goodsService.getProductType(params);

            List<Map<String,Object>> type = restTemplate.getForObject(HOST_URL_PRD+"/rest/getType.do",List.class);
            String tpCd = (String) type.get(0).get("tpCd");
            bodyMap.add("vipNo",vipInfo.get("vipNo"));

            bodyMap.add("tpCd",tpCd);
            bodyMap.add("cpnTypeNo","100");
            List<Map<String,Object>> result = restTemplate.postForObject(HOST_URL_VIP+"/rest/findCpnInfo.do",bodyMap,List.class);
            for(int i = 0 ; i < result.size() ; i ++){
                if(((String)result.get(i).get("cpnNo")).equals((String)params.get("cpnNo"))){
                    RestTemplate restTemplate1 = new RestTemplate();
                    MultiValueMap<String,Object> multiValueMap = new LinkedMultiValueMap<>();
                    multiValueMap.add("vipNo",((Map<String, Object>) request.getSession().getAttribute("vipInfo")).get("vipNo"));
                    multiValueMap.add("cpnNo",params.get("cpnNo"));
                    Map<String,Object> result2 = restTemplate1.postForObject(HOST_URL_VIP+"/rest/addVipCpnR.do",multiValueMap,Map.class);
                    return result2;
                }
            }
            cpnResult.put("result","error");
        }else {
            cpnResult.put("result","noUser");
        }

        return cpnResult;
    }
}
