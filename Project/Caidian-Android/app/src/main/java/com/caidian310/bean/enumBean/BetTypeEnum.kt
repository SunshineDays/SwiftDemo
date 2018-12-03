package com.caidian310.bean.enumBean

/**
 * 竞彩足球
 * indexList 在自定义集合中的位置
 * Created by mac on 2017/12/12.
 */
enum class BetTypeEnum(var key: String, var listIndex: Int = -1) {
    spf(key = "spf", listIndex = -1),
    rqSpf(key = "rqSpf", listIndex = -6),
    hunhe(key = "hunhe", listIndex = -2),
    jqs(key = "jqs", listIndex = -3),
    bqc(key = "bqc", listIndex = -4),
    bf(key = "bf", listIndex = -5),

    jclqSfc(key = "jclqSfc", listIndex = -7),
    jclqSf(key = "jclqSf", listIndex = -8),
    jclqRfSf(key = "jclqRfSf", listIndex = -9),
    jclqDxf(key = "jclqDxf", listIndex = -10),

    bf_sp00(key = "bf_sp00", listIndex = 0),
    bf_sp01(key = "bf_sp01", listIndex = 1),
    bf_sp02(key = "bf_sp02", listIndex = 2),
    bf_sp03(key = "bf_sp03", listIndex = 3),
    bf_sp04(key = "bf_sp04", listIndex = 4),
    bf_sp05(key = "bf_sp05", listIndex = 5),
    bf_sp10(key = "bf_sp10", listIndex = 6),
    bf_sp11(key = "bf_sp11", listIndex = 7),
    bf_sp12(key = "bf_sp12", listIndex = 8),
    bf_sp13(key = "bf_sp13", listIndex = 9),
    bf_sp14(key = "bf_sp14", listIndex = 10),
    bf_sp15(key = "bf_sp15", listIndex = 11),
    bf_sp20(key = "bf_sp20", listIndex = 12),
    bf_sp21(key = "bf_sp21", listIndex = 13),
    bf_sp22(key = "bf_sp22", listIndex = 14),
    bf_sp23(key = "bf_sp23", listIndex = 15),
    bf_sp24(key = "bf_sp24", listIndex = 16),
    bf_sp25(key = "bf_sp25", listIndex = 17),
    bf_sp30(key = "bf_sp30", listIndex = 18),
    bf_sp31(key = "bf_sp31", listIndex = 19),
    bf_sp32(key = "bf_sp32", listIndex = 20),
    bf_sp33(key = "bf_sp33", listIndex = 21),
    bf_sp40(key = "bf_sp40", listIndex = 22),
    bf_sp41(key = "bf_sp41", listIndex = 23),
    bf_sp42(key = "bf_sp42", listIndex = 24),
    bf_sp50(key = "bf_sp50", listIndex = 25),
    bf_sp51(key = "bf_sp51", listIndex = 26),
    bf_sp52(key = "bf_sp52", listIndex = 27),
    bf_spA0(key = "bf_spA0", listIndex = 28),
    bf_spA1(key = "bf_spA1", listIndex = 29),
    bf_spA3(key = "bf_spA3", listIndex = 30),
    bqc_sp00(key = "bqc_sp00", listIndex = 31),
    bqc_sp01(key = "bqc_sp01", listIndex = 32),
    bqc_sp03(key = "bqc_sp03", listIndex = 33),
    bqc_sp10(key = "bqc_sp10", listIndex = 34),
    bqc_sp11(key = "bqc_sp11", listIndex = 35),
    bqc_sp13(key = "bqc_sp13", listIndex = 36),
    bqc_sp30(key = "bqc_sp30", listIndex = 37),
    bqc_sp31(key = "bqc_sp31", listIndex = 38),
    bqc_sp33(key = "bqc_sp33", listIndex = 39),
    jqs_sp0(key = "jqs_sp0", listIndex = 40),
    jqs_sp1(key = "jqs_sp1", listIndex = 41),
    jqs_sp2(key = "jqs_sp2", listIndex = 42),
    jqs_sp3(key = "jqs_sp3", listIndex = 43),
    jqs_sp4(key = "jqs_sp4", listIndex = 44),
    jqs_sp5(key = "jqs_sp5", listIndex = 45),
    jqs_sp6(key = "jqs_sp6", listIndex = 46),
    jqs_sp7(key = "jqs_sp7", listIndex = 47),
    spf_sp3(key = "spf_sp3", listIndex = 48),
    spf_sp1(key = "spf_sp1", listIndex = 49),
    spf_sp0(key = "spf_sp0", listIndex = 50),
    rqspf_sp3(key = "rqspf_sp3", listIndex = 51),
    rqspf_sp1(key = "rqspf_sp1", listIndex = 52),
    rqspf_sp0(key = "rqspf_sp0", listIndex = 53),

    sf_sp3(key = "sf_sp3", listIndex = 54),
    sf_sp0(key = "sf_sp0", listIndex = 55),

    rfsf_sp3(key = "rfsf_sp3", listIndex = 56),
    rfsf_sp0(key = "rfsf_sp0", listIndex = 57),

