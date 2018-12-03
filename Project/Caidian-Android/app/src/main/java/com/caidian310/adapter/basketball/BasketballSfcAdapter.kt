package com.caidian310.adapter.basketball


import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.activity.sport.football.BaseBasketballAdapter
import com.caidian310.bean.sport.baskball.BasketballBean
import com.caidian310.bean.sport.baskball.BasketballHelp
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.presenter.football.FootBallPresenter
import com.caidian310.utils.ColorUtil
import com.caidian310.utils.TimeUtil
import com.caidian310.view.callBack.CallBasketballBeanBack
import com.caidian310.view.popupWindow.basketball.BasketBallSfcWindow
import com.umeng.analytics.pro.be


/**
 * icon_types_jclq-> 胜负差
 * Created by mac on 2017/11/17.
 */
class BasketballSfcAdapter(context: Activity, map: HashMap<String, ArrayList<BasketballBean>>) : BaseBasketballAdapter(context, map) {


    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_bf_row, null)
            holder.chose = convertView!!.findViewById(R.id.foot_item_row_chose)
            holder.home = convertView.findViewById(R.id.foot_item_row_home)
            holder.away = convertView.findViewById(R.id.foot_item_row_away)
            holder.single = convertView.findViewById(R.id.row_single)
            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)
            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }

        val bean = map[list[groupPosition]]?.get(childPosition)
        setChoseTextString(textView = holder.chose!!, list = BasketballHelp().getChoseBetList(bean!!))


        holder.single!!.visibility = View.GONE
        holder.home!!.text = bean.home3
        holder.away!!.text = bean.away3
        holder.time?.text = TimeUtil.getFormatTime(bean?.saleEndTime!!, "HH:mm") + """ 截止"""
        holder.leagueName?.text = bean.leagueName
        holder.leagueName?.setTextColor(Color.parseColor(bean?.color))
        holder.week?.text = bean.serial


        if (bean.sfcFixed == 0) {
            holder.chose!!.isEnabled = false
            holder.chose!!.setTextColor(ColorUtil.getColor(R.color.blueHigh))

        } else {
            holder.chose!!.isEnabled = true
            holder.chose!!.setTextColor(ColorUtil.getColor(R.color.colorPrimaryDark))

        }


        val popupWindowCallBack: CallBasketballBeanBack = object : CallBasketballBeanBack {
            override fun onClickListener(basketballBean: BasketballBean, choseList: ArrayList<BetBean>) {
                BasketballHelp().resetBetBean(basketballBean = bean)

                var match: Match? = null
                for ((key,_) in choseMap){
                    if (key.id == bean.id) match = key
                }

                if (match !== null) choseMap.remove(match)

                choseList.forEach {
                    BasketballHelp().updateBetBean(betBean = it, basketballBean = bean)
                    FootBallPresenter.addJczq(match = bean.getMatchBean(), jczq = it, choseMap = choseMap)
                }
                callAdapterBack?.onClickListener()
                setChoseTextString(textView = holder.chose!!, list = choseList)
            }


        }


        holder.chose!!.setOnClickListener {
            val popWindow = BasketBallSfcWindow(context = context, choseMap = choseMap)
            popWindow.showPopupWindow(textView = holder.chose!!, match = bean.getMatchBean(), basketballBean = bean)
            popWindow.setCallBack(popupWindowCallBack)
        }


        return convertView
    }


    /**
     * 显示已经选择的文字
     * @param textView 控件
     * @param list 所有选中的项的集合
     */

    fun setChoseTextString(textView: TextView, list: ArrayList<BetBean>) {
        var choseString = ""
        var count = 0
        list.forEach {
            if (it.status) {
                choseString += it.jianChen + " "
                count++
            }
        }
        textView.text = if (count == 0) "点击选择胜负差投注" else choseString
    }


    class ViewHolder {
        var chose: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var single: ImageView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null


    }


}


