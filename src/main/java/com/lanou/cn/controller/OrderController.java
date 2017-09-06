package com.lanou.cn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Lanou3G on 2017/7/28.
 */
@Controller
@RequestMapping("order")
public class OrderController {
//    private static final String hostUrl = "http://192.168.2.3:8888";//添加订单商品评论和查找订单明细+主信息
    private static final String hOst_Url = "http://192.168.2.33:8080";//退货
//    private static final String host_Url = "http://192.168.2.19:8088";//判断取消订单是否成功
    static final String HOST_URL_ORD = "http://192.168.2.3:8888";
    static final String HOST_URL_VIP = "http://192.168.2.25:8888";
    static final String HOST_URL_PRD = "http://192.168.2.9:8888";
    static final String HOST_URL_PLA = "http://192.168.2.39:8088";


    /**
     * 个人信息订单支付
     * @return
     */
    @RequestMapping("vipPay")
    public ModelAndView vipPay(@RequestParam Map<String,Object> params,HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("pay");
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap();
        Map<String,Object> vipInfo= (Map<String, Object>) request.getSession().getAttribute("vipInfo");
        //地址接口
        bodyMap.add("vipId", vipInfo.get("vipId"));
        bodyMap.add("vipNo", vipInfo.get("vipNo"));
        List<Map<String, Object>> siteList = restTemplate.postForObject(HOST_URL_VIP + "/rest/showSite.do", bodyMap, List.class);
        //根据订单编号查询对应的商品价格，数量，明细编号
        bodyMap.add("ordNo", params.get("ordNo"));
        List<Map<String, Object>> findPrdDtl = restTemplate.postForObject(HOST_URL_ORD + "/rest/findPrdDtl.do", bodyMap, List.class);
        params.put("prdDtlList", findPrdDtl);
        //调用商品详情
        List<Map<String,Object>> prdDtlList=new ArrayList<>();
        if(findPrdDtl.size()==0){
            bodyMap.add("prdDtlNo",params.get("prdDtlNo"));
            Map<String,Object> prdResult= restTemplate.postForObject(HOST_URL_PRD+"/rest/getPrdDetailed.do",bodyMap,Map.class);
            //将商品数量加入到商品信息中
            prdResult.put("num",params.get("num"));
            prdDtlList.add(prdResult);
            bodyMap.setAll(prdResult);
        } else {
            bodyMap.add("prdDtlList", findPrdDtl);
            prdDtlList = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrdDetailedForList.do", bodyMap, List.class);
            for (int j = 0; j < prdDtlList.size(); j++) {
                for (int i = 0; i < findPrdDtl.size(); i++) {
                    if (prdDtlList.get(j).get("prdDtlNo").equals(findPrdDtl.get(i).get("prdDtlNo"))) {
                        prdDtlList.get(j).put("price", findPrdDtl.get(i).get("price"));//将单价*数量的钱数放入prdDtlList中
                        prdDtlList.get(j).put("ordDtlId", findPrdDtl.get(i).get("ordDtlId"));
                    }

                }
            }
        }
        //调用企划
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> size2 = (List) params.get("prdDtlList");
        if (size2.size() == 0) {
            bodyMap.add("product", prdDtlList);
            result = restTemplate.postForObject(HOST_URL_PLA + "/rest/getPlanning.do", bodyMap, Map.class);
        } else {

            bodyMap.add("product", findPrdDtl);
            System.out.println("-----------------" + bodyMap);
            result = restTemplate.postForObject(HOST_URL_PLA + "/rest/getPlanning.do", bodyMap, Map.class);
        }
        List<Map<String, Object>> x = (List<Map<String, Object>>) result.get("productPlan");
        for (int i = 0; i < x.size(); i++) {
            for (int j = 0; j < prdDtlList.size(); j++) {
                if (x.get(i).get("prdDtlNo").equals(prdDtlList.get(j).get("prdDtlNo"))) {
                    prdDtlList.get(j).put("plan", x.get(i).get("plan"));

                }
            }
        }
        //积分接口
        Map<String,Object> integralMap=restTemplate.postForObject(HOST_URL_VIP+"/rest/findAccPoint.do",bodyMap,Map.class);

        List<Map<String, Object>> vipInfoResult = restTemplate.postForObject(HOST_URL_VIP + "/rest/findVipInfo.do", bodyMap, List.class);
        Map<String, Object> pagemap = new HashMap<>();
        if (vipInfoResult != null) {
            //会员编号
            pagemap.put("vipNo", vipInfoResult.get(0).get("vipNo"));
            //会员真实名称
            pagemap.put("realName", vipInfoResult.get(0).get("realName"));
            //第一个电话
            pagemap.put("firstPhoneNO", vipInfoResult.get(0).get("firstPhoneNo"));
            //第二个电话
            pagemap.put("secondPhoneNo", vipInfoResult.get(0).get("secondPhoneNo"));
        }
        //代金券
        pagemap.put("tkAmtList", result.get("cpn"));
        //积分
        if(!CollectionUtils.isEmpty(integralMap)){//判断integralMap集合是否为空

            pagemap.put("accPoint",integralMap.get("accPoint"));
        }
        pagemap.put("siteList",siteList);
        pagemap.put("prdDtlList",prdDtlList);
        pagemap.put("ordNo",params.get("ordNo"));
        pagemap.put("ordId",params.get("ordId"));
        System.out.println(pagemap+"----------");
        modelAndView.addObject("map",pagemap);
        return modelAndView;
    }






