package com.caidian310.presenter

import android.content.Context
import android.content.Intent
import android.os.Bundle
import com.caidian310.activity.buy.BuyActivity
import com.caidian310.activity.sport.basketball.BasketBallActivity
import com.caidian310.activity.sport.football.BallBetActivity
import com.caidian310.activity.sport.football.FootBallActivity
import com.caidian310.bean.buy.BuyBean
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.BetMatch
import com.caidian310.bean.sport.football.Match
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.utils.BetUtil
import com.caidian310.utils.SerializableMap
import com.caidian310.utils.ToastUtil

/**
 * Created by mac on 2018/2/6.
 * 保存activity启动参数
 */
object StartActivityPresenter {



    /**
     * 投注结算页面跳转 -> 竞彩足球||icon_types_jclq
     * @param context     实例
     * @param map         已经选择的场次
     * @param playType    玩法
     * @param lotteryType 彩种类型
     * */
    fun startBetActivity(
            context: Context,
            map: LinkedHashMap<Match, java.util.ArrayList<BetBean>>,
            playType: PlayIdEnum,
            lotteryType:LotteryIdEnum) {
        val boolean = BetUtil().judgeSingle(map = map)      //是否支持单关
        if (!boolean && map.size < 2) {                    // 不支持单关 || 并且场次<2  不进行跳转
            ToastUtil.showToast(FootBallPresenter.toastString)
            return
        }

        if (map.size>15){
            ToastUtil.showToast("选择场次太多,最多支持15场")
            return
        }

        val intent = Intent(context, BallBetActivity::class.java)
        val bundle = Bundle()
        bundle.putSerializable("choseMap", SerializableMap(map))
        bundle.putString("playType", playType.type)
        bundle.putInt("lotteryTypeId",lotteryType.id)
        intent.putExtras(bundle)
        context.startActivity(intent)

    }


    /**
     * 投注结算页面跳转 -> 竞彩足球||icon_types_jclq
     * @param context     实例
     * @param map         已经选择的场次
     * @param playType    玩法
     * @param lotteryType 彩种类型
     * */
    fun getBetActivityIntent(
            context: Context,
            map: LinkedHashMap<Match, java.util.ArrayList<BetBean>>,
            playType: PlayIdEnum,
            lotteryType:LotteryIdEnum):Intent? {
        val boolean = BetUtil().judgeSingle(map = map)      //是否支持单关
        if (!boolean && map.size < 2) {                    // 不支持单关 || 并且场次<2  不进行跳转
            ToastUtil.showToast(FootBallPresenter.toastString)
            return null
        }

        val intent = Intent(context, BallBetActivity::class.java)
        val bundle = Bundle()
        bundle.putSerializable("choseMap", SerializableMap(map))
        bundle.putString("playType", playType.type)
        bundle.putInt("lotteryTypeId",lotteryType.id)
        intent.putExtras(bundle)
       return intent

    }




    /**
     * 跳转到id指定的activity
     * @param lotteryId 彩种
     */

    fun startActivityFromId(context: Context, lotteryId: Int,currentPosition:Int = 1) {
        when (lotteryId) {

            LotteryIdEnum.jczq.id ->{
                val  intent =  Intent(context, FootBallActivity::class.java)
                intent.putExtra("currentPosition",currentPosition)
                context.startActivity(intent)
            }
            LotteryIdEnum.jclq.id -> context.startActivity(Intent(context, BasketBallActivity::class.java))
            else -> {
            }
        }
    }

    /**
     * 跳转到购买页面 ->所有购买的
     * @param context        实例
     * @param buyBean        购买参数
     * @param leagueNameList 已选择购买的联赛名(方便在购买页面展示->目前时候竞彩足球和竞彩篮球用到)
     */

    fun  startBuyActivity(context:Context, buyBean: BuyBean, leagueNameList: ArrayList<BetMatch> ?=null){
        val intent = Intent(context, BuyActivity::class.java)
        intent.putExtra("leagueNameList", leagueNameList)
        intent.putExtra("buyBean", buyBean)
        context.startActivity(intent)
    }


}
