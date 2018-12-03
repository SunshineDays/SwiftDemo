package com.caidian310.bean.enumBean

/**
 * 交易类型父级id
 * Created by mac on 2018/1/9.
 *
 */
enum class TradeIdEnum(var id: Int, var parentId: Int = 0, var intOutBoolean: Boolean = false, var tradeName: String, jianChen: String = "GC") {
    caiGouZhiChu(id = 19, parentId = 0, tradeName = "购彩支出", intOutBoolean = false, jianChen = "GC"),
    puTongGouMaiCaipiao(id = 20, parentId = 19, tradeName = "普通购买支出", intOutBoolean = false, jianChen = "GC"),
    zhuiHaoGouMaiCaiPiao(id = 21, parentId = 19, tradeName = "追号购买彩票", intOutBoolean = false, jianChen = "ZH"),
    otherPay(id = 22, parentId = 0, tradeName = "其他支出", intOutBoolean = false, jianChen = "ZC"),
    addYuFukuan(id = 23, parentId = 0, tradeName = "添加预付款", intOutBoolean = true, jianChen = "CZ"),
    yinLianChongZhi(id = 24, parentId = 23, tradeName = "银联充值", intOutBoolean = true, jianChen = "CZ"),
    otherAdd(id = 25, parentId = 23, tradeName = "其他添加", intOutBoolean = true, jianChen = "CZ"),
    quXiaoDingDanFanKuan(id = 26, parentId = 0, tradeName = "取消订单返款", intOutBoolean = true, jianChen = "CD"),
    yongHuTiKuanZhiChu(id = 27, parentId = 22, tradeName = "用户提款支出", intOutBoolean = false, jianChen = "TX"),
    shouGongKouKuanZhiChu(id = 28, parentId = 22, tradeName = "手工扣款支出", intOutBoolean = false, jianChen = "KK"),
    gouCaiJiLuQuXiao(id = 29, parentId = 26, tradeName = "购彩记录取消", intOutBoolean = true, jianChen = "CD"),
    zhuiHaoRenWuQuXiao(id = 30, parentId = 26, tradeName = "追号任务取消", intOutBoolean = true, jianChen = "CD"),
    zhongJiangJiangJinPaiSong(id = 31, parentId = 0, tradeName = "中奖奖金派送", intOutBoolean = true, jianChen = "PS"),
    paiSongFaQiRenTiCheng(id = 32, parentId = 31, tradeName = "派送发起人提成", intOutBoolean = true, jianChen = "PS"),
    paiSongZhongJiangJiangJin(id = 33, parentId = 31, tradeName = "派送中奖奖金", intOutBoolean = true, jianChen = "PS"),
    gongSiHuoDongPaiSong(id = 34, parentId = 0, tradeName = "公司活动派送", intOutBoolean = true, jianChen = "PS"),
    gouCaiJiangLiPaiSong(id = 35, parentId = 0, tradeName = "购彩奖励派送", intOutBoolean = true, jianChen = "GC"),
    guaZhangTianJia(id = 36, parentId = 34, tradeName = "挂账添加", intOutBoolean = true, jianChen = "TJ"),
    dongJieYuFuKuan(id = 37, parentId = 23, tradeName = "冻结预付款", intOutBoolean = false, jianChen = "DJ"),
    baoDiDongJie(id = 38, parentId = 37, tradeName = "保底冻结", intOutBoolean = false, jianChen = "DJ"),
    tiKuanDongJie(id = 39, parentId = 37, tradeName = "提款冻结", intOutBoolean = false, jianChen = "Dj"),
    shouGongDongJie(id = 40, parentId = 37, tradeName = "手工冻结", intOutBoolean = false, jianChen = "Dj"),
    jieChuDongJieYuFuKuan(id = 41, parentId = 0, tradeName = "解除冻结预付款", intOutBoolean = true, jianChen = "JD"),
    jieChuBaoDiDongJie(id = 42, parentId = 41, tradeName = "解除保底冻结", intOutBoolean = true, jianChen = "JD"),
    jieChuTiKuanDongJie(id = 43, parentId = 41, tradeName = "解除提款冻结", intOutBoolean = true, jianChen = "JD"),
    jieChuShouGongDongJie(id = 44, parentId = 41, tradeName = "解除手工冻结", intOutBoolean = true, jianChen = "JD"),
    guaZhuangHaiKuanZhiChu(id = 45, parentId = 22, tradeName = "挂账还款支出", intOutBoolean = false, jianChen = "GZ"),
    leiTaiHuoDongPaiSong(id = 46, parentId = 34, tradeName = "擂台活动派送", intOutBoolean = true, jianChen = "LT"),
    yongHuCaiJinPaiSong(id = 47, parentId = 34, tradeName = "用户彩金派送", intOutBoolean = true, jianChen = "CJ"),
    tikuanFailureMoney(id = 48, parentId = 23, tradeName = "提款失败返款", intOutBoolean = true, jianChen = "TX");


