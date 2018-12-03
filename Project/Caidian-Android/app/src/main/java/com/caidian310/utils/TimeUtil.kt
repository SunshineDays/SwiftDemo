package com.caidian310.utils

import android.os.CountDownTimer
import android.widget.TextView
import com.caidian310.bean.TimeBean
import java.text.SimpleDateFormat

/**
 * 时间管理工具
 * Created by mac on 2017/12/26.
 */
object TimeUtil{

    /* 默认的时间格式*/
    var timeFormat = "yyyy-MM-dd HH:mm:ss"

    var timeFormatYearAndMonthAndDay = "yyyy-MM-dd"

    /**
     * @param formatString    :  时间格式化规则
     * @param time            :  时间戳
     * @return                 时间字符串
     */
    fun getFormatTime(time: Long, formatString: String = timeFormat): String {
        val dateFormat = SimpleDateFormat(formatString)
        return dateFormat.format(time * 1000)
    }


    /**
     * 获取时间的天 小时 分钟 秒
     */

    fun getTimeBean(time:Long):TimeBean{



        var hour   = 0L
        var minute = 0L
        var second = 0L

        if (time>60*60){
            hour = time/60*60
            minute = (time - hour*60)/60
            second =  (time - hour*60*60 - minute*60)
            return TimeBean(hour = hour.toInt(),min = minute.toInt(),second = second.toInt())
        }
        if (time>60){
            minute = time/60
            second = time- minute*60
            TimeBean(hour = hour.toInt(),min = minute.toInt(),second = second.toInt())
        }
        if (time<60)  second = time
        return TimeBean(hour = hour.toInt(),min = minute.toInt(),second = second.toInt())

    }
    /**
     * 智能提示时间
     * @param timestamp  时间戳
     * @return String
     */
    fun getIntelligenceTime(timestamp: Long, formatTime: String = timeFormat): String {
        val simpleDateFormat = SimpleDateFormat(formatTime)
        val date = simpleDateFormat.format(timestamp * 1000)
        val dayAndMillis = date.substring(10, 16)
        val diffMillis = (System.currentTimeMillis() - timestamp * 1000) / 1000
        val time = diffMillis / 60
        val day = time / 60 / 24
        if (time < 3)
            return "刚刚"
        if (time < 60)
            return "${time}分钟前"
        if (time >= 60 && time / 60 < 24)
            return "${time / 60}小时前"
        return when (day.toInt()) {
            1 -> "昨天$dayAndMillis"
            2 -> "前天$dayAndMillis"
            else -> date.substring(0, 16)
        }

    }




    /**
     * 获取验证码 倒计时开始
     *
     * @param textView      需要倒计时的控件
     * @param textColorDim  倒计时显示的字体颜色
     * @param textColorDark 倒计时之前显示的字体颜色
     */
    fun countDownTimerCode(textView: TextView, textColorDim: Int, textColorDark: Int) {

        textView.isEnabled = false
        textView.setTextColor(textColorDim)
        object : CountDownTimer(60000, 1000) {

            override fun onTick(millisUntilFinished: Long) {
                textView.text = (millisUntilFinished / 1000).toString() + "秒"
            }

            override fun onFinish() {
                textView.text = "获取验证码"
                textView.isEnabled = true
                textView.setTextColor(textColorDark)
            }
        }.start()

    }



}