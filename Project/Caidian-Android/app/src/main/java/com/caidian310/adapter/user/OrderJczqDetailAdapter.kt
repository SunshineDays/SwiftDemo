package com.caidian310.dapter.user

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
import com.caidian310.bean.sport.football.FootballHelp
import com.caidian310.utils.BetUtil
import com.caidian310.utils.ColorUtil


/**
 * 代购记录
 * Created by mac on 2017/11/17.
 */


class OrderJczqDetailAdapter(var context: Context, var payList: ArrayList<PayMatch>) : BaseAdapter() {

    var footballHelp: FootballHelp = FootballHelp()
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        var holder: ViewHolder
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
                    val betBean = footballHelp.getBetNameFromSp(bet)
                    content += if (index != payMatchInfo.betInfo.betList.size - 1)
                        "${betBean.jianChen}(${betBean.sp})\n"
                    else
                        "${betBean.jianChen}(${betBean.sp})"
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

            if (cancelBoolean) textView.text = Html.fromHtml("<font color='#7bb9ed'>取消</font>")
            else textView.text = Html.fromHtml(
                    "<font color='#FF0000'>半 ${payMatch.match.scoreHalf}</font><br />" +
                            "<font color='#7bb9ed'>全 ${payMatch.match.score}</font>")
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
        payMatch.betInfo.betList.forEachIndexed { index, bet ->
            val lastIndexBoolean = index == payMatch.betInfo.betList.size - 1

            if (betUtil.spfTypeName.contains(bet.bet_key)) {
                content += getRqSpfBetString(str, payMatch.match.letBall, bet, lastIndexBoolean)
            }

            if (betUtil.bqcTypeName.contains(bet.bet_key)) {
                content += getBqcBetString(str, bet, lastIndexBoolean)
            }

            if (betUtil.jqsTypeName.contains(bet.bet_key)) {
                content += getJqsBetString(str, bet, lastIndexBoolean)
            }

            if (betUtil.bfTypeName.contains(bet.bet_key)) {
                content += getBfBetString(str, bet, lastIndexBoolean)
            }

        }
        textView.text = Html.fromHtml(content)

    }

    /**

     * 半全场
     * @param bet 投资项
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */
    private fun getBqcBetString(str: List<String>, bet: Bet, lastIndexBoolean: Boolean): String {
        //让球胜 中奖

        val letBallNumber = when (bet.bet_key) {
            BetTypeEnum.bqc_sp00.key -> Pair(0, 0)
            BetTypeEnum.bqc_sp01.key -> Pair(0, 1)
            BetTypeEnum.bqc_sp03.key -> Pair(0, 3)
            BetTypeEnum.bqc_sp10.key -> Pair(1, 0)
            BetTypeEnum.bqc_sp11.key -> Pair(1, 1)
            BetTypeEnum.bqc_sp13.key -> Pair(1, 3)
            BetTypeEnum.bqc_sp30.key -> Pair(3, 0)
            BetTypeEnum.bqc_sp31.key -> Pair(3, 1)
            else -> Pair(3, 3)

        }
        var letBoolean = str[0].toInt() == letBallNumber.first && str[1].toInt() == letBallNumber.second

        /**
         * -1 未本场比赛取消的情况  默认中奖
         */
        return showBetString(bet = bet, betBoolean = if (str[0].toInt() != -1) letBoolean else true, lastIndexBoolean = lastIndexBoolean)

    }


    /**

     * 总进球数
     *
     * @param bet 投资项
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */
    private fun getJqsBetString(str: List<String>, bet: Bet, lastIndexBoolean: Boolean): String {

        val letBallNumber = when (bet.bet_key) {
            BetTypeEnum.jqs_sp0.key -> 0
            BetTypeEnum.jqs_sp1.key -> 1
            BetTypeEnum.jqs_sp2.key -> 2
            BetTypeEnum.jqs_sp3.key -> 3
            BetTypeEnum.jqs_sp4.key -> 4
            BetTypeEnum.jqs_sp5.key -> 5
            BetTypeEnum.jqs_sp6.key -> 6
            else -> 7
        }

        var letBoolean = false
        if (letBallNumber < 7 && str[0].toInt() + str[1].toInt() == letBallNumber) {
            letBoolean = true
        }
        if (letBallNumber == 7 && str[0].toInt() + str[1].toInt() >= letBallNumber) {
            letBoolean = true
        }
        return showBetString(bet = bet, betBoolean = if (str[0].toInt() != -1) letBoolean else true, lastIndexBoolean = lastIndexBoolean)
    }

    /**

     * 比分
     * @param bet 投资项
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */
    private fun getBfBetString(str: List<String>, bet: Bet, lastIndexBoolean: Boolean): String {

        val letBallNumber = when (bet.bet_key) {

            BetTypeEnum.bf_sp00.key -> Pair(0, 0)
            BetTypeEnum.bf_sp01.key -> Pair(0, 1)
            BetTypeEnum.bf_sp02.key -> Pair(0, 2)
            BetTypeEnum.bf_sp03.key -> Pair(0, 3)
            BetTypeEnum.bf_sp04.key -> Pair(0, 4)
            BetTypeEnum.bf_sp05.key -> Pair(0, 5)
            BetTypeEnum.bf_sp10.key -> Pair(1, 0)
            BetTypeEnum.bf_sp11.key -> Pair(1, 1)
            BetTypeEnum.bf_sp12.key -> Pair(1, 2)
            BetTypeEnum.bf_sp13.key -> Pair(1, 3)
            BetTypeEnum.bf_sp14.key -> Pair(1, 4)
            BetTypeEnum.bf_sp15.key -> Pair(1, 5)
            BetTypeEnum.bf_sp20.key -> Pair(2, 0)
            BetTypeEnum.bf_sp21.key -> Pair(2, 1)
            BetTypeEnum.bf_sp22.key -> Pair(2, 2)
            BetTypeEnum.bf_sp23.key -> Pair(2, 3)
            BetTypeEnum.bf_sp24.key -> Pair(2, 4)
            BetTypeEnum.bf_sp25.key -> Pair(2, 5)
            BetTypeEnum.bf_sp30.key -> Pair(3, 0)
            BetTypeEnum.bf_sp31.key -> Pair(3, 1)
            BetTypeEnum.bf_sp32.key -> Pair(3, 2)
            BetTypeEnum.bf_sp33.key -> Pair(3, 3)
            BetTypeEnum.bf_sp40.key -> Pair(4, 0)
            BetTypeEnum.bf_sp41.key -> Pair(4, 1)
            BetTypeEnum.bf_sp42.key -> Pair(4, 2)
            BetTypeEnum.bf_sp50.key -> Pair(5, 0)
            BetTypeEnum.bf_sp51.key -> Pair(5, 1)
            BetTypeEnum.bf_sp52.key -> Pair(5, 2)
            BetTypeEnum.bf_spA0.key -> Pair(3, 5)
            BetTypeEnum.bf_spA1.key -> Pair(4, 4)
            else -> Pair(5, 3)
        }

        var betBoolean = false
        if (str[0].toInt() >= 4 || str[1].toInt() >= 4) {
            betBoolean =
                    if (letBallNumber.first == 4 && letBallNumber.second == 4)    //平其他
                        str[0].toInt() == str[1].toInt()
                    else if (letBallNumber.first == 5 && letBallNumber.second == 3)    //胜其他
                        str[0].toInt() >= 5 && str[0].toInt() > str[1].toInt() && str[1].toInt()>=3    // 5>3
                    else if (letBallNumber.second == 5 && letBallNumber.first == 3)
                        str[1].toInt() >= 5 && str[1].toInt() > str[0].toInt() &&str[0].toInt() >=3
                    else
                        false

        } else if (str[0].toInt() == letBallNumber.first && str[1].toInt() == letBallNumber.second) {
            betBoolean = true
        }


        return showBetString(bet = bet, betBoolean = if (str[0].toInt() != -1) betBoolean else true, lastIndexBoolean = lastIndexBoolean)

    }


    /**
     * 让球  || 胜平负
     * @param bet     投注项
     * @param letBall 让球个数
     * @param str     主客得分
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */
    private fun getRqSpfBetString(str: List<String>, letBall: Double, bet: Bet, lastIndexBoolean: Boolean): String {

        val letBetBoolean = when (bet.bet_key) {
            BetTypeEnum.rqspf_sp3.key -> (str[0].toInt() + letBall.toInt() - str[1].toInt()) > 0
            BetTypeEnum.rqspf_sp1.key -> (str[0].toInt() + letBall.toInt() - str[1].toInt()) == 0
            BetTypeEnum.rqspf_sp0.key -> (str[0].toInt() + letBall.toInt() - str[1].toInt()) < 0
            BetTypeEnum.spf_sp3.key -> (str[0].toInt() - str[1].toInt()) > 0
            BetTypeEnum.spf_sp1.key -> (str[0].toInt() - str[1].toInt()) == 0
            BetTypeEnum.spf_sp0.key -> (str[0].toInt() - str[1].toInt()) < 0
            else -> false
        }
        //是否中奖  如果得分是-1  则比赛是后台取消  用户显示中奖
        return showBetString(bet = bet, betBoolean = if (str[0].toInt() != -1) letBetBoolean else true, lastIndexBoolean = lastIndexBoolean)

    }


    /**
     * 中奖高亮显示
     * @param bet 投资项
     * @param  betBoolean 本投注项师傅中奖
     * @param lastIndexBoolean  本投注项是否是最后一项投注项
     */

    private fun showBetString(bet: Bet, betBoolean: Boolean, lastIndexBoolean: Boolean): String {
        val betBean = footballHelp.getBetNameFromSp(bet)
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
