package com.caidian310.view.callBack

import com.caidian310.bean.sport.football.BetBean

/**
 * Created by mac on 2017/12/6.
 * 回调函数 回调所有的玩法选择项
 */
interface CallChoseListBack {
    fun onClickListener(list: ArrayList<BetBean>, choseList: ArrayList<BetBean>)
}