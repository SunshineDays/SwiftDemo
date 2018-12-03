package com.caidian310.utils
import android.app.Activity
import java.util.*

/**
 * Created by mac on 2017/11/15.
 * activity栈管理类
 */
class ActivityManagerUtil {


    // 单一实例
    companion object {
        var instance: ActivityManagerUtil = ActivityManagerUtil()
        // 管理栈
        var activityStack: Stack<Activity> = Stack()
    }

    /**
     * 添加Activity到堆栈
     */
    fun addActivity(activity: Activity) {
        if (activityStack == null) activityStack = Stack() else activityStack.add(activity)
    }


    /**
     *  出栈
     */
    fun popActivity() {
        if (activityStack.size != 0) activityStack.pop()
    }

    /**
     * 结束指定的Activity
     */
    fun finishActivity(activity: Activity?) {
        if (activity == null) return
        activityStack.remove(activity)
        activity.finish()

    }

    /** 获取当前Activity（堆栈中最后一个压入的）*/
    fun currentActivity(): Activity {
        return activityStack.lastElement()
    }

    /** 结束所有Activity */
    fun finishAllActivity() {
        if ( activityStack.size<1) return
        for (it in activityStack){
            it.finish()
        }
        activityStack.clear()
    }


}