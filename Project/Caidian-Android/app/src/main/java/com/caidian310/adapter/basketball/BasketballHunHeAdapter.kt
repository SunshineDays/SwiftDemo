package com.caidian310.adapter.basketball


import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
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
import com.caidian310.view.popupWindow.basketball.BasketballHunHeWindow


/**
 * icon_types_jclq-> 混合
 * Created by mac on 2017/11/17.
 */
class BasketballHunHeAdapter(context: Activity, map: HashMap<String, ArrayList<BasketballBean>>) : BaseBasketballAdapter(context, map) {


    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        var holder: ViewHolder
        if (convertView == null) {
            holder = ViewHolder()
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.bask_item_hun, null)
            holder.chose = convertView!!.findViewById(R.id.item_bask_hun_chose)
            holder.home = convertView.findViewById(R.id.item_bask_hun_home)
            holder.away = convertView.findViewById(R.id.item_bask_hun_away)

            holder.homeWin = convertView.findViewById(R.id.item_bask_hun_home_win)
            holder.homeLetWin = convertView.findViewById(R.id.item_bask_hun_let_home_win)
            holder.awayWin = convertView.findViewById(R.id.item_bask_hun_away_win)
            holder.awayLetWin = convertView.findViewById(R.id.item_bask_hun_let_away_win)


            holder.letText = convertView.findViewById(R.id.row_let_txt)
            holder.noLetText = convertView.findViewById(R.id.row_no_let_txt)
            holder.week = convertView.findViewById(R.id.row_week)
            holder.leagueName = convertView.findViewById(R.id.row_lname)
            holder.time = convertView.findViewById(R.id.row_time)
            holder.hunFixed = convertView.findViewById(R.id.row_spf_fixed)
            holder.rqHunFixed = convertView.findViewById(R.id.row_rqspf_fixed)

