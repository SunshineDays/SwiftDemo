package com.caidian310.application;

import android.app.Application;
import android.widget.Toast;

import com.caidian310.bean.enumBean.LotteryIdEnum;
import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.QueueProcessingType;
import com.nostra13.universalimageloader.core.download.BaseImageDownloader;
import com.umeng.analytics.MobclickAgent;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wdb on 2017/4/18.
 * 全局变量
 */

public class MyApplication extends Application {


    public static MyApplication instance;
    public static String fileProvider = "";
    public static int maxMultiple = 99999;     //最大的投注倍数


    /**
     * apk本地时间和服务器时间的差值
     */
    public Long differenceTime = 0L;


    /**
     * 波胆可选球的个数D11
     */
    public int minChoseCount = 0;


    /**
     * 已完成的模块
     */
    public List<Integer> isHaveLotteryList = new ArrayList<Integer>() {
        {
            add(LotteryIdEnum.jclq.getId());
            add(LotteryIdEnum.jczq.getId());

        }
    };

    // 获取 instance实例
    public static MyApplication getInstance() {
        return instance;
    }


    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        fileProvider = this.getPackageName() + ".fileprovider";


        /**
         * 初始化common库
         * 参数1:上下文，不能为空
         * 参数2:String appkey:官方申请的Appkey
         * 参数3:String channel: 渠道号
         * 参数4:EScenarioType eType: 场景模式，包含统计、游戏、统计盒子、游戏盒子
         * 参数5:Boolean isCrashEnable: 可选初始化. 是否开启crash模式
         */
        MobclickAgent.startWithConfigure(
                new MobclickAgent.UMAnalyticsConfig(
                        this,
                        "5ac1bf7ff29d9816f6000055",
                        "Umeng",
                        MobclickAgent.EScenarioType.E_UM_NORMAL));
        MobclickAgent.setDebugMode(true);

        // ImageLoader配置
        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(this).denyCacheImageMultipleSizesInMemory()
                .threadPriority(Thread.NORM_PRIORITY - 2)
                .memoryCacheSize((int) Runtime.getRuntime().maxMemory() / 8)
                .diskCacheSize(50 * 1024 * 1024)
                .threadPoolSize(3)//线程池内加载的数量
                .diskCacheFileNameGenerator(new Md5FileNameGenerator())
                .tasksProcessingOrder(QueueProcessingType.LIFO)
                .diskCacheFileCount(100) //缓存的文件数量
                .defaultDisplayImageOptions(DisplayImageOptions.createSimple())
                .imageDownloader(new BaseImageDownloader(this, 60 * 1000, 60 * 1000))
                .build();

        //设置参数
        ImageLoader.getInstance().init(config);
    }


    public Toast toast;

    public void showToast(String message) {
        if (message.isEmpty()) return;
        if (toast == null)
            toast = Toast.makeText(instance, message, Toast.LENGTH_SHORT);
        else toast.setText(message);
        toast.show();
    }
}