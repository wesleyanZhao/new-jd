package com.lanou.cn.service;

import java.util.Map;

/**
 * Created by Lanou3G on 2017/8/1.
 */
public interface OrderService {

    /**
     * 添加订单评论
     * @param params
     * @return
     */
    Map<String,Object> addEvaluate(Map<String,Object> params);
}
