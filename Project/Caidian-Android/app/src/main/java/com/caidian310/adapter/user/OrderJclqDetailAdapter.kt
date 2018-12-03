package com.caidian310.adapter.user

import android.content.Context
import android.text.Html
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.buy.Bet
import com.caidian310.bean.buy.PayMatch

import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.sport.baskball.BasketballHelp
import com.caidian310.utils.BetUtil
import com.caidian310.utils.ColorUtil


/**
 * 代购记录  icon_types_jclq
 * Created by mac on 2017/11/17.
 */


class OrderJclqDetailAdapter(var context: Context, var payList: ArrayList<PayMatch>) : BaseAdapter() {

    private var basketballHelp: BasketballHelp = BasketballHelp()
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        val holder: ViewHolder
        if (con == null) {
            con = LayoutInflater.from(context).inflate(R.layout.item_pay_record, null)
            holder = ViewHolder()
            holder.name = con!!.findViewById(R.id.item_pay_detail_name)
            holder.home = con.findViewById(R.id.item_pay_detail_home_name)
            holder.away = con.findViewById(R.id.item_pay_detail_home_away)
            holder.score = con.findViewById(R.id.item_pay_detail_score)
            holder.content = con.findViewById(R.id.item_pay_detail_content)
            con.tag = holder

        } else {
            holder = con.tag as ViewHolder
        }


        val payMatchInfo = payList[position]

        if (position == 0) {
            holder.name!!.text = "场次"
            holder.home!!.text = "主队"
            holder.away!!.text = "客队"
            holder.score!!.text = "比分"
            holder.score!!.setTextColor(ColorUtil.getColor(R.color.graySix))
            holder.content!!.text = "投注内容"
        } else {
            holder.name!!.text = payMatchInfo.match.serial
            holder.home!!.text = payMatchInfo.match.home
            holder.away!!.text = payMatchInfo.match.away

            val startMatchBoolean = setBfString(payMatch = payMatchInfo, textView = holder.score!!)


            if (!startMatchBoolean) {
                var content = ""
                payMatchInfo.betInfo.betList.forEachIndexed { index, bet ->
                    val betBean = basketballHelp.getBetNameFromSp(bet)
                    content += if (index != payMatchInfo.betInfo.betList.size - 1)
                        "${betBean.typeString}(${betBean.sp})\n"
                    else
                        "${betBean.typeString}(${betBean.sp})"
                }
                holder.content!!.text = content
            } else {
                setBetString(payMatchInfo, holder.content!!)
            }

        }