    /**
     * 获取相关的枚举
     */
    fun getTradeEnumFromId(id: Int): TradeIdEnum {

        return when (id) {

            caiGouZhiChu.id -> caiGouZhiChu
            puTongGouMaiCaipiao.id -> puTongGouMaiCaipiao
            zhuiHaoGouMaiCaiPiao.id -> zhuiHaoGouMaiCaiPiao
            otherPay.id -> otherPay
            addYuFukuan.id -> addYuFukuan
            yinLianChongZhi.id -> yinLianChongZhi
            otherAdd.id -> otherAdd
            quXiaoDingDanFanKuan.id -> quXiaoDingDanFanKuan
            yongHuTiKuanZhiChu.id -> yongHuTiKuanZhiChu
            shouGongKouKuanZhiChu.id -> shouGongKouKuanZhiChu
            gouCaiJiLuQuXiao.id -> gouCaiJiLuQuXiao
            zhuiHaoRenWuQuXiao.id -> zhuiHaoRenWuQuXiao
            zhongJiangJiangJinPaiSong.id -> zhongJiangJiangJinPaiSong
            paiSongFaQiRenTiCheng.id -> paiSongFaQiRenTiCheng
            paiSongZhongJiangJiangJin.id -> paiSongZhongJiangJiangJin
            gongSiHuoDongPaiSong.id -> gongSiHuoDongPaiSong
            gouCaiJiangLiPaiSong.id -> gouCaiJiangLiPaiSong
            guaZhangTianJia.id -> guaZhangTianJia
            dongJieYuFuKuan.id -> dongJieYuFuKuan
            baoDiDongJie.id -> baoDiDongJie
            tiKuanDongJie.id -> tiKuanDongJie
            shouGongDongJie.id -> shouGongDongJie
            jieChuDongJieYuFuKuan.id -> jieChuDongJieYuFuKuan
            jieChuBaoDiDongJie.id -> jieChuBaoDiDongJie
            jieChuTiKuanDongJie.id -> jieChuTiKuanDongJie
            jieChuShouGongDongJie.id -> jieChuShouGongDongJie
            guaZhuangHaiKuanZhiChu.id -> guaZhuangHaiKuanZhiChu
            leiTaiHuoDongPaiSong.id -> leiTaiHuoDongPaiSong
            tikuanFailureMoney.id -> tikuanFailureMoney
            else -> yongHuCaiJinPaiSong
        }
    }

    /**
     * 支持的跳转项
     * 目前支持 Id= 20 ,21  ||  用户提款查看 trade_id = 48  27
     */
    fun getCanOpenOrderDetailBoolean(id: Int): Boolean {

        val orderIdList =
                arrayListOf(
                        puTongGouMaiCaipiao.id,
                        zhuiHaoGouMaiCaiPiao.id,
                        yongHuTiKuanZhiChu.id,
                        tikuanFailureMoney.id
                )
        return orderIdList.contains(id)
    }

}




