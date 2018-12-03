package com.caidian310.bean.enumBean

/**
 *
 * 玩法枚举
 * Created by mac on 2018/1/4.
 */
enum class PlayIdEnum(var id: Int = 7, var playName: String = "混投", var type: String) {

    spf(id = 1, playName = "胜平负", type = "spf"),
    rqspf(id = 2, playName = "让球胜平负", type = "rqspf"),
    jqs(id = 3, playName = "总进球数", type = "jqs"),
    bf(id = 4, playName = "比分", type = "bf"),
    bqc(id = 5, playName = "半全场", type = "bqc"),
    sxds(id = 6, playName = "上下单双", type = "sxds"),
    hunhe(id = 7, playName = "混合", type = "hunhe"),

    sf(id = 21, playName = "胜负", type = "sf"),
    rfsf(id = 22, playName = "让分胜负", type = "rfsf"),
    dxf(id = 23, playName = "大小分", type = "dxf"),
    sfc(id = 24, playName = "胜负差", type = "sfc"),

    d3_zx(id = 101, playName = "直选", type = "zx"),         //排三,3d 直选 D3:3d
    d3_zu3(id = 102, playName = "组三", type = "c3"),         //排三,3d 组3
    d3_zu6(id = 103, playName = "组六", type = "c6"),         //排三,3d 组6


    D11X5_ZHI1(id = 201, playName = "前一直选", type = "D11X5_R1"),         //11选5 任1
    D11X5_R2(id = 202, playName = "任二", type = "D11X5_R2"),         //11选5 任2
    D11X5_R3(id = 203, playName = "任三", type = "D11X5_R3"),         //11选5 任3
    D11X5_R4(id = 204, playName = "任四", type = "D11X5_R4"),         //11选5 任4
    D11X5_R5(id = 205, playName = "任五", type = "D11X5_R5"),         //11选5 任5
    D11X5_R6(id = 206, playName = "任六", type = "D11X5_R6"),         //11选5 任6
    D11X5_R7(id = 207, playName = "任七", type = "D11X5_R7"),         //11选5 任7
    D11X5_R8(id = 208, playName = "任八", type = "D11X5_R8"),         //11选5 任8
    D11X5_ZU2(id = 211, playName = "前二组选", type = "D11X5_ZU2"),    //11选5 前2组选
    D11X5_ZU3(id = 212, playName = "前三组选", type = "D11X5_ZU3"),    //11选5 前3组选
    D11X5_ZHI2(id = 213, playName = "前二直选", type = "D11X5_ZHI2"),    //11选5 前3直选
    D11X5_ZHI3(id = 214, playName = "前三直选", type = "D11X5_ZHI3"),    //11选5 前3直选
    K3_HZ(id = 301, playName = "和值", type = "K3_HZ"),        //快3 K3 和值
    K3_3TH_TX(id = 302, playName = "三同号通选", type = "K3_3TH_TX"),   //快3 三同号通选
    K3_3TH_DX(id = 303, playName = "三同号单选", type = "K3_3TH_DX"),   //快3 三同号单选
    K3_3BTH(id = 304, playName = "三不同号", type = "K3_3BTH"),     //快3 三不同号
    K3_3LH_TX(id = 305, playName = "三连号通选", type = "K3_3LH_TX"),    //快3 三连号通选
    K3_2TH_FX(id = 306, playName = "二同号复选", type = "K3_2TH_FX"),    //快3 二同号复选
    K3_2TH_DX(id = 307, playName = "二同号单选", type = "K3_2TH_DX"),    //快3 二同号单选
    K3_2BTH(id = 308, playName = "二不同号", type = "K3_2BTH"),      //快3 二不同号
    SSC_ZHI1(id = 401, playName = "一星直选", type = "SSC_ZHI1"),       //时时彩 一星直选 SSC:时时彩
    SSC_ZHI2(id = 402, playName = "二星直选", type = "SSC_ZHI2"),       //时时彩 二星直选
    SSC_ZHI3(id = 403, playName = "三星直选", type = "SSC_ZHI3"),       //时时彩 三星直选
    SSC_ZHI5(id = 405, playName = "五星直选", type = "SSC_ZHI5"),       //时时彩 五星直选
    SSC_ZU2(id = 406, playName = "二星组选", type = "SSC_ZU2"),       //时时彩 二星组选
    SSC_TX(id = 407, playName = "五星通选", type = "SSC_TX"),       //时时彩 五星通选
    SSC_DXDS(id = 408, playName = "大小单双", type = "SSC_DXDS");        // 时时彩 大小单双