    /**
     * 退货
     * @param
     * @return
     */

    @RequestMapping("sales")
    @ResponseBody
    public Map<String, Object> sales(@RequestParam Map<String, Object> params) {

        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String, Object> backSales = restTemplate.postForObject(HOST_URL_ORD + "/rest/backSales.do", bodyMap, Map.class);
        return backSales;
    }

    /**
     * 同品换货
     * @param
     * @return
     */
    @RequestMapping("barter")
    @ResponseBody
    public Map<String, String> barter(@RequestParam Map<String, String> params) {
        ModelAndView modelAndView = new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String, String> backSales = restTemplate.postForObject(HOST_URL_ORD + "/rest/change.do", bodyMap, Map.class);
        return backSales;
    }

    /**
     * 异品换货页面
     * @param
     * @return
     */
    @RequestMapping("otherBarter")
    public ModelAndView otherBarter(@RequestParam String prdDtlNo, String ordNo) {
        ModelAndView modelAndView = new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> bodyMap = new LinkedMultiValueMap();
        bodyMap.add("prdDtlNo", prdDtlNo);
        List<Map<String, String>> backSales = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrdForPrdDtl.do", bodyMap, List.class);
        modelAndView.addObject("list", backSales);
        modelAndView.addObject("prdDtlNo", prdDtlNo);
        modelAndView.addObject("ordNo", ordNo);
        modelAndView.setViewName("otherBarter");
        return modelAndView;
    }

    /**
     * 异品换货交换
     *
     * @param params
     * @return
     */
    @RequestMapping("otherBarterFrom")
    @ResponseBody
    public Map<String, Object> otherBarterFrom(@RequestParam Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String, Object> barterDifferent = restTemplate.postForObject(HOST_URL_ORD + "/rest/barterDifferent.do", bodyMap, Map.class);
        return barterDifferent;
    }



