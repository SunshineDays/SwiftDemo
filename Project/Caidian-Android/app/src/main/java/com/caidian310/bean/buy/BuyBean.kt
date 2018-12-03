package com.caidian310.bean.buy

import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.OrderTypeEnum
import java.io.Serializable

///**
// * 购买
// * Created by mac on 2017/12/28.
// */
//data class BuyBean(
//        var lottery_id: Int = LotteryIdEnum.jczq.id,   //彩种Id
//        var order_type: Int = OrderTypeEnum.daigou.id, //订单类型 0:代购 ,2:追号 ,3:发单
//        var single_money: Double,                      // 单倍金额  total/multiple
//        var is_secret: Int = 0,                        //保密设置Order_type ==3 时 0: 公开无佣金 ,1:截止后公开无佣金
//        var multiple: Int = 1,                         //倍数
//        var bet_count: Int = 0,                        //注数
//        var play_id: Int = PlayIdEnum.hunhe.id,        //玩法
//        var total_money: Double = 0.00,                //总金额
//        var reason:String ="",                         //发单理由
//        var serial_list: ArrayList<String>,            //串关方式 1串1 2串1
//        var match_list: ArrayList<MatchInfo>           //投注赛事列表
//) : Serializable
//
///**
// * 投注赛事详情
// *
// */
//data class MatchInfo(
//        var id: Int,                 //id
//        var let_ball: Double,        //让球
//        var is_must_bet: Boolean,    //胆拖
//        var bet_list: ArrayList<Bet> //投注内容
//) : Serializable
//
//data class Bet(
//        var bet_key: String, //投注key bf_sp1
//        var sp: Double
//) : Serializable
/**
 * 购买
 * Created by mac on 2017/12/28.
 */
data class BuyBean(

        /**
         * 必传字段
         */
        var lottery_id: Int = LotteryIdEnum.jczq.id,   //彩种Id
        var play_id: Int =0 ,                          //玩法
        var bet_count: Int = 0,                        //注数
        var total_money: Double = 0.00,                //总金额
        var single_money: Double = 2.00,               // 单注金额  2 ||只有大乐透追加 =3
        var order_type: Int = OrderTypeEnum.Purchasing.id, //订单类型 0:代购 ,2:追号 ,3:发单

        /******************************************************
         *
         * 数字彩
         *
         * ****************************************************/

        var is_hit_stop: Boolean = false,                            //中奖停止
        var chase_list: ArrayList<Chase> = ArrayList(),              //追号每期的设置 最少为一个元素 大于一个元素则为追号   同一个期号只能添加一次不能重复
        var bet_list :ArrayList<ArrayList<Section>> = ArrayList(),   //投注项集合


        /******************************************************
         *
         * 足球篮球
         *
         * ****************************************************/
        var multiple: Int = 1,                                        //倍数
        var issue:String ="",                                         //期号

        /** 仅竞彩足球做发单 */
        var is_secret: Int = 0,                                       //保密设置Order_type ==3 时 0: 公开无佣金 ,1:截止后公开无佣金
        var reason: String = "",                                      //发单理由


        var serial_list: ArrayList<String> = ArrayList(),             //串关方式 1串1 2串1
        var match_list: ArrayList<MatchInfo> = ArrayList()           //投注赛事列表

) : Serializable

/**
 * 投注赛事详情
 *
 */
data class MatchInfo(
        var id: Int,                 //id
        var let_ball: Double,        //让球
        var is_must_bet: Boolean,    //胆拖
        var bet_list: ArrayList<Bet>,//投注内容
        var dxf_num :Double  =0.00   //大小分

) : Serializable

data class Bet(
        var bet_key: String, //投注key bf_sp1
        var sp: Double
) : Serializable


/**
 * 追号
 */
data class Chase(
        var multiple: Int,                  //倍数
        var issue: String                   //期号
):Serializable


/**
 * 块
 *
 * 一块代表一场比赛一种玩法
 */

data class Section(
        var type :String  ,                                     //投注类型PlayBetTypeEnum
        var ball_list : ArrayList<String>,                       //投注项集合  号码 可能为(01,02,03...32,33,大,小,单,双)
        var must_ball_list : ArrayList<String> = ArrayList()     //号码 可能为(01,02,03...32,33,大,小,单,双)
):Serializable


