package com.caidian310.view.custom;

import android.content.Context;
import android.support.v4.view.MotionEventCompat;
import android.support.v4.widget.SwipeRefreshLayout;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.ListView;

import com.caidian310.R;


/**
 * description : 上拉加载 下拉刷新
 * Created by wdb on 2017/4/18.
 */

public class RefreshLayout extends SwipeRefreshLayout implements AbsListView.OnScrollListener {
	/**
	 * 滑动到最下面时的上拉操作
	 */

	private int      mTouchSlop;
	/**
	 * listview实例
	 */
	private ListView mListView;

	/**
	 * 上拉监听器, 到了最底部的上拉加载操作
	 */
	private OnLoadListener mOnLoadListener;

	/**
	 * ListView的加载中footer
	 */
	private View mListViewFooter;

	/**
	 * 按下时的y坐标
	 */
	private int mYDown;
	/**
	 * 抬起时的y坐标, 与mYDown一起用于滑动到底部时判断是上拉还是下拉
	 */
	private int mLastY;
	/**
	 * 是否在加载中 ( 上拉加载更多 )
	 */
	private boolean isLoading = false;

	/**
	 * @param context
	 */
	public RefreshLayout(Context context) {
		this(context, null);
	}

	public RefreshLayout(Context context, AttributeSet attrs) {
		super(context, attrs);

		mTouchSlop = ViewConfiguration.get(context).getScaledTouchSlop();

		mListViewFooter = LayoutInflater.from(context).inflate(R.layout.listview_footer_loading, null, false);
		setColorSchemeResources(R.color.colorPrimaryDark);
	}

	@Override
	protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
		super.onLayout(changed, left, top, right, bottom);

		// 初始化ListView对象
		if (mListView == null) {
			getListView(this);
		}
	}


	/**
	 * 获取ListView对象
	 */
	public void getListView(View view) {
		if (view instanceof ListView) {
			mListView = (ListView) view;
			// 设置滚动监听器给ListView, 使得滚动的情况下也可以自动加载
			mListView.setOnScrollListener(this);
		} else {
			if (view instanceof ViewGroup) {
				for (int i = 0; i < ((ViewGroup) view).getChildCount(); i++) {
					View childAt = ((ViewGroup) view).getChildAt(i);
					getListView(childAt);
				}
			}
		}
	}


	@Override
	public boolean dispatchTouchEvent(MotionEvent event) {
		final int action = event.getAction();

		switch (action) {
			case MotionEvent.ACTION_DOWN:
				// 按下
				mYDown = (int) event.getRawY();
				break;

			case MotionEvent.ACTION_MOVE:
				// 移动
				mLastY = (int) event.getRawY();
				break;

			case MotionEvent.ACTION_UP:
				// 抬起
				if (canLoad()) {
					loadData();
				}
				break;
			default:
				break;
		}

		return super.dispatchTouchEvent(event);
	}

	/**
	 * 是否可以加载更多, 条件是到了最底部, listView不在加载中, 且为上拉操作.
	 *
	 * @return
	 */
	public boolean canLoad() {
		return isBottom() && !isLoading && isPullUp();
	}

	/**
	 * 判断是否到了最底部
	 */
	private boolean isBottom() {

		return mListView != null && mListView.getAdapter() != null && mListView.getLastVisiblePosition() == (mListView.getAdapter().getCount() - 1);
	}


	@Override
	public boolean isRefreshing() {
		return super.isRefreshing();
	}


	/**
	 * 是否是上拉操作
	 *
	 * @return
	 */
	private boolean isPullUp() {
		return mLastY != 0 && (mYDown - mLastY) >= mTouchSlop;
	}

	/**
	 * 如果到了最底部,而且是上拉操作.那么执行onLoad方法
	 */
	private void loadData() {
		if (mOnLoadListener != null) {
			// 设置状态
			setLoading(true);
			//
			mOnLoadListener.onLoad();
		}
	}

	/**
	 * @param loading
	 */
	public void setLoading(boolean loading) {
		isLoading = loading;
		if (isLoading) {
			mListView.addFooterView(mListViewFooter);
		} else {
			if (mListViewFooter == null||mListView==null) return;
			if (mListView.getFooterViewsCount()>0)mListView.removeFooterView(mListViewFooter);
			mYDown = 0;
			mLastY = 0;
		}
	}

	/**
	 * @param loadListener
	 */
	public void setOnLoadListener(OnLoadListener loadListener) {
		mOnLoadListener = loadListener;
	}

	@Override
	public void onScrollStateChanged(AbsListView view, int scrollState) {

	}

	@Override
	public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount,
						 int totalItemCount) {
		// 滚动时到了最底部也可以加载更多
		if (canLoad()) {
			loadData();
		}
	}

	/**
	 * 加载更多的监听器
	 *
	 * @author mrsimple
	 */
	public static interface OnLoadListener {
		public void onLoad();
	}

	float   lastx     = 0;
	float   lasty     = 0;
	boolean ismovepic = false;

	@Override
	public boolean onInterceptTouchEvent(MotionEvent ev) {
		if (ev.getAction() == MotionEvent.ACTION_DOWN) {
			lastx = ev.getX();
			lasty = ev.getY();
			ismovepic = false;
			return super.onInterceptTouchEvent(ev);
		}

		final int action = MotionEventCompat.getActionMasked(ev);
		// VLog.v(ev.getX() + "---" + ev.getY());

		int x2 = (int) Math.abs(ev.getX() - lastx);
		int y2 = (int) Math.abs(ev.getY() - lasty);

		//滑动图片最小距离检查
		//   VLog.v("滑动差距 - >" + x2 + "--" + y2);
		if (x2 > y2) {
			if (x2 >= 100) ismovepic = true;
			return false;
		}

		//是否移动图片(下拉刷新不处理)
		if (ismovepic) {
			// VLog.v("滑动差距 - >" + x2 + "--" + y2);
			return false;
		}

		boolean isok = super.onInterceptTouchEvent(ev);

		// VLog.v("isok ->" + isok);

		return isok;
	}

	/**
	 * 此方法解决listView与refreshLayout冲突问题
	 *
	 * @return
	 */
	@Override
	public boolean canChildScrollUp() {
		if (mListView != null) {
			final AbsListView absListView = (AbsListView) mListView;
			return absListView.getChildCount() > 0
					&& (absListView.getFirstVisiblePosition() > 0 || absListView.getChildAt(0)
					.getTop() < absListView.getPaddingTop());

		}
		return super.canChildScrollUp();
	}
}
