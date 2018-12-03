package com.caidian310.presenter

import com.caidian310.R
import com.caidian310.bean.enumBean.LotteryIdEnum
import com.caidian310.bean.enumBean.PlayIdEnum


/**
 * 彩种展示相关数据
 * Created by mac on 2018/3/7.
 */

object LotteryPresenter{


    /**
     * 获取彩种对应的logo
     */
    fun getLotteryLogoFromId(lotteryId: Int) = when (lotteryId) {
        LotteryIdEnum.pl3.id -> R.mipmap.icon_types_pl3
        LotteryIdEnum.pl5.id -> R.mipmap.icon_types_pl5
        LotteryIdEnum.cjdlt.id -> R.mipmap.icon_types_dlt
        LotteryIdEnum.jclq.id -> R.mipmap.icon_types_jclq
        LotteryIdEnum.jczq.id -> R.mipmap.icon_types_jczq
        LotteryIdEnum.ssq.id -> R.mipmap.icon_types_ssq
        LotteryIdEnum.qlc.id -> R.mipmap.icon_types_qlc
        LotteryIdEnum.sfc.id -> R.mipmap.icon_types_sfc
        LotteryIdEnum.qxc.id -> R.mipmap.icon_types_qxc
        LotteryIdEnum.D11.id -> R.mipmap.icon_types_d11
        LotteryIdEnum.jqc.id -> R.mipmap.icon_types_jqc
        LotteryIdEnum.rx9.id -> R.mipmap.icon_types_rxj
        LotteryIdEnum.bjdc.id -> R.mipmap.icon_types_bjdc
        LotteryIdEnum.sfgg.id -> R.mipmap.icon_types_sfgg
        LotteryIdEnum.bqc.id ->R.mipmap.icon_types_bqc
        LotteryIdEnum.gd11in5.id -> R.mipmap.icon_types_gd11x5
        LotteryIdEnum.x11in5.id -> R.mipmap.icon_types_x11x5
        LotteryIdEnum.ssc.id -> R.mipmap.icon_types_ssc
        LotteryIdEnum.fc3D.id -> R.mipmap.icon_types_fc3d
        LotteryIdEnum.xk3.id ->R.mipmap.icon_types_xk3
        LotteryIdEnum.xyk3.id -> R.mipmap.icon_types_xyk3
        else -> R.mipmap.icon_types_more
    }


    /**
     * 获取彩种对应的logo
     */
    fun getPlayLogoFromPosition(position: Int) = when (position) {
        0-> R.mipmap.icon_types_jczq
        1->R.mipmap.icon_types_jclq
        2->R.mipmap.icon_types_sfc
        3->R.mipmap.icon_types_bqc
        4-> R.mipmap.icon_types_bf
        else -> R.mipmap.icon_types_jqs

    }






}
