package com.caidian310.adapter.football.bet

import android.content.Context
import android.graphics.Color
import android.os.Build
import android.support.annotation.RequiresApi
import android.view.LayoutInflater

import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.utils.ToastUtil.showToast
import com.caidian310.view.callBack.CallPositionBack


/**
 * 竞彩足球 -> 投注选项显示
 * Created by mac on 2017/11/17.
 */
class BetShowAdapter(var context: Context, var map: LinkedHashMap<Match, ArrayList<BetBean>>, var lotteryId: Int = LotteryIdEnum.jczq.id) : BaseAdapter() {

    var keyList: ArrayList<Match> = ArrayList()

    init {
        keyList = ArrayList(map.keys)
    }

    var choseWaveClickCount = 0    //已经选中的波胆个数
    var betCanClickCount = 0       //最大支持的波胆个数

    var callPositionBack: CallPositionBack? = null
    var deletePositionList: ArrayList<Int> = ArrayList()

    fun setCallPotionBack(callPositionBack: CallPositionBack) {
        this.callPositionBack = callPositionBack
    }


    @RequiresApi(Build.VERSION_CODES.N)
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        var con = convertView
        var holder: ViewHolder
        if (con == null) {
            con = LayoutInflater.from(context).inflate(R.layout.foot_ball_bet_item, null)
            holder = ViewHolder()
            holder.awayName = con!!.findViewById(R.id.bet_item_away)
            holder.homeName = con.findViewById(R.id.bet_item_home)
            holder.date = con.findViewById(R.id.bet_item_date)
            holder.week = con.findViewById(R.id.bet_item_week)
            holder.leagueName = con.findViewById(R.id.bet_item_name)
            holder.deleteImg = con.findViewById(R.id.bet_item_delete)
            holder.awayName = con.findViewById(R.id.bet_item_away)
            holder.content = con.findViewById(R.id.bet_item_content)
            holder.wave = con.findViewById(R.id.bet_item_wave)
            con.tag = holder
        } else {
            holder = con.tag as ViewHolder
        }


        val match = ArrayList(map.keys)[position]
        val betList = map[match]

        holder.deleteImg?.setColorFilter(ColorUtil.getColor(R.color.colorPrimaryDark))
        holder.wave?.visibility = if (lotteryId == LotteryIdEnum.jczq.id) View.VISIBLE else View.GONE


        run {
            holder.homeName!!.text = match.home
            holder.awayName!!.text = match.away
            holder.leagueName!!.text = match.leagueFullName
            holder.date!!.text = TimeUtil.getFormatTime(match.saleEndTime, "MM-dd")
            holder.week!!.text = match.serial
            holder.leagueName!!.setTextColor(Color.parseColor(match.color))
            holder.leagueName!!.text = match.leagueName

            var contentString = ""
            betList?.forEach { contentString += it.jianChen + "(${it.sp})  " }
            holder.content?.text = contentString
            holder.date?.text = match.issue.substring(5, match.issue.length)
        }


        // 设置波胆的显示样式
        setWaveStyle(match = match, textView = holder.wave!!)
        holder.content?.setOnClickListener {
            callPositionBack?.callPositionBack(position = choseWaveClickCount, describe = "update")
        }


        holder.wave?.setOnClickListener {
            clickWave(match = match, textView = holder.wave!!)
            callPositionBack?.callPositionBack(position = choseWaveClickCount, describe = "wave")
            notifyDataSetChanged()
        }

        holder.deleteImg?.setOnClickListener {
            map.remove(match)
            keyList.remove(match)
            callPositionBack?.callPositionBack(position = match.id, describe = "delete")
            deletePositionList.add(match.id)
            notifyDataSetChanged()
        }