            holder.sfFixedText = convertView.findViewById(R.id.item_bask_hun_sf_fixed)
            holder.rfsfFixedText = convertView.findViewById(R.id.item_bask_hun_rfsf_fixed)
            convertView.tag = holder
        } else {
            holder = convertView.tag as ViewHolder
        }

        val bean = map[list[groupPosition]]?.get(childPosition)

        val match = bean!!.getMatchBean()

        bean.let {

            run {
                if (bean.sfFixed == 0) {
                    holder.sfFixedText!!.visibility = View.VISIBLE
                    holder.homeWin!!.visibility = View.GONE
                    holder.awayWin!!.visibility = View.GONE
                } else {
                    holder.sfFixedText!!.visibility = View.GONE
                    holder.homeWin!!.visibility = View.VISIBLE
                    holder.awayWin!!.visibility = View.VISIBLE
                }
                if (bean.rfsfFixed == 0) {
                    holder.rfsfFixedText!!.visibility = View.VISIBLE
                    holder.homeLetWin!!.visibility = View.GONE
                    holder.awayLetWin!!.visibility = View.GONE
                } else {
                    holder.rfsfFixedText!!.visibility = View.GONE
                    holder.homeLetWin!!.visibility = View.VISIBLE
                    holder.awayLetWin!!.visibility = View.VISIBLE
                }
            }

            /**
             * 初始化显示样式
             */
            fun setTextBackGround() {
                openTwoLineBackGround(view = holder.awayWin!!, betBean = bean.sfSp0, edgeBoolean = true)
                openTwoLineBackGround(view = holder.homeWin!!, betBean = bean.sfSp3, edgeBoolean = true)
                openTwoLineBackGround(view = holder.awayLetWin!!, betBean = bean.rfsfSp0)
                openTwoLineBackGround(view = holder.homeLetWin!!, betBean = bean.rfsfSp3, letBall = match.letBall)
                setChoseTextString(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size
                        ?: 0)

            }


            setTextBackGround()

            /**
             * 初始化参数
             */

            run {

                holder.away!!.text = bean.away3
                holder.home!!.text = bean.home3
                setTwoLineTextColorString(holder.awayWin!!, bean.sfSp0, null)
                setTwoLineTextColorString(holder.homeWin!!, bean.sfSp3, null)
                setTwoLineTextColorString(holder.awayLetWin!!, bean.rfsfSp0, null)
                setTwoLineTextColorString(holder.homeLetWin!!, bean.rfsfSp3, bean.letBall)
            }

            /**
             * 点击事件
             */
            run {

                holder.awayWin!!.setOnClickListener {
                    setOnItemClick(view = holder.awayWin!!, match = match, betBean = bean.sfSp0, edgeBoolean = true)
                    setChoseTextString(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size
                            ?: 0)
                }
                holder.homeWin!!.setOnClickListener {
                    setOnItemClick(view = holder.homeWin!!, match = match, betBean = bean.sfSp3, edgeBoolean = true)
                    setChoseTextString(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size
                            ?: 0)
                }
                holder.awayLetWin!!.setOnClickListener {
                    setOnItemClick(view = holder.awayLetWin!!, match = match, betBean = bean.rfsfSp0)
                    setChoseTextString(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size
                            ?: 0)
                }
                holder.homeLetWin!!.setOnClickListener {
                    setOnItemClick(view = holder.homeLetWin!!, match = match, betBean = bean.rfsfSp3, letBall = match.letBall)
                    setChoseTextString(textView = holder.chose!!, count = choseMap[bean.getMatchBean()]?.size
                            ?: 0)
                }

                holder.time?.text = TimeUtil.getFormatTime(bean!!.matchTime, "HH:mm") + """ 截止"""
                holder.leagueName?.text = bean.leagueName
                holder.leagueName?.setTextColor(Color.parseColor(bean!!.color))
                holder.week?.text = bean.serial
            }

            /**
             * 展开更多
             */


            holder.chose!!.setOnClickListener {
                val popupWindow = BasketballHunHeWindow(context = context,textView = holder.chose!!, choseMap = choseMap)
                popupWindow.showPopupWindow(basketballBean = bean)
                popupWindow.setCallBack(object : CallBasketballBeanBack {
                    override fun onClickListener(basketballBean: BasketballBean, choseList: ArrayList<BetBean>) {

                        //更改修改项
                        choseList.forEach {
                            BasketballHelp().updateBetBean(betBean = it, basketballBean = bean)
                            FootBallPresenter.addJczq(match = match, jczq = it, choseMap = choseMap)
                        }
                        setTextBackGround()
                        callAdapterBack?.onClickListener()
                    }
                })
            }
        }



        return convertView
    }


    /**
     * 控件点击事件
     */
    fun setOnItemClick(view: TextView, match: Match, betBean: BetBean, edgeBoolean: Boolean = false, letBall: Double? = null) {
        changeTwoLineViewBackGround(view, betBean, edgeBoolean)
        FootBallPresenter.addJczq(match = match, jczq = betBean, choseMap = choseMap)
        setTwoLineTextColorString(view = view, betBean = betBean, letBall = letBall)
        callAdapterBack?.onClickListener()

    }


    /**
     * 显示选择了几项
     * @param textView 控件
     * @param count 已经选择的个数
     */

    fun setChoseTextString(textView: TextView, count: Int = 0) {
        textView.text = if (count == 0) "展\n开" else "已\n选\n$count\n项"
        textView.setBackgroundResource(if (count == 0) R.drawable.edge_top_right_bottom else R.drawable.select_item)
        textView.setTextColor(ColorUtil.getColor(if (count == 0) R.color.grayThree else R.color.white))
    }


    class ViewHolder {
        var chose: TextView? = null
        var home: TextView? = null
        var away: TextView? = null
        var noLetText: TextView? = null
        var letText: TextView? = null
        var week: TextView? = null
        var leagueName: TextView? = null
        var time: TextView? = null
        var hunFixed: TextView? = null
        var rqHunFixed: TextView? = null
        var homeWin: TextView? = null
        var homeLetWin: TextView? = null
        var awayWin: TextView? = null
        var awayLetWin: TextView? = null

        var sfFixedText: TextView? = null
        var rfsfFixedText: TextView? = null


    }


}