        return con
    }


    /**
     * 比分项 显示规则
     */

    private fun setBfString(payMatch: PayMatch, textView: TextView): Boolean {
        return if (TextUtils.isEmpty(payMatch.match.score)) {
            textView.text = "未开赛"
            textView.setTextColor(ColorUtil.getColor(R.color.blueHigh))
            false
        } else {
            val cancelBoolean = payMatch.match.score.split(":").count { it.toInt() == -1 } >0
            textView.text = Html.fromHtml("<font color='#7bb9ed'>${if (cancelBoolean) "取消" else "全 ${payMatch.match.score}"}</font>")
            textView.setTextColor(ColorUtil.getColor(R.color.graySix))
            true
        }
    }


    /**
     * 投注项  显示规则
     */
    private fun setBetString(payMatch: PayMatch, textView: TextView) {

        val str = payMatch.match.score.split(":")

        val betUtil = BetUtil()
        var content = ""

        val homeScore = str[0].toInt()
        val awayScore = str[1].toInt()
        payMatch.betInfo.betList.forEachIndexed { index, bet ->

            val lastIndexBoolean = index == payMatch.betInfo.betList.size - 1

            //icon_types_jclq 胜负
            if (betUtil.jclqSfTypeName.contains(bet.bet_key)) {
                content += getRqSpfBetString(homeScore, awayScore, payMatch.match.letBall, bet, lastIndexBoolean)
            }

            //icon_types_jclq 让分胜负
            if (betUtil.jclqRfsfTypeName.contains(bet.bet_key)) {
                content += getRqSpfBetString(homeScore, awayScore, payMatch.match.letBall, bet, lastIndexBoolean)
            }

            //icon_types_jclq 大小分
            if (betUtil.jclqDxfTypeName.contains(bet.bet_key)) {
                content += getDxfBetString(homeScore, awayScore, bet, payMatch.match.dxfNum, lastIndexBoolean)
            }

            //icon_types_jclq 胜负差
            if (betUtil.jclqSfcTypeName.contains(bet.bet_key)) {
                content += getSfcBetString(homeScore, awayScore, bet, lastIndexBoolean)
            }

        }
        textView.text = Html.fromHtml(content)

    }


    fun getDxfBetString(homeScore: Int, awayScore: Int, bet: Bet, dexNumber: Double, lastIndexBoolean: Boolean): String {
        var betBoolean = false

        if (homeScore + awayScore > dexNumber && bet.bet_key == BetTypeEnum.dxf_sp3.key) betBoolean = true
        if (homeScore + awayScore < dexNumber && bet.bet_key == BetTypeEnum.dxf_sp0.key) betBoolean = true

        return showBetString(bet = bet, betBoolean = if (homeScore != -1) betBoolean else true, lastIndexBoolean = lastIndexBoolean)

    }

    /**

     * 胜负差
     * @param bet 投资项
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */
    private fun getSfcBetString(homeScore: Int, awayScore: Int, bet: Bet, lastIndexBoolean: Boolean): String {
        val betUtil = BetUtil()

        //主胜
        val scoreList = when (bet.bet_key) {
            BetTypeEnum.sfc_sp11.key, BetTypeEnum.sfc_sp01.key -> arrayListOf(1..5)
            BetTypeEnum.sfc_sp12.key, BetTypeEnum.sfc_sp02.key -> arrayListOf(6..10)
            BetTypeEnum.sfc_sp13.key, BetTypeEnum.sfc_sp03.key -> arrayListOf(11..15)
            BetTypeEnum.sfc_sp14.key, BetTypeEnum.sfc_sp04.key -> arrayListOf(16..20)
            BetTypeEnum.sfc_sp15.key, BetTypeEnum.sfc_sp05.key -> arrayListOf(21..25)
            else -> arrayListOf(26)
        }

        var betBoolean = false

        //主
        if (betUtil.jclqHomeSfcTypeName.contains(bet.bet_key)) {
            if (homeScore - awayScore >= 26 || scoreList.contains(homeScore - awayScore)) betBoolean = true
        }
        //客
        if (betUtil.jclqAwaySfcTypeName.contains(bet.bet_key)) {
            if (awayScore - homeScore >= 26 || scoreList.contains(awayScore - homeScore)) betBoolean = true
        }

        return showBetString(bet = bet, betBoolean = if (homeScore != -1) betBoolean else true, lastIndexBoolean = lastIndexBoolean)

    }


    /**
     * icon_types_jclq || 胜负  让分胜负
     * @param bet 投资项
     * @param letBall 让球个数
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */
    private fun getRqSpfBetString(homeScore: Int, awayScore: Int, letBall: Double, bet: Bet, lastIndexBoolean: Boolean): String {


        var letBetBoolean = false   //是否中奖

        //让分 胜负
        if (bet.bet_key == BetTypeEnum.rfsf_sp3.key) {
            letBetBoolean = (homeScore + letBall - awayScore) > 0

        }
        //让分 负
        if (bet.bet_key == BetTypeEnum.rfsf_sp0.key) {
            letBetBoolean = (homeScore + letBall - awayScore) < 0
        }


        //胜负 胜
        if (bet.bet_key == BetTypeEnum.sf_sp3.key) {
            letBetBoolean = homeScore + awayScore > 0
        }

        //胜负 负
        if (bet.bet_key == BetTypeEnum.sf_sp0.key) {
            letBetBoolean = homeScore - awayScore < 0
        }

        return showBetString(bet = bet, betBoolean = if (homeScore != -1) letBetBoolean else true, lastIndexBoolean = lastIndexBoolean)

    }


    /**
     * 中奖高亮显示
     * @param bet 投资项
     * @param  betBoolean 本投注项师傅中奖
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */

    private fun showBetString(bet: Bet, betBoolean: Boolean, lastIndexBoolean: Boolean): String {
        val betBean = basketballHelp.getBetNameFromSp(bet)
        return when (betBoolean) {
            true -> {
                "<font color='#FF0000'>${betBean.jianChen}(${bet.sp})</font>" + if (!lastIndexBoolean) "<br />" else ""
            }
            false -> {
                "<font color='#666666'>${betBean.jianChen}(${bet.sp})</font>" + if (!lastIndexBoolean) "<br />" else ""

            }
        }
    }


    override fun getItem(position: Int): Int = payList.size

    override fun getItemId(position: Int): Long = position.toLong()


    override fun getCount(): Int = payList.size


    /**存放控件*/
    class ViewHolder {
        var name: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var score: TextView? = null
        var content: TextView? = null
    }

}
