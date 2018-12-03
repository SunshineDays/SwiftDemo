package com.caidian310.bean.enumBean

/**
 * 玩法名称简称
 * Created by mac on 2018/1/17.
 */
enum class NameEnum(var id: Int, var nameString: String, var jianChen: String) {
    BEI_DAN(id = 0, nameString = "北京单场", jianChen = "BEI_DAN"),
    JCZQ(id = 0, nameString = "竞彩足球", jianChen = "JCZQ"),
    JCLQ(id = 0, nameString = "icon_types_jclq", jianChen = "JCLQ"),
    ZCSFC(id = 0, nameString = "胜负彩", jianChen = "ZCSFC"),
    ZCRJ(id = 0, nameString = "任九", jianChen = "ZCRJ"),
    ZCBQC(id = 0, nameString = "六场半全", jianChen = "ZCBQC"),
    ZCJQC(id = 0, nameString = "四场进球", jianChen = "ZCJQC"),
    PLS(id = 0, nameString = "排列三", jianChen = "PLS"),
    PLW(id = 0, nameString = "排列五", jianChen = "PLW"),
    DLT(id = 0, nameString = "大乐透", jianChen = "DLT"),
    SSQ(id = 0, nameString = "双色球", jianChen = "SSQ"),
    QLC(id = 0, nameString = "七乐彩", jianChen = "QLC"),
    QXC(id = 0, nameString = "七星彩", jianChen = "QXC"),
    SD(id = 0, nameString = "3D", jianChen = "SD");



    fun getNameEnumFromId(id: Int): NameEnum {
       return when (id) {
            BEI_DAN.id -> BEI_DAN
            JCZQ.id -> JCZQ
            JCLQ.id -> JCLQ
            ZCSFC.id -> ZCSFC
            ZCRJ.id -> ZCRJ
            ZCBQC.id -> ZCBQC
            ZCJQC.id -> ZCJQC
            PLS.id -> PLS
            PLW.id -> PLW
            DLT.id -> DLT
            SSQ.id -> SSQ
            QLC.id -> QLC
            QXC.id -> QXC
            else -> SD
        }
    }

}