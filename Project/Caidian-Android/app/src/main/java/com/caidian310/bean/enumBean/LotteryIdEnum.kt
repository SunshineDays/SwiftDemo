package com.caidian310.bean.enumBean

/**
 * 彩种枚举
 * Created by mac on 2018/1/4.
 */
enum class LotteryIdEnum(var id: Int, var lotteryName: String) {

    sfc(id = 11, lotteryName = "胜负彩"),
    bqc(id = 16, lotteryName = "半全场"),
    jqc(id = 18, lotteryName = "进球彩"),
    rx9(id = 19, lotteryName = "任选九"),

    bjdc(id = 41, lotteryName = "北京单场"),
    jczq(id = 42, lotteryName = "竞彩足球"),
    jclq(id = 43, lotteryName = "竞彩篮球"),
    sfgg(id = 46,lotteryName = "胜负过关"),

    ssq(id = 101, lotteryName = "双色球"),
    cjdlt(id = 102, lotteryName = "超级大乐透"),
    qxc(id = 103, lotteryName = "七星彩"),
    qlc(id = 104, lotteryName = "七乐彩"),
    fc3D(id = 105, lotteryName = "福彩3D"),
    pl3(id = 106, lotteryName = "排列三"),
    pl5(id = 107, lotteryName = "排列五"),

    D11(id = 201, lotteryName = "11运夺金"),
    gd11in5(id = 202, lotteryName = "广东11选5"),
    x11in5(id = 203, lotteryName = "新11选5"),


    xk3(id = 211, lotteryName = "新快3"),
    xyk3(id = 212, lotteryName = "新运快3"),

    ssc(id = 221, lotteryName = "时时彩");


    fun getLotteryEnumFromId(id: Int) = when (id) {
        sfc.id -> sfc
        bqc.id -> bqc
        jqc.id -> jqc
        rx9.id -> rx9
        pl3.id -> pl3
        pl5.id -> pl5
        bjdc.id -> bjdc
        jczq.id -> jczq
        jclq.id -> jclq
        sfgg.id -> sfgg
        ssq.id -> ssq
        fc3D.id -> fc3D
        qxc.id -> qxc
        D11.id -> D11
        gd11in5.id -> gd11in5
        x11in5.id -> x11in5
        xk3.id -> xk3
        xyk3.id -> xyk3
        ssc.id -> ssc
        qlc.id -> qlc
        else -> cjdlt

    }

    fun getLotteryEnumFromString(type: String) = when (type) {
        sfc.lotteryName -> sfc
        bqc.lotteryName -> bqc
        jqc.lotteryName -> jqc
        rx9.lotteryName -> rx9
        pl3.lotteryName -> pl3
        pl5.lotteryName -> pl5
        bjdc.lotteryName -> bjdc
        jczq.lotteryName -> jczq
        jclq.lotteryName -> jclq
        sfgg.lotteryName -> sfgg
        ssq.lotteryName -> ssq
        fc3D.lotteryName -> fc3D
        qxc.lotteryName -> qxc
        D11.lotteryName -> D11
        gd11in5.lotteryName -> gd11in5
        x11in5.lotteryName -> x11in5
        xk3.lotteryName -> xk3
        xyk3.lotteryName -> xyk3
        ssc.lotteryName -> ssc
        qlc.lotteryName -> qlc
        else -> cjdlt

    }


}

