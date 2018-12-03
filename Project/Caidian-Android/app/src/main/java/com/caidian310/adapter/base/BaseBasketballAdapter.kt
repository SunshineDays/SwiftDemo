package com.caidian310.activity.sport.football

import android.app.Activity
import android.content.Context
import android.text.Html
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseExpandableListAdapter
import android.widget.ImageView
import android.widget.TextView
import com.caidian310.R
import com.caidian310.bean.sport.baskball.BasketballBean
import com.caidian310.bean.sport.football.BetBean
import com.caidian310.bean.sport.football.Match
import com.caidian310.view.callBack.CallBack

/**
 * icon_types_jclq-> BaseAdapter
 * Created by mac on 2017/11/17.
 */
open class BaseBasketballAdapter(var context: Activity, var map: HashMap<String, ArrayList<BasketballBean>>) : BaseExpandableListAdapter() {

    override fun getChildView(groupPosition: Int, childPosition: Int, isLastChild: Boolean, convertView: View?, parent: ViewGroup?): View? {
       return convertView
    }


    var choseMap: LinkedHashMap<Match, ArrayList<BetBean>> = LinkedHashMap()
    var callAdapterBack: CallBack? = null


    var list: ArrayList<String> = ArrayList()


    init {
        list.clear()
        list.addAll(map.keys)
    }


    fun setCallBack(callBack: CallBack) {
        this.callAdapterBack = callBack
    }

    override fun getGroup(groupPosition: Int): ArrayList<BasketballBean>? = map[list[groupPosition]]

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
     * 单行显示  显示当打开的样式  是否选中
     * @param edgeLeftBoolean  是否需要左边框
     */

    fun openBackGround(view: TextView, betBean: BetBean, edgeLeftBoolean: Boolean = false) {
        if (betBean.status) {
            view.setBackgroundResource(R.drawable.select_item)
        } else {
            view.setBackgroundResource(if (edgeLeftBoolean)R.drawable.edge_top_right_bottom_left else R.drawable.edge_top_right_bottom)
        }

    }




    /**
     * 设置文字单行
     * @param view  控件
     * @param sp 赔率
     * @param letBall 让分
     * @param title  主负/主胜
     * @param status 是否选中
     */


    fun setOneLineTextColorString(view: TextView, betBean: BetBean) {
        val titleColor = if (betBean.status) "#ffffff" else "#333333"
        val spColor = if (betBean.status) "#ffffff" else "#666666"
        view.text = Html.fromHtml("<font color='$titleColor'>${betBean.jianChen}</font> <font color='$spColor'>${betBean.sp}</font>")
    }


    /**
     * 单行显示时的样式
     * 修改控件的点击效果
     */

    fun changeViewBackGround(view: TextView, betBean: BetBean, edgeLeftBoolean: Boolean = false) {
        if (betBean.status) {
            betBean.status = false
            view.setBackgroundResource(if (edgeLeftBoolean) R.drawable.edge_top_right_bottom_left else R.drawable.edge_top_right_bottom)
            return
        }
        betBean.status = true
        view.setBackgroundResource(R.drawable.select_item)
    }



    /**
     * 修改控件的点击效果
     */

    fun changeTwoLineViewBackGround(view: TextView, betBean: BetBean, edgeBoolean: Boolean = false) {
        if (betBean.status) {
            betBean.status = false
            view.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)
            return
        }
        betBean.status = true
        view.setBackgroundResource(R.drawable.select_item)
    }

    /**
     * 两行显示
     * 显示当打开的样式  是否选中
     *
     */

    fun openTwoLineBackGround(view: TextView, betBean: BetBean, edgeBoolean: Boolean = false, letBall: Double? = null) {
        if (!betBean.status) {
            view.setBackgroundResource(if (edgeBoolean) R.drawable.edge_top_right_bottom else R.drawable.edge_right_bottom)
        } else {
            view.setBackgroundResource(R.drawable.select_item)
        }
        setTwoLineTextColorString(view = view,betBean = betBean, letBall = letBall)
    }




    /**
     * 设置文字两行显示
     * @param view  控件
     * @param sp 赔率
     * @param letBall 让分
     * @param title  主负/主胜
     * @param status 是否选中
     */


    fun setTwoLineTextColorString(view: TextView, betBean: BetBean, letBall: Double? = null) {
        val titleColor = if (betBean.status) "#ffffff" else "#333333"
        val spColor = if (betBean.status) "#ffffff" else "#666666"

        var letBallColor =  "#ffffff"
        if (letBall!=null){
            letBallColor = when(letBall >0){
                true -> "#ff0000"
                else -> "#63B8FF"
            }
        }
        if (betBean.status) letBallColor =   "#ffffff"
        val letString = if (letBall!=null) "<font color='$letBallColor'>(${if (letBall>0) "+$letBall" else letBall})</font>" else ""
        view.text = Html.fromHtml("<font color='$titleColor'>${betBean.typeString}</font>$letString<br /><font color='$spColor'>${betBean.sp}</font>")
    }




}


