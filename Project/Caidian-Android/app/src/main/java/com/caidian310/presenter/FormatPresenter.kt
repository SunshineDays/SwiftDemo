package com.caidian310.presenter

import com.caidian310.utils.ToastUtil.showToast
import java.math.BigDecimal
import java.text.DecimalFormat

/**
 * 数据格式化工具
 * Created by mac on 2018/3/27.
 */
object FormatPresenter{


    /**
     * 此方法用于数据去重
     *
     * @param newsArrayList 拿到的数据集合
     * @param currentPage   当前页码
     * @param pageCount     总页码
     * @return
     */
    fun <T> removeRepeat(oldArrayList: ArrayList<T>, newsArrayList: ArrayList<T>, currentPage: Int, pageCount: Int): ArrayList<T> {
        //刷新
        if (currentPage == 1) {
            oldArrayList.clear()
            return newsArrayList
        }
        // 最后一页数据
        if (currentPage <= pageCount) return newsArrayList
        newsArrayList.clear()
        return newsArrayList
    }



    /**
     * double转String,保留小数点后两位
     * @param num
     * @return
     */
    fun doubleToString(num: Double,formatString:String= "0.00"): String {
        //使用0.00不足位补0，#.##仅保留有效位
        return DecimalFormat(formatString).format(num)
    }
    /**
     * 将带科学计数法的Double 转换为BigDecimal 正常显示
     */
    fun getBigDecimalString(double: Double): String {
        val bigDecimal = BigDecimal(double.toString())
        return bigDecimal.toPlainString()
    }


    /**
     * ,格式化数字
     */
    fun getNumberString(double: Double): String {
        val df = DecimalFormat("###,###")
        return df.format(double)
    }



}
