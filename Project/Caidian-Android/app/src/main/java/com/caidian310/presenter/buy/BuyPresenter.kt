package com.caidian310.presenter.buy

import com.caidian310.bean.buy.Bet
import com.caidian310.bean.buy.BuyBean
import com.caidian310.bean.buy.MatchInfo

import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match


/**
 *
 * 下单购买相关类
 * Created by mac on 2018/1/26.
 */
object BuyPresenter {

    /**
     * 拼接返回接口的下注购彩参数
     * @param  serialList 串关集合
     * @param map 选择的元数据
     */


    fun getBetBuyBean(
            map: LinkedHashMap<Match, ArrayList<BetBean>>,
            lotteryId: Int = 0,
            playId: Int = 0,
            orderTypeId: Int = 0,
            multiple: Int = 1,
            betCount: Int,
            totalMoney: Double,
            issue: String = "",
            serialList: ArrayList<String> = ArrayList(),  //串关方式
            isSecret: Int = 0                             //保密设置Order_type ==3 时 0: 公开无佣金 ,1:截止后公开无佣金


    ): BuyBean {

        val matchList: ArrayList<MatchInfo> = ArrayList()
        for ((key, value) in map) {
            val betArrayList: ArrayList<Bet> = ArrayList()
            value.forEach {
                betArrayList.add(Bet(bet_key = it.key, sp = it.sp))
            }
            matchList.add(MatchInfo(id = key.id, let_ball = key.letBall, is_must_bet = key.clickWave, bet_list = betArrayList,dxf_num = key.dxfNum))
        }

        return BuyBean(
                lottery_id = lotteryId,
                play_id = playId,
                bet_count = betCount,
                total_money = totalMoney,
                order_type = orderTypeId,
                multiple = multiple,
                issue = issue,
                is_secret = isSecret,
                serial_list = serialList,
                match_list = matchList)


    }






}



