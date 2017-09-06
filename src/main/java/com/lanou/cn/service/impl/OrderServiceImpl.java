package com.lanou.cn.service.impl;

import com.lanou.cn.service.OrderService;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

/**
 * Created by Lanou3G on 2017/8/1.
 */
@Service
public class OrderServiceImpl implements OrderService {


    private static final String HOST_URL = "http://192.168.2.25:8888";

    /**
     * 添加订单评论
     * @param params
     * @return
     */
    @Override
    public Map<String, Object> addEvaluate(Map<String, Object> params) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
        bodyMap.setAll(params);
        Map<String,Object> result = restTemplate.postForObject(HOST_URL+"/rest/addEvaluate.do",bodyMap,Map.class);
        return result;
    }
}
