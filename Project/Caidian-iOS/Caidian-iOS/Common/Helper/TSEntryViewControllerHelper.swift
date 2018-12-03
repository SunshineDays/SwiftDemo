//
//  TSEntryViewControllerHelper.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 所有单页viewController入口
/// 所有通过点击能查看的单页都应加入此类并且只通过此类访问
class TSEntryViewControllerHelper: NSObject {

    /// 资讯 详情页
    ///
    /// - Parameters:
    ///   - newsId: 资讯id
    /// - Returns:
    static func newsDetailViewController(newsId: Int) -> HomeNewsDetailViewController {
        let ctrl = HomeNewsDetailViewController()
        ctrl.newsId = newsId
        return ctrl
    }

    
    /// WebView
    ///
    /// - Parameters:
    ///   - newsId: 资讯id
    /// - Returns:
    static func webView(url: String) -> TSBaseWebViewController {
        let ctrl = TSBaseWebViewController()
        ctrl.url = url
        return ctrl
    }

    
    
    /// 订单详情
    ///
    /// - Parameters:
    ///   - buyId: 认购的id
    /// - Returns:
    static func orderDetailViewController(buyId: Int) -> OrderMainViewController {
        let ctrl = OrderMainViewController()
        ctrl.buyId = buyId
        return ctrl
    }
    
    /// 复制跟单 用户详情页
    ///
    /// - Parameters:
    ///   - buyId: 认购的id
    /// - Returns:
    static func copyOrderSponsorDetailViewController(userId :Int) -> UserCopyOrderDetailController {
        let ctrl = R.storyboard.copyOrder.userCopyOrderDetailController()!
        ctrl.initWith(userId: userId)
        return ctrl
    }
    
    
    /// 复制跟单 详情页
    ///
    /// - Parameters:
    ///   - buyId: 认购的id
    /// - Returns:
    static func copyOrderDetailViewController(orderId : Int) -> CopyOrderDetailViewController {
        let ctrl = CopyOrderDetailViewController()
        ctrl.orderId = orderId
        return ctrl
    }
    
    /// 推荐单 详情页
    ///
    /// - Parameters:
    ///   - buyId: 认购的id
    /// - Returns:
    static func recommendOrderDetailViewController(recommendId : Int) -> RecommendDetailController {
        let ctrl = RecommendDetailController()
        ctrl.recommendId = recommendId
        return ctrl
    }
    
    /// 推荐单 用户详情页
    ///
    /// - Parameters:
    ///   - buyId: 认购的id
    /// - Returns:
    static func recommendOrderUserDetailViewController(professorId : Int) -> RecommendExpertController {
        let ctrl = R.storyboard.recommend.recommendExpertController()!
        ctrl.professorId = professorId
        return ctrl
    }
    
    /// 计划单详情
    ///
    /// - Parameters:
    ///   - buyId: 认购的id
    /// - Returns:
    static func planOrderDetailViewController(planDetailId : Int) -> PlanOrderDetailViewController {
        let ctrl = R.storyboard.planOrderDetail.planOrderDetailViewController()!
        ctrl.planDetailId = planDetailId
        return ctrl
    }

    /// 购彩记录
    ///
    /// - Parameters:
    ///   - buyType: 认购的type
    /// - Returns:
    static func userOrderBuyListViewController(buyType: OrderBuyType = .all) -> UserOrderBuyListViewController {
        let ctrl = R.storyboard.user.userOrderBuyListViewController()!
        ctrl.buyType = buyType
        return ctrl

    }

    /// 彩种玩法介绍
    ///
    /// - Parameters:
    ///   - lottery: 彩种
    /// - Returns:
    static func lotteryIntroViewController(lottery: LotteryType) -> LotteryIntroViewController {
        let ctrl = LotteryIntroViewController()
        ctrl.lottery = lottery
        return ctrl
    }

    /// 充值入口
    /// - Parameters:
    ///   - money: 金额
    /// - Returns:
    static func rechargeViewController(money: Double = 100) -> UserRechargeViewController {
        let ctrl = R.storyboard.user.userRechargeViewController()!
        ctrl.money = money
        return ctrl
    }

}

extension TSEntryViewControllerHelper {

    /// 彩种投注
    ///
    /// - Parameters:
    ///   - lottery: 彩种
    ///   - playType: 玩法
    /// - Returns:
    static func lotteryViewController(lottery: LotteryType, playType: PlayType, recommendModels: [RecommendDetailModel]? = nil) -> (UIViewController & ChooseViewControllerProtocol) {
        
        var ctrl: (UIViewController & ChooseViewControllerProtocol)!
        switch lottery {
           case .jczq: ctrl = jczqMainViewController(playType: playType, recommendModels: recommendModels)
           case .jclq: ctrl = jclqMainViewController(playType: playType)
           case .bd: ctrl = beiDanMainViewController(playType: playType)
           default:  ctrl = jclqMainViewController(playType: playType)
        }
        return ctrl
    }