    /**
     * 打开添加订单评论页面
     *
     * @return
     */
    @RequestMapping("addEvaluate")
    public ModelAndView addEvaluate(@RequestParam Map<String, Object> params) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("params", params);//包含prdNo和订单ordNo和prdDtlNo
        modelAndView.setViewName("addEvaluate");//跳转追加评论页面
        return modelAndView;
    }

    /**
     * 添加订单评论
     *
     * @param params
     * @return
     */
    @RequestMapping("addEvaluateForm")
    @ResponseBody
    public Map<String, Object> addEvaluateForm(@RequestParam Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);
        Map<String, Object> addEvaluate = restTemplate.postForObject(HOST_URL_ORD + "/rest/addEvaluate.do", bodyMap, Map.class);//添加追加评论表
        return addEvaluate;
    }


    /**
     * 带着订单信息表的数据到order页面
     *
     * @param params
     * @param
     * @return
     */
    @RequestMapping("orderFrom")
    public ModelAndView indentFrom(@RequestParam Map<String, Object> params) {
        System.out.println(params);
        if ("0".equals(params.get("ordStsCd"))) {
            params.remove("ordStsCd");
            params.put("ordStsCd","");
        }
        System.out.println(params);
        ModelAndView modelAndView = new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);//参数：vipNo
        Map<String, Object> findOrderInfo = restTemplate.postForObject(HOST_URL_ORD + "/rest/findOrderInfo.do", bodyMap, Map.class);
        List orderInfo = (List) findOrderInfo.get("list");
        modelAndView.addObject("page", findOrderInfo);
        modelAndView.addObject("list", orderInfo);
        modelAndView.addObject("params", params);
        modelAndView.setViewName("order");
        return modelAndView;
    }

    /**
     * 点击取消判断是否取消成功
     *
     * @param params
     * @param
     * @return
     */
    @RequestMapping("updateOrder")
    @ResponseBody
    public Map<String, Object> updateOrder(@RequestParam Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);//参数：ordNo，vipId,ordStsCd
        Map<String, Object> result = restTemplate.postForObject(HOST_URL_ORD + "/rest/CancellationOfOrder.do", bodyMap, Map.class);
        return result;
    }

    /**
     * 根据ordNo和vipNo查找订单主信息和订单明细然后跳到prdDtl页面
     *
     * @param params
     * @return
     */
    @RequestMapping("prdDtl")
    public ModelAndView prdDtl(@RequestParam Map<String, Object> params) {
        ModelAndView modelAndView = new ModelAndView();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        bodyMap.setAll(params);//参数：ordNo和vipNo
        Map<String, Object> findOrderInfoAndDtl = restTemplate.postForObject(HOST_URL_ORD + "/rest/findOrderInfoAndDtl.do", bodyMap, Map.class);
        List ordAndDtllist = (List) findOrderInfoAndDtl.get("list");


        //  确定全退还是部分退还是都不能退
        bodyMap.add("ordNo", params.get("ordNo"));
        Map<String, Object> result1 = restTemplate.postForObject(HOST_URL_ORD + "/rest/findOrdDtlIsReturn.do", bodyMap, Map.class);
        modelAndView.addObject("result", result1);
        modelAndView.addObject("ordNo", params.get("ordNo"));
        modelAndView.addObject("page", findOrderInfoAndDtl);
        modelAndView.addObject("list", ordAndDtllist);
        modelAndView.setViewName("prdDtl");
        return modelAndView;
    }

    /**
     * 订单添加
     */
    @RequestMapping("addOrder")
    public ModelAndView addOrder(@RequestParam Map<String, Object> params, HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        Map<String, Object> vipInfo1 = (Map<String, Object>) request.getSession().getAttribute("vipInfo");
        if (CollectionUtils.isEmpty(vipInfo1)) {

            modelAndView.setViewName("login");
        } else {

            List<Map<String, Object>> res = new ArrayList<>();
            if (params.get("num1") != null) {
                String[] a1 = ((String) params.get("num1")).split(",");
                String[] a2 = ((String) params.get("price2")).split(",");
                String[] a3 = ((String) params.get("prdDtlNo1")).split(",");
                for (int i = 0; i < a1.length; i++) {
                    String num = a1[i];
                    String price = a2[i];
                    String prdDtlNo = a3[i];
                    Map<String, Object> ress = new HashMap<>();
                    ress.put("prdDtlNo", prdDtlNo);
                    ress.put("num", num);
                    ress.put("salePrice", price);
                    res.add(ress);
                }
            }
            params.put("prdDtlList", res);

            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap bodyMap = new LinkedMultiValueMap();
            Map<String, Object> vipInfo = (Map) request.getSession().getAttribute("vipInfo");

            //调用会员查询
            params.put("vipId", vipInfo.get("vipId"));
            params.put("vipNo", vipInfo.get("vipNo"));
            bodyMap.setAll(params);
            List<Map<String, Object>> vipInfoResult = restTemplate.postForObject(HOST_URL_VIP + "/rest/findVipInfo.do", bodyMap, List.class);

            //调用商品详情
            List<Map<String, Object>> prdDtlList = new ArrayList<>();
            List<Map<String, Object>> size = (List) params.get("prdDtlList");
            if (size.size() == 0) {
                bodyMap.add("prdDtlNo", params.get("prdDtlNo"));
                Map<String, Object> prdResult = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrdDetailed.do", bodyMap, Map.class);
                //将商品数量加入到商品信息中
                prdResult.put("num", params.get("num"));
                prdDtlList.add(prdResult);
                bodyMap.setAll(prdResult);
            } else {
                bodyMap.add("product", params.get("prdDtlList"));
                prdDtlList = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrdDetailedForList.do", bodyMap, List.class);
            }

            //调用企划
            Map<String, Object> result = new HashMap<>();
            List<Map<String, Object>> size2 = (List) params.get("prdDtlList");
            if (size2.size() == 0) {
                bodyMap.add("product", prdDtlList);
                System.out.println("结算参数："+bodyMap);
                result = restTemplate.postForObject(HOST_URL_PLA + "/rest/getPlanning.do", bodyMap, Map.class);
            } else {
                bodyMap.add("product", params.get("prdDtlList"));
                System.out.println("结算参数："+bodyMap);
                result = restTemplate.postForObject(HOST_URL_PLA + "/rest/getPlanning.do", bodyMap, Map.class);
            }

            List<Map<String, Object>> x = (List<Map<String, Object>>) result.get("productPlan");
            for (int i = 0; i < x.size(); i++) {
                for (int j = 0; j < prdDtlList.size(); j++) {
                    if (x.get(i).get("prdDtlNo").equals(prdDtlList.get(j).get("prdDtlNo"))) {
                        prdDtlList.get(j).put("price", x.get(i).get("price"));
                        prdDtlList.get(j).put("plan", x.get(i).get("plan"));
                    }
                }
            }

            //积分接口
            Map<String, Object> integralMap = restTemplate.postForObject(HOST_URL_VIP + "/rest/findAccPoint.do", bodyMap, Map.class);

            //地址接口
            bodyMap.add("vipNo", vipInfo.get("vipNo"));
            List<Map<String, Object>> siteList = restTemplate.postForObject(HOST_URL_VIP + "/rest/showSite.do", bodyMap, List.class);


            //订单添加接口
            Map<String, Object> params1 = new HashMap<>();
            params1.put("vipNo", vipInfoResult.get(0).get("vipNo"));
            params1.put("ordPice", params.get("salePrice"));
            bodyMap.setAll(params1);
            Map<String, String> orderId = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrder.do", bodyMap, Map.class);
            if (!"success".equals(orderId.get("result"))) {
                modelAndView.setViewName("error");
                return modelAndView;
            }
            //查询订单编号及状态接口
            bodyMap.add("ordId", orderId.get("ordId"));
            Map<String, Object> orderNoMap = restTemplate.postForObject(HOST_URL_ORD + "/rest/selectOrderNo.do", bodyMap, Map.class);
            System.out.println(orderNoMap + "shadasdsadsada");
            //订单详情添加接口
            bodyMap.add("ordNo", orderNoMap.get("ordNo"));
            bodyMap.add("ordSts", orderNoMap.get("ordSts"));
            for (int i = 0; i < prdDtlList.size(); i++) {
                bodyMap.setAll(prdDtlList.get(i));
                Map<String, Object> orderDtlId = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrderDtl.do", bodyMap, Map.class);
                prdDtlList.get(i).put("ordDtlId", orderDtlId.get("ordDtlId"));
                if (!"success".equals(orderDtlId.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }
            }

            //订单状态表添加
            Map<String, Object> stateValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrderStateChange.do", bodyMap, Map.class);
            if (!"success".equals(stateValue.get("result"))) {
                modelAndView.setViewName("error");
                return modelAndView;
            }
            //库存占用接口
            //获取库存
            MultiValueMap<String,Object> prdDtlListMap = new LinkedMultiValueMap<>();
            prdDtlListMap.add("prdDtlList", prdDtlList);
            System.out.println("prdDtlList>>>>>>>>>>"+prdDtlList);
            Map<String, Object> mapMap = restTemplate.postForObject(HOST_URL_PRD + "/rest/produceOrder.do", prdDtlListMap, Map.class);
            if (mapMap.get("result").equals("success")) {
                List<Map<String, Object>> list = (List<Map<String, Object>>) mapMap.get("ware");
                Map<String, Object> orderW = new HashMap<>();
                //双重for循环一一对应
                for (int i = 0; i < list.size(); i++) {
                    String prdDtlNo = (String) list.get(i).get("prdDtlNo");
                    if (prdDtlNo.equals(prdDtlList.get(i).get("prdDtlNo"))) {
                        int ordDtlId = (int) prdDtlList.get(i).get("ordDtlId");
                        MultiValueMap<String, Object> orderMap = new LinkedMultiValueMap<String, Object>();
                        orderMap.add("ordDtlId", ordDtlId);
                        //查询订单明细
                        Map<String, Object> orderValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/findOnlyOrdDtlInfo.do", orderMap, Map.class);
                        if (!CollectionUtils.isEmpty(orderValue)) {
                            orderMap.add("ware", list);
                            orderMap.add("order", orderValue);
                            //添加订单仓储接口
                            orderW = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrderW.do", orderMap, Map.class);
                            if (!"success".equals(orderW.get("result"))) {
                                modelAndView.setViewName("error");
                                return modelAndView;
                            }

                        } else {
                            modelAndView.setViewName("error");
                            return modelAndView;
                        }
                    }
                    else{
                        modelAndView.setViewName("error");
                        return modelAndView;
                    }
                }
            }
        else{
            modelAndView.setViewName("error");
            return modelAndView;
        }

            Map<String, Object> pagemap = new HashMap<>();
            //订单主表ID
            pagemap.put("ordId", orderId.get("ordId"));
            pagemap.put("ordNo", orderNoMap.get("ordNo"));
            if (vipInfoResult != null) {
                //会员编号
                pagemap.put("vipNo", vipInfoResult.get(0).get("vipNo"));
                //会员真实名称
                pagemap.put("realName", vipInfoResult.get(0).get("realName"));
                //第一个电话
                pagemap.put("firstPhoneNO", vipInfoResult.get(0).get("firstPhoneNo"));
                //第二个电话
                pagemap.put("secondPhoneNo", vipInfoResult.get(0).get("secondPhoneNo"));
            }
            //代金券
            pagemap.put("tkAmtList", result.get("cpn"));
            //积分
            if (!CollectionUtils.isEmpty(integralMap)) {

                pagemap.put("accPoint", integralMap.get("accPoint"));
            }

            //添加登录人
            pagemap.put("userName", vipInfo.get("vipAccount"));
            //会员地址
            pagemap.put("siteList", siteList);
            //商品信息
            pagemap.put("prdDtlList", prdDtlList);
            modelAndView.addObject("map", pagemap);
            modelAndView.setViewName("pay");
        }
        return modelAndView;
    }

    @RequestMapping("messagesPage")
    @ResponseBody
    public Map<String, Object> messagesPage(@RequestParam Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap bodyMap = new LinkedMultiValueMap();
        //System.out.println(params);
        Map<String, Object> result = new HashMap<>();
        result.put("prdDtlNo", params.get("prdDtlNo"));
        result.put("spNo", params.get("spNo"));
        result.put("num", params.get("prdCount"));
        result.put("price", params.get("price"));
        List list = new ArrayList();
        list.add(result);
        bodyMap.add("product", list);
        Map<String, Object> pageValue = restTemplate.postForObject(HOST_URL_PLA + "/rest/getGifts.do", bodyMap, Map.class);
        System.out.println(pageValue);
        return pageValue;
    }

    @RequestMapping("addPayInfo")
    public ModelAndView addPayInfo(@RequestParam Map<String, Object> params, @RequestParam String[] spNos, HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        MultiValueMap<String, Object> ordMap = new LinkedMultiValueMap();
        Map<String, Object> result = new HashMap<>();
        result.put("result", "success");
        int returnPoint = 0;
        //params当中需要用到的
        //获取总积分
        String sumPoint = (String) params.get("sumPoint");
        //获取订单ID
        String ordId = (String) params.get("ordId");
        //订单价格
        double orderPrice = 0;
        double realPrice = 0;
        //代金券金额
        String cpnNo = null;
        String cpnSum = null;
        if (!StringUtils.isEmpty(params.get("cpnContent"))) {
            cpnSum = params.get("cpnContent").toString().split(",")[1];
            //代金券Id
            cpnNo = params.get("cpnContent").toString().split(",")[0];
        }
        Map<String, Object> vipInfo = (Map<String, Object>) request.getSession().getAttribute("vipInfo");
        //查询会员余额
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap vipMap = new LinkedMultiValueMap();
        vipMap.add("vipId", vipInfo.get("vipId"));
        Map<String, Object> vipValue = restTemplate.postForObject(HOST_URL_VIP + "/rest/findVipMoney.do", vipMap, Map.class);
        if (!CollectionUtils.isEmpty(vipValue)) {
            if ((Double) vipValue.get("accSum") > Double.parseDouble((String) params.get("payNum"))) {
                //积分均摊
                //建立一个集合去遍历页面上获取的数据
                List<Map<String, Object>> htmlList = new ArrayList<>();
                if (StringUtils.isEmpty(params.get("prdDtlNo11"))) {
                    String[] a1 = ((String) params.get("prdDtlNo1")).split(",");
                    String[] a2 = ((String) params.get("salePrice1")).split(",");
                    String[] a3 = ((String) params.get("prdCount1")).split(",");
                    String[] a4 = ((String) params.get("sumMoney1")).split(",");
                    String[] a5 = ((String) params.get("ordDtlId1")).split(",");
                    String[] a6 = ((String) params.get("tpCd1")).split(",");
                    String prdDtl = "";
                    for (int i = 0; i < a1.length; i++) {
                        String prdDtlNo = a1[i];
                        String salePrice = a2[i];
                        String prdCount = a3[i];
                        String sumMoney = a4[i];
                        String ordDtlId = a5[i];
                        String tpCd = a6[i];
                        BigDecimal temp1 = new BigDecimal(sumMoney);
                        BigDecimal temp2 = new BigDecimal(prdCount);
                        BigDecimal temp3 = new BigDecimal(salePrice);
                        realPrice = realPrice + temp1.multiply(temp2).doubleValue();
                        orderPrice = orderPrice + temp3.multiply(temp2).doubleValue();
                        String spNo = null;
                        //怎么去把spNo拿出来
                        if (spNos.length != 0) {
                            for (int j = 0; j < spNos.length; j++) {
                                if (!"0".equals(spNos[j])) {
                                    if (spNos[j].split("_")[1].equals(prdDtlNo)) {
                                        spNo = spNos[j].split("_")[0];
                                        break;
                                    }
                                }
                            }
                        }
                        Map<String, Object> htmlData = new HashMap<>();
                        htmlData.put("prdDtlNo", prdDtlNo);
                        htmlData.put("salePrice", salePrice);
                        htmlData.put("prdCount", prdCount);
                        htmlData.put("sumMoney", sumMoney);
                        htmlData.put("ordDtlId", ordDtlId);
                        htmlData.put("tpCd", tpCd);
                        htmlData.put("spNo", spNo);
                        htmlList.add(htmlData);
                    }
                }
                //添加发票
                //判断:tpCD,payNum
                for(int i=0;i<htmlList.size();i++){
                    if(Double.parseDouble((String) params.get("payNum")) > 1500 || "100".equals(htmlList.get(i).get("tpCd")) || "110".equals(htmlList.get(i).get("tpCd"))){
                        if (!StringUtils.isEmpty(params.get("billHeader"))) {
                            MultiValueMap<String, Object> billMap = new LinkedMultiValueMap<>();
                            billMap.add("billAmount", params.get("payNum"));
                            //添加：ordId,vipNo,payNum,billNumber,billHeader
                            billMap.add("vipNo", vipInfo.get("vipNo"));
                            billMap.add("ordId", ordId);
                            billMap.add("billHeader", params.get("billHeader"));
                            billMap.add("billNumber", params.get("billNumber"));
                            billMap.add("ctrlRate", params.get("ctrlRate"));
                            Map<String, Object> billValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/addBillInfo.do", billMap, Map.class);
                            if (!"success".equals(billValue.get("result"))) {
                                modelAndView.setViewName("error");
                                return modelAndView;
                            }
                            else {
                                ordMap.add("billId",billValue.get("billId"));
                                break;
                            }
                        }
                        else{
                            modelAndView.setViewName("error");
                            return modelAndView;
                        }
                    }
                    else{
                        if(!StringUtils.isEmpty(params.get("billHeader"))){
                            MultiValueMap<String, Object> billMap = new LinkedMultiValueMap<>();
                            billMap.add("billAmount", params.get("payNum"));
                            //添加：ordId,vipNo,payNum,billNumber,billHeader
                            billMap.add("vipNo", vipInfo.get("vipNo"));
                            billMap.add("ordId", ordId);
                            billMap.add("billHeader", params.get("billHeader"));
                            billMap.add("billNumber", params.get("billNumber"));
                            billMap.add("ctrlRate", params.get("ctrlRate"));
                            Map<String, Object> billValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/addBillInfo.do", billMap, Map.class);
                            if (!"success".equals(billValue.get("result"))) {
                                modelAndView.setViewName("error");
                                return modelAndView;
                            }
                            else{
                                ordMap.add("billId",billValue.get("billId"));
                                break;
                            }
                        }
                        else {
                            break;
                        }
                    }
                }
                //遍历取出价格均摊
                if (StringUtils.isEmpty(sumPoint)) {
                    sumPoint = "0";
                }
                if (!CollectionUtils.isEmpty(htmlList) && !StringUtils.isEmpty(sumPoint)) {
                    try {
                        for (int i = 0; i < htmlList.size(); i++) {
                            //double类型-乘除高精度运算
                            BigDecimal payNum = new BigDecimal((String) params.get("payNum"));

                            BigDecimal price = new BigDecimal((String) htmlList.get(i).get("sumMoney"));
                            //中间变量,每个商品明细价格除以总价
                            BigDecimal temp1 = price.divide(payNum, 2, BigDecimal.ROUND_HALF_DOWN);
                            //积分乘以上面求出的值
                            BigDecimal temp2 = new BigDecimal(Double.parseDouble(sumPoint));
                            //每个订单明细应该得到的积分
                            int igAmt = (int) temp2.multiply(temp1).doubleValue();
                            //积分返还
                            MultiValueMap<String, List<Map<String, Object>>> pointMap = new LinkedMultiValueMap<>();
                            Map<String, Object> pointInfo = new HashMap<>();
                            String spNo = (String) htmlList.get(i).get("spNo");
                            Map<String, Object> payValue = new HashMap<>();
                            List<Map<String, Object>> product = new ArrayList<>();

                            //更新订单明细
                            MultiValueMap<String, Object> ordDtlMap = new LinkedMultiValueMap<>();
                            ordDtlMap.add("ordDtlId", htmlList.get(i).get("ordDtlId"));
                            ordDtlMap.add("igAmt", igAmt);
                            ordDtlMap.add("cashAmt", htmlList.get(i).get("sumMoney"));
                            ordDtlMap.add("spNo", spNo);
                            Map<String, Object> ordDtlValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/updateOrderDtl.do", ordDtlMap, Map.class);
                            if (!"success".equals(ordDtlValue.get("result"))) {
                                modelAndView.setViewName("error");
                                return modelAndView;
                            }
                            //判断企划
                            if (!StringUtils.isEmpty(spNo)) {
                                //gift
                                pointInfo.put("spNo", spNo);
                                pointInfo.put("prdDtlNo", htmlList.get(i).get("prdDtlNo"));
                                pointInfo.put("price", htmlList.get(i).get("sumMoney"));
                                pointInfo.put("num", htmlList.get(i).get("prdCount"));
                                product.add(pointInfo);
                                pointMap.add("product", product);
                                payValue = restTemplate.postForObject(HOST_URL_PLA + "/rest/getGifts.do", pointMap, Map.class);

                            }
                            if (!CollectionUtils.isEmpty(payValue)) {
                                if ("60".equals(payValue.get("conType"))) {
                                    if (Double.parseDouble((String) params.get("payNum")) > 0) {
                                        BigDecimal tempMoney = new BigDecimal((String)params.get("payNum"));
                                        BigDecimal tempPoint = new BigDecimal(payValue.get("doubleIntegral").toString());
                                        returnPoint = (int) tempMoney.multiply(tempPoint).doubleValue();
                                    }
                                } else {
                                    if (Double.parseDouble((String) params.get("payNum")) > 0) {
                                        returnPoint = (int) Double.parseDouble((String) params.get("payNum"));
                                    }
                                }
                                //System.out.println("积分加倍： "+returnPoint);
                                //满赠添加订单明细
                                if ("20".equals(payValue.get("conType"))) {
                                    MultiValueMap<String, Object> giftMap = new LinkedMultiValueMap<>();
                                    List<Map<String, Object>> list = (List<Map<String, Object>>) payValue.get("gifts");
                                    if (!CollectionUtils.isEmpty(list)) {
                                        giftMap.add("prdName", list.get(0).get("prdName"));
                                        giftMap.add("prdDtlName", list.get(0).get("prdDtlName"));
                                        giftMap.add("tpName", list.get(0).get("tpName"));
                                        giftMap.add("prdNo", list.get(0).get("prdNo"));
                                        giftMap.add("tpCd", list.get(0).get("tpCd"));
                                        giftMap.add("ordNo", params.get("ordNo"));
                                        giftMap.add("prdDtlNo", list.get(0).get("prdDtlNo"));
                                        giftMap.add("isReturn", list.get(0).get("isReturn"));
                                        giftMap.add("iptPrice", list.get(0).get("iptPrice"));
                                        giftMap.add("salePrice", 0);
                                        giftMap.add("num", 1);
                                        giftMap.add("vipNo", vipInfo.get("vipNo"));
                                        /*giftMap.add("spNo",spNo);
                                        giftMap.add("cashAmt",0);
                                        giftMap.add("igAmt",0);*/
                                        Map<String, Object> giftValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrdDtl.do", giftMap, Map.class);
                                        if (!"success".equals(giftValue.get("result"))) {
                                            modelAndView.setViewName("error");
                                            return modelAndView;
                                        }
                                    }
                                }
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                //调用积分返还接口
                MultiValueMap returnPointMap = new LinkedMultiValueMap();
                Map<String, Object> returnPointInfo = new HashMap<>();
                returnPointInfo.put("id", vipInfo.get("vipId"));
                returnPointInfo.put("ordNo", params.get("ordNo"));
                returnPointInfo.put("vipNo", vipInfo.get("vipNo"));
                returnPointInfo.put("payIntegral", returnPoint);
                returnPointMap.setAll(returnPointInfo);
                Map<String, Object> returnPointValue = restTemplate.postForObject(HOST_URL_VIP + "/rest/returnPoint.do", returnPointMap, Map.class);
                if (!"success".equals(returnPointValue.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }
                //添加支付信息
                MultiValueMap bodyMap = new LinkedMultiValueMap();
                Map<String, Object> payInfo = new HashMap<>();
                //获取订单ID
                payInfo.put("ordId", ordId);
                //积分金额
                if (!StringUtils.isEmpty(params.get("sumPoint"))) {
                    BigDecimal payNum = new BigDecimal((String) params.get("sumPoint"));
                    BigDecimal RATIO = new BigDecimal("100");
                    BigDecimal pointMoney = payNum.divide(RATIO, 2, BigDecimal.ROUND_HALF_DOWN);
                    payInfo.put("igAmt", pointMoney);
                }
                //账户金额
                payInfo.put("cashAmt", params.get("payNum"));
                //代金券金额
                payInfo.put("cpnAmt", cpnSum);
                //会员编号
                payInfo.put("vipNo", vipInfo.get("vipNo"));
                bodyMap.setAll(payInfo);
                Map<String, Object> payValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrdPayRec.do", bodyMap, Map.class);
                if (!"success".equals(payValue.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }

                //去更改账户余额和积分还有代金券
                MultiValueMap vipAccValue = new LinkedMultiValueMap();
                Map<String, Object> vipAccMap = new HashMap<>();

                vipAccMap.put("id", vipInfo.get("vipId"));
                vipAccMap.put("vipNo", vipInfo.get("vipNo"));
                vipAccMap.put("cpnNo", cpnNo);
                vipAccMap.put("payIntegral", sumPoint);
                vipAccMap.put("payMoney", params.get("payNum"));
                vipAccMap.put("ordNo", params.get("ordNo"));
                vipAccValue.setAll(vipAccMap);
                Map<String, Object> vipAccountInfo = restTemplate.postForObject(HOST_URL_VIP + "/rest/pay.do", vipAccValue, Map.class);
                if (!"success".equals(vipAccountInfo.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }

                //更新订单主表
                //地址ID
                int vipAddressId = Integer.parseInt((String) params.get("vipAddressId"));
                //查询地址接口
                MultiValueMap<String, Object> addrMap = new LinkedMultiValueMap();
                addrMap.add("vipNo", vipInfo.get("vipNo"));
                addrMap.add("vipAddressId", vipAddressId);
                List<Map<String, Object>> addrValue = restTemplate.postForObject(HOST_URL_VIP + "/rest/showSite.do", addrMap, List.class);
                int addrP = 0;
                int addrC = 0;
                String addrD = null;
                if (!CollectionUtils.isEmpty(addrValue)) {
                    addrP = (int) addrValue.get(0).get("provinceId");
                    addrC = (int) addrValue.get(0).get("cityId");
                    addrD = (String) addrValue.get(0).get("addrInfo");
                }

                ordMap.add("addrP", addrP);
                ordMap.add("addrC", addrC);
                ordMap.add("addrD", addrD);
                ordMap.add("ordPrice", orderPrice);
                ordMap.add("realPrice", realPrice);
                ordMap.add("billPrice", params.get("payNum"));
                ordMap.add("delName", params.get("realName"));
                ordMap.add("ordId", ordId);

                //页面回传数据
                modelAndView.addObject("payNum", params.get("payNum"));
                modelAndView.addObject("addrP", addrValue.get(0).get("province"));
                modelAndView.addObject("addrC", addrValue.get(0).get("city"));
                modelAndView.addObject("addrD", addrD);
                modelAndView.addObject("delName", params.get("realName"));
                modelAndView.addObject("secondPhoneNo", params.get("secondPhoneNo"));

                Map<String, Object> ordValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/updateOrder.do", ordMap, Map.class);
                if (!"success".equals(ordValue.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }
                //添加订单状态表
                if ("success".equals(ordValue.get("result"))) {
                    MultiValueMap<String, Object> ordStateMap = new LinkedMultiValueMap();
                    ordStateMap.add("ordNo", params.get("ordNo"));
                    ordStateMap.add("ordSts", "200");
                    Map<String, Object> ordStateValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/addOrderStateChange.do", ordStateMap, Map.class);
                    if (!"success".equals(ordStateValue.get("result"))) {
                        modelAndView.setViewName("error");
                        return modelAndView;
                    }
                }
                //解除库存占用和库存出库
                //查询订单库存关系表(ordNo)直接在order中调取
                MultiValueMap<String, Object> orderWMap = new LinkedMultiValueMap();
                orderWMap.add("ordNo", params.get("ordNo"));

                Map<String, Object> orderWValue = restTemplate.postForObject(HOST_URL_ORD + "/rest/findOrdWR.do", orderWMap, Map.class);
                if (!"success".equals(orderWValue.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }
                //向会员表中添加消费金额(修改会员接口)
                //会员升级
                MultiValueMap<String, Object> vipLevelMap = new LinkedMultiValueMap();
                vipLevelMap.add("id", vipInfo.get("vipId"));
                vipLevelMap.add("payNum", params.get("payNum"));
                Map<String, Object> vipLevelValue = restTemplate.postForObject(HOST_URL_VIP + "/rest/vipUpgrade.do", vipLevelMap, Map.class);
                if (!"success".equals(vipLevelValue.get("result"))) {
                    modelAndView.setViewName("error");
                    return modelAndView;
                }
                /*Map<String, Object> vipLevelValue = restTemplate.postForObject(HOST_URL_VIP + "/rest/updateVipInfo.do", vipLevelMap, Map.class);
                if ("success".equals(vipLevelValue.get("result"))) {
                    vipLevelValue = restTemplate.postForObject(HOST_URL_VIP + "/rest/vipUpgrade.do", vipLevelMap, Map.class);
                    if (!"success".equals(vipLevelValue.get("result"))) {
                        modelAndView.setViewName("error");
                        return modelAndView;
                    }
                }*/
                //删除购物车
                if ("success".equals(result.get("result"))) {
                    MultiValueMap<String, Object> carMap = new LinkedMultiValueMap();
                    carMap.add("vipNo", vipInfo.get("vipNo"));
                    Map<String, Object> carValue = restTemplate.postForObject(HOST_URL_PRD + "/rest/deleteAllShopCar.do", carMap, Map.class);
                    if (!"success".equals(carValue.get("result"))) {
                        modelAndView.setViewName("error");
                        return modelAndView;
                    }
                }
            } else {
                modelAndView.setViewName("error");
                return modelAndView;
            }
        }
        if ("success".equals(result.get("result"))) {
            modelAndView.setViewName("/success");
        } else {
            modelAndView.setViewName("/error");
        }
        return modelAndView;
    }

    /**
     * 添加签收信息，签收后续流程
     * @param params
     * @return
     */
    // prd_dtl_no,sp_no,ord_sum,prd_count
    @RequestMapping("addSignin")
    public Map<String, Object> addSignin(@RequestParam Map<String, Object> params, HttpServletRequest request) {

        Map<String,Object> map=new HashMap<>();
        Map<String,Object> result=new HashMap<>();
        String ordStsCd=params.get("ordStsCd").toString();
        List  lm =new ArrayList();
        Map<String,Object> vipInfo= (Map<String, Object>) request.getSession().getAttribute("vipInfo");
        String id= vipInfo.get("vipId").toString();
        params.put("id",id);
        System.out.println(params);
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap();
        RestTemplate restTemplate = new RestTemplate();
        bodyMap.setAll(params);
        System.out.println("沙老大");
        if("200".equals(ordStsCd)){
            System.out.println("ordInfo");
            result=restTemplate.postForObject( "http://192.168.2.3:8888/rest/findOrdStsCd.do",bodyMap,Map.class);
     Map<String,Object>  mr=restTemplate.postForObject( "http://192.168.2.3:8888/rest/addSignin.do",bodyMap,Map.class);
        }else {
            result.put("reslut","error");
        }
        System.out.println(result);
        if ("success".equals(result.get("result"))){
            System.out.println(result);
            List<Map<String,Object>>  list=restTemplate.postForObject( "http://192.168.2.3:8888/rest/findPrdDtlNo.do",bodyMap,List.class);
            System.out.println(list);
            System.out.println("傻狗石子浩");
            for (int i=0;i<list.size();i++){
                String spNo= (String) list.get(i).get("sp_no");
                String prdDtlNo= (String) list.get(i).get("prd_dtl_no");
                String price= list.get(i).get("ord_sum").toString();
                String num=  list.get(i).get("prd_count").toString();
                if (!StringUtils.isEmpty(spNo)){
                    map.put("spNo",spNo);
                    map.put("prdDtlNo",prdDtlNo);
                    map.put("price",price);
                    map.put("num",num);
                    System.out.println(map+"杨");
                    lm.add(map);
                    System.out.println(lm);
                    bodyMap.add("product",lm);
                    result=restTemplate.postForObject( HOST_URL_PLA+"/rest/getGifts.do",bodyMap,Map.class);
                    if (!CollectionUtils.isEmpty(result)){
                        System.out.println(result+"getGifts");
                        System.out.println("傻狗苑林浩");
                        System.out.println(result);
                        String payMoney= result.get("backMoney").toString();
                        if(!StringUtils.isEmpty(payMoney)){
                            System.out.println(payMoney+"返现金额");
                            params.put("payMoney",payMoney);
                            System.out.println(params+"马狗");
                            bodyMap.setAll(params);
                            System.out.println(bodyMap);
                            result=restTemplate.postForObject( HOST_URL_VIP+"/rest/returnMoney.do",bodyMap,Map.class);
                            System.out.println("傻狗马");
                            result.put("result","success");
                            System.out.println(result+"返回马");
                        }else {
                            result.put("result","error");
                        }
                    }
                }else {
                    System.out.println("狮子好下边");
                    result.put("result","error");
                }
            }
        }else {
            result.put("result","success");//代表已签收
            System.out.println(result);
        }
        return result;
    }
}