    fun getPlayEnumFromType(type: String) = when (type) {

        jqs.type -> jqs
        bf.type     -> bf
        bqc.type -> bqc
        sxds.type -> sxds
        hunhe.type -> hunhe
        d3_zx.type -> d3_zx
        d3_zu3.type -> d3_zu3
        d3_zu6.type -> d3_zu6
        sf.type -> sf
        rfsf.type -> rfsf
        dxf.type -> dxf
        sfc.type -> sfc
        D11X5_ZHI1.type -> D11X5_ZHI1
        D11X5_R2.type -> D11X5_R2
        D11X5_R3.type -> D11X5_R3
        D11X5_R4.type -> D11X5_R4
        D11X5_R5.type -> D11X5_R5
        D11X5_R6.type -> D11X5_R6
        D11X5_R7.type -> D11X5_R7
        D11X5_R8.type -> D11X5_R8
        D11X5_ZU2.type -> D11X5_ZU2
        D11X5_ZU3.type -> D11X5_ZU3
        D11X5_ZHI2.type -> D11X5_ZHI2
        D11X5_ZHI3.type -> D11X5_ZHI3
        K3_HZ.type -> K3_HZ
        K3_3TH_TX.type -> K3_3TH_TX
        K3_3TH_DX.type -> K3_3TH_DX
        K3_3BTH.type -> K3_3BTH
        K3_3LH_TX.type -> K3_3LH_TX
        K3_2TH_FX.type -> K3_2TH_FX
        K3_2TH_DX.type -> K3_2TH_DX
        K3_2BTH.type -> K3_2BTH
        SSC_ZHI1.type -> SSC_ZHI1
        SSC_ZHI2.type -> SSC_ZHI2
        SSC_ZHI3.type -> SSC_ZHI3
        SSC_ZHI5.type -> SSC_ZHI5
        SSC_ZU2.type -> SSC_ZU2
        SSC_TX.type -> SSC_TX
        SSC_DXDS.type -> SSC_DXDS

        else -> hunhe


    }

    fun getPlayEnumFromId(id: Int) = when (id) {

        jqs.id -> jqs
        bf.id -> bf
        bqc.id -> bqc
        sxds.id -> sxds
        hunhe.id -> hunhe
        d3_zx.id -> d3_zx
        d3_zu3.id -> d3_zu3
        d3_zu6.id -> d3_zu6
        sf.id -> sf
        rfsf.id -> rfsf
        dxf.id -> dxf
        sfc.id -> sfc
        D11X5_ZHI1.id -> D11X5_ZHI1
        D11X5_R2.id -> D11X5_R2
        D11X5_R3.id -> D11X5_R3
        D11X5_R4.id -> D11X5_R4
        D11X5_R5.id -> D11X5_R5
        D11X5_R6.id -> D11X5_R6
        D11X5_R7.id -> D11X5_R7
        D11X5_R8.id -> D11X5_R8
        D11X5_ZU2.id -> D11X5_ZU2
        D11X5_ZU3.id -> D11X5_ZU3
        D11X5_ZHI2.id -> D11X5_ZHI2
        D11X5_ZHI3.id -> D11X5_ZHI3
        K3_HZ.id -> K3_HZ
        K3_3TH_TX.id -> K3_3TH_TX
        K3_3TH_DX.id -> K3_3TH_DX
        K3_3BTH.id -> K3_3BTH
        K3_3LH_TX.id -> K3_3LH_TX
        K3_2TH_FX.id -> K3_2TH_FX
        K3_2TH_DX.id -> K3_2TH_DX
        K3_2BTH.id -> K3_2BTH
        SSC_ZHI1.id -> SSC_ZHI1
        SSC_ZHI2.id -> SSC_ZHI2
        SSC_ZHI3.id -> SSC_ZHI3
        SSC_ZHI5.id -> SSC_ZHI5
        SSC_ZU2.id -> SSC_ZU2
        SSC_TX.id -> SSC_TX
        SSC_DXDS.id -> SSC_DXDS


        else -> hunhe


    }
}