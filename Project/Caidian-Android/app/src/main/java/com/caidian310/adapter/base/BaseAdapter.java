package com.caidian310.adapter.base;

/**
 * 打造ListView的万能适配器
 */

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;

public abstract class BaseAdapter<T> extends android.widget.BaseAdapter {
	private Context        context;
	private List<T>        list;



	public BaseAdapter(Context context, List<T> list) {
		this.context = context;
		this.list = list;
	}

	@Override
	public int getCount() {
		return list == null ? 0 : list.size();
	}

	@Override
	public T getItem(int position) {
		return list.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		BaseViewHolder holder = getViewHolder(position,convertView,parent,getItemLayoutId(position));
		onBindHolder(holder,getItem(position),position);
		return holder.getConvertView();
	}

	public abstract void onBindHolder(BaseViewHolder holder, T item, int position);
	public abstract int getItemLayoutId(int position);

	private BaseViewHolder getViewHolder(int position, View convertView, ViewGroup parent, int itemLayoutId){
		return BaseViewHolder.Companion.get(context,convertView,parent,itemLayoutId,position);
	}

}