    dxf_sp3(key = "dxf_sp3", listIndex = 58),
    dxf_sp0(key = "dxf_sp0", listIndex = 59),

    sfc_sp11(key = "sfc_sp11", listIndex = 60),
    sfc_sp12(key = "sfc_sp12", listIndex = 61),
    sfc_sp13(key = "sfc_sp13", listIndex = 61),
    sfc_sp14(key = "sfc_sp14", listIndex = 63),
    sfc_sp15(key = "sfc_sp15", listIndex = 64),
    sfc_sp16(key = "sfc_sp16", listIndex = 65),
    sfc_sp01(key = "sfc_sp01", listIndex = 66),
    sfc_sp02(key = "sfc_sp02", listIndex = 67),
    sfc_sp03(key = "sfc_sp03", listIndex = 68),
    sfc_sp04(key = "sfc_sp04", listIndex = 69),
    sfc_sp05(key = "sfc_sp05", listIndex = 70),
    sfc_sp06(key = "sfc_sp06", listIndex = 71), ;


    /**
     * 获取相关的投注项
     *
     */
    fun getBetMoneykeyStringFromkey(key: String): String =
         when (key) {
            bf_sp00.key -> "bf-00"
            bf_sp01.key -> "bf-01"
            bf_sp02.key -> "bf-02"
            bf_sp03.key -> "bf-03"
            bf_sp04.key -> "bf-04"
            bf_sp05.key -> "bf-05"
            bf_sp10.key -> "bf-10"
            bf_sp11.key -> "bf-11"
            bf_sp12.key -> "bf-12"
            bf_sp13.key -> "bf-13"
            bf_sp14.key -> "bf-14"
            bf_sp15.key -> "bf-15"
            bf_sp20.key -> "bf-20"
            bf_sp21.key -> "bf-21"
            bf_sp22.key -> "bf-22"
            bf_sp23.key -> "bf-23"
            bf_sp24.key -> "bf-24"
            bf_sp25.key -> "bf-25"
            bf_sp30.key -> "bf-30"
            bf_sp31.key -> "bf-31"
            bf_sp32.key -> "bf-32"
            bf_sp33.key -> "bf-33"
            bf_sp40.key -> "bf-40"
            bf_sp41.key -> "bf-41"
            bf_sp42.key -> "bf-42"
            bf_sp50.key -> "bf-50"
            bf_sp51.key -> "bf-51"
            bf_sp52.key -> "bf-52"
            bf_spA0.key -> "bf-0A"
            bf_spA1.key -> "bf-1A"
            bf_spA3.key -> "bf-3A"
            bqc_sp00.key -> "bqc-00"
            bqc_sp01.key -> "bqc-01"
            bqc_sp03.key -> "bqc-03"
            bqc_sp10.key -> "bqc-10"
            bqc_sp11.key -> "bqc-11"
            bqc_sp13.key -> "bqc-13"
            bqc_sp30.key -> "bqc-30"
            bqc_sp31.key -> "bqc-31"
            bqc_sp33.key -> "bqc-33"
            sfc_sp11.key -> "sfc-11"
            sfc_sp12.key -> "sfc-12"
            sfc_sp13.key -> "sfc-13"
            sfc_sp14.key -> "sfc-14"
            sfc_sp15.key -> "sfc-15"
            sfc_sp16.key -> "sfc-16"
            sfc_sp01.key -> "sfc-01"
            sfc_sp02.key -> "sfc-02"
            sfc_sp03.key -> "sfc-03"
            sfc_sp04.key -> "sfc-04"
            sfc_sp05.key -> "sfc-05"
            sfc_sp06.key -> "sfc-06"
            sf_sp3.key -> "nsf-3"
            sf_sp0.key -> "nsf-0"
            rfsf_sp3.key -> "sf-3"
            rfsf_sp0.key -> "sf-0"
            dxf_sp3.key -> "dxf-3"
            dxf_sp0.key -> "dxf-0"
            bqc_sp00.key -> " bqc-00"
            bqc_sp01.key -> " bqc-01"
            bqc_sp03.key -> " bqc-03"
            bqc_sp10.key -> " bqc-10"
            bqc_sp11.key -> " bqc-11"
            bqc_sp13.key -> " bqc-13"
            bqc_sp30.key -> " bqc-30"
            bqc_sp31.key -> " bqc-31"
            bqc_sp33.key -> " bqc-33"
            jqs_sp0.key -> "jqs-0"
            jqs_sp1.key -> "jqs-1"
            jqs_sp2.key -> "jqs-2"
            jqs_sp3.key -> "jqs-3"
            jqs_sp4.key -> "jqs-4"
            jqs_sp5.key -> "jqs-5"
            jqs_sp6.key -> "jqs-6"
            jqs_sp7.key -> "jqs-7"
            spf_sp3.key -> " nspf-3"
            spf_sp1.key -> " nspf-1"
            spf_sp0.key -> " nspf-0"
            rqspf_sp3.key -> "spf-3"
            rqspf_sp1.key -> "spf-1"
            else -> "spf-0"

        }




}