package com.lanou.cn.service.impl;

//import com.lanou.cn.mapper.UserMapper;

import com.lanou.cn.service.UService;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

/**
 * Created by landfash on 2017/7/8.
 */
@Service
public class UserService implements UService {

    public static final String HOST_URL="http://127.0.0.1:8088";

//    @Resource
//    private UserMapper userMapper;

    private String account;

    public String getAccount(){
        return account;
    }

//    public boolean getUser(Map<String,String> params) {
////        List<Map<String,String>> listMap = userMapper.getUser();
//        for(int i = 0 ; i < listMap.size() ; i ++){
//            if(params.get("account").equals(listMap.get(i).get("account"))&&
//                    params.get("password").equals(listMap.get(i).get("password"))){
//                account = params.get("account");
//                return true;
//            }
//        }
//        return false;
//    }

//    public void inUser(Map<String, Object> params) {
//        userMapper.inUser(params);
//    }
//
//    public boolean registerAjax(Map<String,Object> params){
//        List<Map<String,String>> listMap = userMapper.getUser();
//        String account = (String)params.get("account");
//        String phone = (String)params.get("phone");
//        if(null!=account){
//            for(int i = 0 ; i < listMap.size() ; i ++){
//                if(account.equals(listMap.get(i).get("account"))){
//                    return false;
//                }
//            }
//        }
//        else if (null!=phone){
//            for(int i = 0 ; i < listMap.size() ; i ++){
//                if(phone.equals(listMap.get(i).get("phone"))){
//                    return false;
//                }
//            }
//        }
//        return true;
//    }

//    public List<Map<String, Object>> getCar(Map<String, Object> params) {
//        if(null!=account){
//            params.put("account",account);
//            System.out.println(params.get("account"));
//            return userMapper.getCar(params);
//        }else{
//            return null;
//        }
//    }

//    public Map<String,String> toCar(Map<String,Object> params){
//        Map<String,String> flage = new HashMap();
//        if(null!=account){
//            System.out.println(account+"...");
//            params.put("account",account);
//            System.out.println(params.get("account"));
//            List<Map<String,Object>> userGoods = userMapper.getCar(params);
//            int goodsId = Integer.parseInt((String) params.get("goods_id"));
//            if(null!=userGoods&&userGoods.size()>0){
//                for(int i = 0 ; i < userGoods.size() ; i ++){
//                    int id = (Integer) userGoods.get(i).get("goods_id");
//                    if(id==goodsId){
//                        flage.put("flage","haven");
//                        return flage;
//                    }
//                }
//            }
//            userMapper.toCar(params);
//            flage.put("flage","true");
//            return flage;
//        }else{
//            System.out.println(account+"---");
//            flage.put("flage","noacc");
//            return flage;
//        }
//    }

//    public void outCar(Map<String,Object> params){
//        userMapper.outCar(params);
//    }

    @Override
    @ResponseBody
    public Map<String, Object> vipIntegral(Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        if(null!=params.get("currentPage")){
            bodyMap.add("currentPage",  params.get("currentPage"));
        }

        Map<String,Object> result=restTemplate.postForObject(HOST_URL + "/rest/vipIntegral.do",bodyMap,Map.class);
        return result;
    }

//    @Override
//    public List<Map<String, Object>> getAllShop(Map<String,Object> params) {
//        return userMapper.getAllShop(params);
//    }


}