        return con

    }


    /**
     * 最大的可点击数
     */

    fun notifyDataSetChange(betBigCanClickCount: Int) {
        this.betCanClickCount = betBigCanClickCount
        this.choseWaveClickCount = 0
        notifyDataSetChanged()
    }


    /**
     * 点击波胆
     * 确定点击之后还可以点击几项()
     */
    private fun clickWave(match: Match, textView: TextView) {


        //支持波胆选择 取消选中
        if (match.wave && match.clickWave) {
            textView.setBackgroundResource(R.drawable.angle_round_black_low)
            textView.setTextColor(ColorUtil.getColor(R.color.black))
            removeMatchWave(matchId = match.id)
            --choseWaveClickCount
            this.notifyDataSetChanged()
            return
        }

        //支持波胆选择 未选中 点击选中
        if (match.wave && !match.clickWave && choseWaveClickCount <= betCanClickCount) {
            textView.setBackgroundResource(R.drawable.bet_bg_click)
            textView.setTextColor(ColorUtil.getColor(R.color.white))
            updateMatchWave(matchId = match.id, waveBoolean = true, clickWaveBoolean = true)
            ++choseWaveClickCount
            if (choseWaveClickCount == betCanClickCount) updateMatchWave()
            this.notifyDataSetInvalidated()
            return
        }

        if (choseWaveClickCount >= betCanClickCount) return

        //不支持波胆
        textView.setBackgroundResource(R.drawable.angle_round_gray)
        textView.setTextColor(ColorUtil.getColor(R.color.gray))
        updateMatchWave(matchId = match.id, waveBoolean = false)
        notifyDataSetChanged()
        showToast("请选择串关方式")

    }

    /**
     * 当当前选择了最大的支持项时   选中的项可以再次点击 其他的控件变暗
     */

    private fun updateMatchWave() {

        val newMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
        for ((key, value) in map) {
            if (key.clickWave) {
                key.wave = true
            } else {
                key.clickWave = false
                key.wave = false
            }
            newMap.put(key, value)

        }
        map.clear()
        map.putAll(newMap)

    }


    /**
     * 移除波胆
     * @param matchId 移除波胆的场次的标记
     */

    private fun removeMatchWave(matchId: Int) {

        val newMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
        for ((key, value) in map) {
            if (key.id == matchId) {
                key.wave = true
                key.clickWave = false
            } else {
                key.wave = true
            }
            newMap.put(key, value)

        }
        map.clear()
        map.putAll(newMap)

    }

    /**
     * 添加波胆
     * @param matchId 添加波胆的场次的标记
     * @param waveBoolean 控件是否可点击  默认不可点击
     * @param clickWaveBoolean 控件是否已经点击  默认没选中
     */

    private fun updateMatchWave(matchId: Int, waveBoolean: Boolean = false, clickWaveBoolean: Boolean = false) {

        val newMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
        for ((key, value) in map) {
            if (key.id == matchId) {
                key.wave = waveBoolean
                key.clickWave = clickWaveBoolean
            }
            newMap.put(key, value)

        }
        map.clear()
        map.putAll(newMap)

    }


    /**
     * 波胆显示样式(不支持波胆的时候 clickBoolean 必须为 false)
     * @param match 实例
     * @param textView 控件
     */
    private fun setWaveStyle(match: Match, textView: TextView) {

        // 如果波胆个数 == 最大可选择波胆的个数
        if (choseWaveClickCount == betCanClickCount) {
            //支持波胆选择 选中
            if (match.clickWave) {
                textView.setBackgroundResource(R.drawable.bet_bg_click)
                textView.setTextColor(ColorUtil.getColor(R.color.white))
                return
            }
            //不支持波胆
            textView.setBackgroundResource(R.drawable.angle_round_gray)
            textView.setTextColor(ColorUtil.getColor(R.color.gray))
            return
        }

        //支持波胆选择 没选中
        if (match.wave && !match.clickWave) {
            textView.setBackgroundResource(R.drawable.angle_round_black_low)
            textView.setTextColor(ColorUtil.getColor(R.color.black))
            return
        }
        //支持波胆选择 已经选中
        if (match.wave && match.clickWave) {
            textView.setBackgroundResource(R.drawable.bet_bg_click)
            textView.setTextColor(ColorUtil.getColor(R.color.white))
            return
        }
        //不支持波胆
        textView.setBackgroundResource(R.drawable.angle_round_gray)
        textView.setTextColor(ColorUtil.getColor(R.color.gray))
    }


    override fun getItem(position: Int): java.util.ArrayList<BetBean>? = map[keyList[position]]

    override fun getItemId(position: Int): Long = position.toLong()


    override fun getCount(): Int = map.size


    /**存放控件*/
    class ViewHolder {
        var date: TextView? = null
        var week: TextView? = null
        var number: TextView? = null
        var wave: TextView? = null   // 波胆
        var content: TextView? = null
        var homeName: TextView? = null
        var awayName: TextView? = null
        var deleteImg: ImageView? = null

        var leagueName: TextView? = null

    }

}
