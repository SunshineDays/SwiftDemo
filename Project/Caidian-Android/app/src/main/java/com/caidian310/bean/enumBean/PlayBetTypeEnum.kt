package com.caidian310.bean.enumBean

/**
 * 投注时的球类型
 * Created by mac on 2018/1/26.
 */
enum class PlayBetTypeEnum(var nameType: String) {

    // --------------------------------------------------
    // 双色球,大乐透
    // --------------------------------------------------
    /**
     * 红球
     */
    RED(nameType = "red"),

    /**
     * 蓝球
     */
    BLUE("blue"),

    // --------------------------------------------------
    // 星彩,11运夺金,广东11选5,新11选5 部分玩法
    // --------------------------------------------------
    /**
     * 第一位
     */
    POSITION_1("p_1"),

    /**
     * 第二位
     */
    POSITION_2("p_2"),

    /**
     * 第三位
     */
    POSITION_3("p_3"),

    /**
     * 第四位
     */
    POSITION_4("p_4"),

    /**
     * 第五位
     */
    POSITION_5("p_5"),

    /**
     * 第六位
     */
    POSITION_6("p_6"),

    /**
     * 第七位
     */
    POSITION_7("p_7"),

    // --------------------------------------------------
    // 3D,排三,排五,时时彩 部分玩法
    // --------------------------------------------------
    /**
     * 个位
     */
    UNIT_1("u_1"),

    /**
     * 十位
     */
    UNIT_10("u_10"),

    /**
     * 百位
     */
    UNIT_100("u_100"),

    /**
     * 千位
     */
    UNIT_1000("u_1000"),

    /**
     * 万位
     */
    UNIT_10000("u_10000"), ;

    fun getPlayBetEnumStringFromName(name: String) = when (name) {
        RED.nameType -> "红球"
        BLUE.nameType -> "篮球"
        POSITION_1.nameType -> "第一位"
        POSITION_2.nameType -> "第二位"
        POSITION_3.nameType -> "第三位"
        POSITION_4.nameType -> "第四位"
        POSITION_5.nameType -> "第五位"
        POSITION_6.nameType -> "第六位"
        POSITION_7.nameType -> "第七位"
        UNIT_1.nameType -> "个位"
        UNIT_10.nameType -> "十位"
        UNIT_100.nameType -> "百位"
        UNIT_1000.nameType -> "千位"
        UNIT_10000.nameType -> "万位"
        else -> "选号"
    }


}