//
// Created by levine on 2018/5/4.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 订单交易类型
enum TradeIdType: Int {
    ///购彩支出
    case caiGouZhiChu = 19
    ///普通购买支出
    case puTongGouMaiCaipiao = 20
    ///追号购买彩票
    case zhuiHaoGouMaiCaiPiao = 21
    ///其他支出
    case otherPay = 22
    ///添加预付款
    case addYuFukuan = 23
    ///银联充值
    case yinLianChongZhi = 24
    ///其他添加
    case otherAdd = 25
    ///取消订单返款
    case quXiaoDingDanFanKuan = 26
    ///用户提款支出
    case yongHuTiKuanZhiChu = 27
    ///手工扣款支出
    case shouGongKouKuanZhiChu = 28
    ///购彩记录取消
    case gouCaiJiLuQuXiao = 29
    ///追号任务取消
    case zhuiHaoRenWuQuXiao = 30
    ///中奖奖金派送
    case zhongJiangJiangJinPaiSong = 31
    ///派送发起人提成
    case paiSongFaQiRenTiCheng = 32
    ///派送中奖奖金
    case paiSongZhongJiangJiangJin = 33
    ///公司活动派送
    case gongSiHuoDongPaiSong = 34
    ///购彩奖励派送
    case gouCaiJiangLiPaiSong = 35
    ///挂账添加
    case guaZhangTianJia = 36
    ///冻结预付款
    case dongJieYuFuKuan = 37
    ///保底冻结
    case baoDiDongJie = 38
    ///提款冻结
    case tiKuanDongJie = 39
    ///手工冻结
    case shouGongDongJie = 40
    ///解除冻结预付款
    case jieChuDongJieYuFuKuan = 41
    ///解除保底冻结
    case jieChuBaoDiDongJie = 42
    ///解除提款冻结
    case jieChuTiKuanDongJie = 43
    ///解除手工冻结
    case jieChuShouGongDongJie = 44
    ///挂账还款支出
    case guaZhuangHaiKuanZhiChu = 45
    ///擂台活动派送
    case leiTaiHuoDongPaiSong = 46
    ///用户彩金派送
    case yongHuCaiJinPaiSong = 47
    ///提款失败返款
    case tikuanFailureMoney = 48
    ///计划单跟单
    case planOrderFollow = 101
    

    var name: String {
        switch self {
        case .caiGouZhiChu: return "购彩支出"
        case .puTongGouMaiCaipiao: return "普通购买支出"
        case .zhuiHaoGouMaiCaiPiao: return "追号购买彩票"
        case .otherPay: return "其他支出"
        case .addYuFukuan: return "添加预付款"
        case .yinLianChongZhi: return "银联充值"
        case .otherAdd: return "其他添加"
        case .quXiaoDingDanFanKuan: return "取消订单返款"
        case .yongHuTiKuanZhiChu: return "用户提款支出"
        case .shouGongKouKuanZhiChu: return "手工扣款支出"
        case .gouCaiJiLuQuXiao: return "购彩记录取消"
        case .zhuiHaoRenWuQuXiao: return "追号任务取消"
        case .zhongJiangJiangJinPaiSong: return "中奖奖金派送"
        case .paiSongFaQiRenTiCheng: return "派送发起人提成"
        case .paiSongZhongJiangJiangJin: return "派送中奖奖金"
        case .gongSiHuoDongPaiSong: return "公司活动派送"
        case .gouCaiJiangLiPaiSong: return "购彩奖励派送"
        case .guaZhangTianJia: return "挂账添加"
        case .dongJieYuFuKuan: return "冻结预付款"
        case .baoDiDongJie: return "保底冻结"
        case .tiKuanDongJie: return "提款冻结"
        case .shouGongDongJie: return "手工冻结"
        case .jieChuDongJieYuFuKuan: return "解除冻结预付款"
        case .jieChuBaoDiDongJie: return "解除保底冻结"
        case .jieChuTiKuanDongJie: return "解除提款冻结"
        case .jieChuShouGongDongJie: return "解除手工冻结"
        case .guaZhuangHaiKuanZhiChu: return "挂账还款支出"
        case .leiTaiHuoDongPaiSong: return "擂台活动派送"
        case .yongHuCaiJinPaiSong: return "用户彩金派送"
        case .tikuanFailureMoney: return "提款失败返款"
        case .planOrderFollow: return "计划单跟单"
        }
    }

}
