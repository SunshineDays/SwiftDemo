package com.caidian310.view.popupWindow

import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.AdapterView
import android.widget.ImageView
import android.widget.RelativeLayout
import com.caidian310.R
import com.caidian310.activity.base.BaseActivity
import com.caidian310.adapter.d11.D11PlayGridViewAdapter
import com.caidian310.utils.DensityUtil
import com.caidian310.view.callBack.CallPositionBack
import com.caidian310.view.custom.CustomGridView


/**
 *
 *  d11->玩法选择
 * Created by Administrator on 2017/10/31.
 */
class PlayTypeChoseWindow() : BasePopupWindow() {


    var title: String = ""
    var view:View ?=null
    private var backgroundView: View? = null
    private var imageView: ImageView? = null
    private var callBack: CallPositionBack? = null
    private var currentPosition: Int = 0
    private var activity : BaseActivity?= null

    private var gridView: CustomGridView?= null

    private var adapter :D11PlayGridViewAdapter ?= null
    private var titleList:ArrayList<String> = ArrayList()


    constructor(context: BaseActivity, imageView: ImageView, currentPosition: Int = 0, titleList: ArrayList<String>) : this() {
        view = LayoutInflater.from(context).inflate(R.layout.pop_d11_mode, null)
        this.currentPosition = currentPosition
        this.activity = context
        this.titleList = titleList

        this.gridView = view!!.findViewById(R.id.pop_d11_grid_view)
        backgroundView = view!!.findViewById(R.id.pop_d11_back_ground)
        backgroundView!!.background.alpha = 50
        backgroundView!!.setOnClickListener(this)

        adapter = D11PlayGridViewAdapter(context = activity!!,list = titleList,currentPosition = currentPosition)
        gridView?.adapter = adapter
        gridView!!.onItemClickListener = itemOnClickListener

        this.contentView = view                                       // 设置视图
        this.height = DensityUtil.getDisplayHeight(context) - DensityUtil.dip2px(activity,80f)
        this.width = RelativeLayout.LayoutParams.MATCH_PARENT
        this.isFocusable = true


        this.setOnDismissListener { imageView.rotation = 0f }
        this.imageView = imageView

    }


    override fun show(view: View) {
        super.show(view)
        if (this.isShowing) {
            this.dismiss()
            imageView?.rotation = 0f
            return
        }

        this.showAsDropDown(view,0, 0, Gravity.BOTTOM)
        imageView?.rotation = 180f


    }

    private var  itemOnClickListener = AdapterView.OnItemClickListener { _, _, position, _ ->
        adapter!!.customNotifyDataSetChanged(position)
        // 回调点击项
        callBack?.callPositionBack(position, titleList[position])
        this.dismiss()

    }


    override fun onClick(v: View?) {
        if (v?.id == R.id.pop_d11_back_ground) {
            this.dismiss()
            return
        }
    }




    /**
     * 回调选中项
     */
    fun setCallPositionBack(callPositionBack: CallPositionBack) {
        this.callBack = callPositionBack
    }


}