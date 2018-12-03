package com.caidian310.view.custom

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.util.AttributeSet
import android.view.View
import android.view.ViewGroup



class CustomRecyclerView : RecyclerView{
    private var emptyView: View?= null

    constructor(context: Context?) : super(context)
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context?, attrs: AttributeSet?, defStyle: Int) : super(context, attrs, defStyle)

    private var  observer = object :AdapterDataObserver(){
        override fun onChanged() {

            val adapter = adapter
            if (adapter.itemCount == 0) {
                emptyView?.visibility = View.VISIBLE
                visibility = View.GONE
            } else {
                emptyView?.visibility = View.GONE
                visibility = View.VISIBLE
            }
            super.onChanged()

        }
    }

    fun setEmptyView(view: View) {
        this.emptyView = view
        (this.rootView as ViewGroup).addView(view)
    }

    override fun setAdapter(adapter: RecyclerView.Adapter<*>) {
        super.setAdapter(adapter)
        adapter.registerAdapterDataObserver(observer)
        observer.onChanged()
    }
}