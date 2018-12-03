package com.caidian310.adapter.base


import android.content.Context
import android.graphics.Bitmap
import android.util.SparseArray
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView

/**
 * 万能适配器的ViewHolder
 * Created by Administrator on 2017/9/1.
 */
class BaseViewHolder (context: Context, val parent: ViewGroup, itemLayoutId: Int, position: Int) {
    var views: SparseArray<View>? = null
    var convertView: View? = null

    init {
        this.views = SparseArray<View>()
        this.convertView = LayoutInflater.from(context).inflate(itemLayoutId, parent, false)
        convertView!!.tag = this
    }

    /**
     * 通过控件的Id获取对于的控件，如果没有则加入views
     */
    fun <T : View> getView(viewId: Int): T {
        var view: View? = views?.get(viewId)
        if (view == null) {
            view = convertView?.findViewById(viewId)
            views?.put(viewId, view)
        }
        return view!! as T
    }

    /**
     * 设置字符串
     */
    fun setText(viewId: Int, text: CharSequence?): TextView {
        val tv = getView<TextView>(viewId)
        tv.text = text
        return tv
    }

    /**
     * 设置图片
     */
    fun setImageResource(viewId: Int, drawableId: Int): BaseViewHolder {
        val iv = getView<ImageView>(viewId)
        iv.setImageResource(drawableId)
        return this
    }

    /**
     * 设置图片
     */
    fun setImageBitmap(viewId: Int, bitmap: Bitmap): BaseViewHolder {
        val iv = getView<ImageView>(viewId)
        iv.setImageBitmap(bitmap)
        return this
    }

    companion object {

        /**
         * 拿到一个ViewHolder对象
         */
        fun get(context: Context, convertView: View?, parent: ViewGroup, layoutId: Int, position: Int): BaseViewHolder {
            if (convertView == null) {
                return BaseViewHolder(context, parent, layoutId, position)
            }
            return convertView.tag as BaseViewHolder
        }
    }
}