    /// 竞彩足球投注页
    ///
    /// - Parameter playType: 玩法
    /// - Returns:
    static func jczqMainViewController(playType: PlayType = .hh, recommendModels: [RecommendDetailModel]? = nil) -> JczqMainViewController {
        let ctrl = JczqMainViewController()
        ctrl.playType = playType
        ctrl.recommendModels = recommendModels
        return ctrl
    }
    
    /// 竞彩篮球投注页
    ///
    /// - Parameter playType: 玩法
    /// - Returns:
    static func jclqMainViewController(playType: PlayType = .hh) -> JclqMainViewController {
        let ctrl = JclqMainViewController()
        ctrl.playType = playType
        return ctrl
    }
    
    
    /// 北京单场投注页
    ///
    /// - Parameter playType: 玩法
    /// - Returns:
    static func beiDanMainViewController(playType: PlayType = .fb_spf) -> BeiDanMainViewController {
        let ctrl = BeiDanMainViewController()
        ctrl.playType = playType
        return ctrl
    }
    
}

/// 通过url打开对应的页面
extension TSEntryViewControllerHelper{
    

    enum ModelType :String{
        case news
        case lottery
        case plan
        case recommend
        case copy_order
        case none
    }
    
    
    /// 通过URL判断打开的方式
    ///
    /// - Parameter schemeUrlString: 路径
    /// - Returns:
    func openControllerFromUrl(schemeUrlString: String,urlString:String? = nil ) {
        if schemeUrlString.isEmpty && urlString == nil {
            return
        }
        
        
        let schemeUrl = URL(string: schemeUrlString)!
        let ctrl = oepnControllerFromSchemeUrl(schemeUrl: schemeUrl)
        if let  controller = ctrl  {
            controller.hidesBottomBarWhenPushed = true
            TSPublicTool.rootViewController().pushViewController(controller, animated: true)
        }
        
        
        
        /// 或者 查找不到 用url打开
        if(!schemeUrl.absoluteString.contains("caidian310") || ctrl == nil){
            /// webView 处理
            
            if var url = urlString {
            
                var token = ""
                if !url.contains("?")  {
                    token = url + "?token="
                } else {
                    token = url + "&token="
                }
                
                
                if let userInfo = UserToken.shared.userInfo {
                    url = token + userInfo.token
                }
                let ctrl = TSEntryViewControllerHelper.webView(url: url)
                ctrl.hidesBottomBarWhenPushed = true
                TSPublicTool.rootViewController().pushViewController(ctrl, animated: true)
                
                
            }
  
        }
      
    }
    
    
    /// 通过URL打开对应的控制器
    ///
    /// - Parameter schemeUrlString: 路径
    /// - Returns:
    func oepnControllerFromSchemeUrl(schemeUrl:URL) -> UIViewController? {
        
        let scheme = schemeUrl.scheme
        let host = schemeUrl.host
        let pathList = schemeUrl.path.split(separator: "/")
        let id = schemeUrl.querys?["id"] ?? nil
        
        if  scheme == nil {return nil}
    
        switch host {

            // 新闻模块
        case ModelType.news.rawValue:
            
            if id == nil {
                return nil
            }
            if let newsId = Int(id!) {
                return TSEntryViewControllerHelper.newsDetailViewController(newsId: newsId)
            }
            return nil

            ///彩种
        case ModelType.lottery.rawValue:
            
            let lotteryId = schemeUrl.querys?["lottery_id"]
            let playId = schemeUrl.querys?["play_id"] ?? "\(PlayType.hh.rawValue)"
            let isBetCtrl = pathList.contains("bet")
            
            if lotteryId == nil || !isBetCtrl  {
                return nil
            }
            
            let playType = PlayType.bb_dxf.getPlayType(playId: Int(playId)!)
            if Int(lotteryId!)! == LotteryType.jclq.rawValue {
                return TSEntryViewControllerHelper.jclqMainViewController(playType: playType)
            }
            return TSEntryViewControllerHelper.jczqMainViewController(playType: playType)
            
            /// 复制跟单
        case ModelType.copy_order.rawValue:
            let detailId = Int(id ?? "0") ?? 0
            if pathList.contains("sponsor") {
                return TSEntryViewControllerHelper.copyOrderSponsorDetailViewController(userId: detailId)
            }else if pathList.contains("detail"){
                 return TSEntryViewControllerHelper.copyOrderDetailViewController(orderId: detailId)
            }
            return nil
            
            /// 计划单
        case ModelType.plan.rawValue:
            let planId = Int(id ?? "0") ?? 0
            return TSEntryViewControllerHelper.planOrderDetailViewController(planDetailId: planId)
            
            /// 推荐模块
        case ModelType.recommend.rawValue:
            let recommendId = Int(id ?? "0") ?? 0
            if pathList.contains("professor") {
                return TSEntryViewControllerHelper.recommendOrderUserDetailViewController(professorId: recommendId)
            }else if pathList.contains("detail"){
                return TSEntryViewControllerHelper.recommendOrderDetailViewController(recommendId: recommendId)
            }
            return nil
            
        default : return nil
        }
        
    }
    
      
    
}
