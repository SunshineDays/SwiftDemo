package com.caidian310.utils;

import android.content.Context;
import android.graphics.Bitmap;
import android.widget.ImageView;

import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.assist.ImageScaleType;
import com.nostra13.universalimageloader.core.display.FadeInBitmapDisplayer;
import com.nostra13.universalimageloader.core.display.SimpleBitmapDisplayer;
import com.caidian310.R;
import com.youth.banner.loader.ImageLoader;

/**
 * description : 图片加载工具
 * Created by wdb on 2017/4/20.
 */

public class ImageLoaderUtil extends ImageLoader {

	/**
	 * ImageLoaderUtil options base配置
	 *
	 * @return
	 */
	private static DisplayImageOptions.Builder baseOptions() {
		return new DisplayImageOptions.Builder()
				.cacheInMemory(true).cacheOnDisk(true) //启用内存缓存 启用外存缓存
				.bitmapConfig(Bitmap.Config.RGB_565)
				.resetViewBeforeLoading(true)
				.displayer(new SimpleBitmapDisplayer())
				.imageScaleType(ImageScaleType.EXACTLY_STRETCHED)
				.displayer(new FadeInBitmapDisplayer(200));
	}


	/**
	 * 新闻列表 小图
	 */
	private static DisplayImageOptions options = baseOptions()
			.showImageOnLoading(R.mipmap.icon_no_img_small)     //加载图片时的图片
			.showImageOnFail(R.mipmap.icon_no_img_small)       //没有图片资源时的默认图片
			.showImageForEmptyUri(R.mipmap.icon_no_img_small)   //加载失败时的图片
			.build();

	/**
	 * 新闻列表 大图
	 */
	private static DisplayImageOptions optionsBig = baseOptions()
			.showImageOnLoading(R.mipmap.icon_no_img_big)
			.showImageOnFail(R.mipmap.icon_no_img_big)
			.showImageForEmptyUri(R.mipmap.icon_no_img_big)
			.build();

	/**
	 * 用户头像
	 */
	private static DisplayImageOptions optionsHeadImg = baseOptions()
			.showImageOnLoading(R.mipmap.ic_header_img_default)
			.showImageOnFail(R.mipmap.ic_header_img_default)
			.showImageForEmptyUri(R.mipmap.ic_header_img_default)
			.build();
//	/**
//	 * 球队logo
//	 */
//	private static DisplayImageOptions optionsLogo    = baseOptions()
//			.showImageOnLoading(R.mipmap.icon_logo_default)
//			.showImageOnFail(R.mipmap.icon_logo_default)
//			.showImageForEmptyUri(R.mipmap.icon_logo_default)
//			.build();

//	/**
//	 * 球队logo
//	 *
//	 * @param uri
//	 * @param imageView
//	 */
//	public static void displayTeamLogo(String uri, ImageView imageView) {
//		if (imageView.getTag() == null || !imageView.getTag().equals(uri)) {
//			com.nostra13.universalimageloader.core.ImageLoader.getInstance().displayImage(uri, imageView, optionsLogo);
//			imageView.setTag(uri);
//		}
//	}
	/**
	 * 新闻列表 小图
	 *
	 * @param uri
	 * @param imageView
	 */

	public static void displayItemSmall(String uri, ImageView imageView) {
		if (imageView.getTag() == null || !imageView.getTag().equals(uri)) {
			com.nostra13.universalimageloader.core.ImageLoader.getInstance().displayImage(uri, imageView, options);
			imageView.setTag(uri);
		}

	}

	/**
	 * 新闻列表 等大图类
	 *
	 * @param uri
	 * @param imageView
	 */
	public static void displayItemBig(String uri, ImageView imageView) {
		if (imageView.getTag() == null || !imageView.getTag().equals(uri)) {
			com.nostra13.universalimageloader.core.ImageLoader.getInstance().displayImage(uri, imageView, optionsBig);
			imageView.setTag(uri);
		}
	}


	/**
	 * 用户头像类
	 *
	 * @param uri
	 * @param imageView
	 */
	public static void displayHeadImg(String uri, ImageView imageView) {
		if (imageView.getTag() == null || !imageView.getTag().equals(uri)) {
			com.nostra13.universalimageloader.core.ImageLoader.getInstance().displayImage(uri, imageView, optionsHeadImg);
			imageView.setTag(uri);
		}
	}

	@Override
	public void displayImage(Context context, Object path, ImageView imageView) {
		displayItemBig(path.toString(), imageView);
	}



}
