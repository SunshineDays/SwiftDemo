package com.caidian310.adapter.base

import android.app.Activity
import android.content.Context
import android.text.Html
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseExpandableListAdapter
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.enumBean.BetTypeEnum
import com.caidian310.bean.enumBean.PlayIdEnum
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.FootballBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.utils.BetUtil
import com.caidian310.utils.ColorUtil
import com.caidian310.view.callBack.CallFootballBeanBack
import com.caidian310.view.popupWindow.footBall.FootBallBfWindow


/**
 * 竞彩足球-> BaseAdapter
 * Created by mac on 2017/11/17.
 */
open class BaseFootballAdapter(var context: Activity, var map: HashMap<String, ArrayList<FootballBean>>) : BaseExpandableListAdapter() {



    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View? {
        return convertView
    }


    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
    var callFootballBeanBack: CallFootballBeanBack? = null
    var betUtil : BetUtil = BetUtil()

    var betType : String = BetTypeEnum.bqc.key
    var playEnum : PlayIdEnum = PlayIdEnum.hunhe


    var list: ArrayList<String> = ArrayList()


    init {
        list.clear()
        list.addAll(map.keys)
    }


    fun setCallBack(callFootballBeanBack: CallFootballBeanBack) {
        this.callFootballBeanBack = callFootballBeanBack
    }

    override fun getGroup(groupPosition: Int): ArrayList<FootballBean>? = map[list[groupPosition]]

    override fun isChildSelectable(groupPosition: Int, childPosition: Int): Boolean = true

    override fun hasStableIds(): Boolean = false

    //  获得父项显示的view
    override fun getGroupView(groupPosition: Int, isExpanded: Boolean, convertView: View?, parent: ViewGroup?): View {
        var convertView = convertView
        if (convertView == null) {
            val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            convertView = inflater.inflate(R.layout.foot_item_header, null)
        }
        val img = convertView!!.findViewById<ImageView>(R.id.foot_item_header_down)
        val count = convertView.findViewById<TextView>(R.id.foot_item_header_count)
        val bean = map[ArrayList(map.keys)[groupPosition]]
        count.text = Html.fromHtml("""${bean?.get(0)?.issue}&nbsp&nbsp&nbsp <font color='#FF0000'>${bean?.size}&nbsp </font>场可投""")
        img.rotation = if (isExpanded) 180f else 0f
        return convertView
    }


    override fun getChildrenCount(groupPosition: Int): Int = map[list[groupPosition]]?.size ?:0

    override fun getChild(groupPosition: Int, childPosition: Int): Any =
            map[list[groupPosition]]!![childPosition]

    override fun getGroupId(groupPosition: Int): Long = groupPosition.toLong()




    override fun notifyDataSetChanged() {
        list.clear()
        list = ArrayList(map.keys)
        super.notifyDataSetChanged()

    }


    override fun getChildId(groupPosition: Int, childPosition: Int): Long = childPosition.toLong()

    override fun getGroupCount(): Int = list.size


    /**
     * 显示控件的样式
     * @param textView 控件
     * @param betBean 样式选择条件
     * @param edgeBoolean 边框样式
     */
    fun setOpenTextViewBg(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {

        //选中
        if (betBean.status) {
            textView.setBackgroundResource(R.drawable.select_item)
            textView.setTextColor(ColorUtil.getColor(R.color.white))
            return
        }
        textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)
        textView.setTextColor(ColorUtil.getColor(R.color.grayThree))
        betBean.status = false

    }

    override fun notifyDataSetInvalidated() {

        list.clear()
        list.addAll(map.keys)
        super.notifyDataSetInvalidated()
    }




    /**
     * 点击控件 改变背景色
     * @param textView 控件
     * @param betBean 样式选择条件
     * @param edgeBoolean 边框样式
     */
    fun setClickTextViewBackGround(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {

        //选中
        if (!betBean.status) {
            textView.setBackgroundResource(R.drawable.select_item)
            textView.setTextColor(ColorUtil.getColor(R.color.white))
            betBean.status = true
            return
        }
        textView.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)
        textView.setTextColor(ColorUtil.getColor(R.color.grayThree))
        betBean.status = false

    }

    /**
     * 两行文字显示时的颜色和控件背景色
     */

    fun setTwoLineTextViewStyle(textView: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {
        setOpenTextViewBg(textView = textView, betBean = betBean, edgeBoolean = edgeBoolean)
        setTwoLineTextString(view = textView, betBean = betBean)
    }


    /**
     * 本adapter中的点击事件处理
     * @param textView     点击得控件
     * @param footballBean 本次点击得场次
     * @param betBean      本次点击得投注项
     * @param edgeBoolean  边框样式
     */

    fun onClickItem(textView: TextView, footballBean: FootballBean, betBean: BetBean, edgeBoolean: Boolean = false) {
        setClickTextViewBackGround(textView = textView, betBean = betBean, edgeBoolean = edgeBoolean)
        betUtil.addBetBean(match = footballBean.getMatchBean(), betBean = betBean, choseMap = choseMap)
        callFootballBeanBack?.callObjectBack(type = betType, footballBean = footballBean, map = choseMap)
        setTwoLineTextString(textView, betBean = betBean)

    }




    /**
     * 单行文字字体显示
     * @param view    控件
     * @param betBean 投注项
     */

    fun setOneLineTextColorString(view: TextView, betBean: BetBean) {
        val titleColor = if (betBean.status) "#ffffff" else "#333333"
        val spColor = if (betBean.status) "#ffffff" else "#666666"
        view.text = Html.fromHtml("<font color='$titleColor'>${betBean.jianChen}</font> <font color='$spColor'>${betBean.sp}</font>")
    }



    /**
     * 设置显示选择项的文字
     * @param textView 显示控件
     * @param choseCount 场次个数
     */
    fun setChoseTextString(textView: TextView, choseCount: Int) {
        textView.text = Html.fromHtml("已选择<font color='${if (choseCount > 0) "#FF4081" else "#666666"}'>$choseCount</font>场")

    }


    /**
     * 设置文字两行显示
     * @param view  控件
     * @param jczq 选择项数据
     */

    fun setTwoLineTextString(view: TextView, betBean: BetBean) {
        val colorString = if (betBean.status) "#ffffff" else "#333333"
        val testColorString = if (betBean.status) "#ffffff" else "#666666"
        view.text = Html.fromHtml("<font color='$colorString'>${betBean.jianChen}</font><br /><font color='$testColorString'>${betBean.sp}</font>")
    }

    /**
     * 显示单关样式
     * @param  single 是否支持单关
     * @param linearLayout 控件Id
     */

     fun showSingleStyle(single: Int = 0, linearLayout: LinearLayout) {

        linearLayout.setBackgroundResource(if (single == 1) {
            linearLayout.setPadding(2, 2, 2, 2)
            R.drawable.edge_top_right_bottom_left_press
        } else {
            linearLayout.setPadding(0, 0, 0, 0)
            0
        })

    }

}


