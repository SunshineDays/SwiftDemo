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
    static func newsDetailViewController(newsId: Int) -> NewsDetailViewController {
        let ctrl = NewsDetailViewController()
        ctrl.newsId = newsId
        return ctrl
    }
    
    /// 足球 资料库首页
    ///
    /// - Returns:
    static func fbLeagueHomeViewController() -> FBLeagueHomeViewController {
        let ctrl = R.storyboard.fbLeagueHome.fbLeagueHomeViewController()!
        return ctrl
    }
    
    
    /// 足球 联赛单页
    ///
    /// - Parameters:
    ///   - leagueId: 联赛id
    ///   - seasonId: 赛季id
    /// - Returns:
    static func fbLeagueMainViewController(leagueId: Int, seasonId: Int?) -> FBLeagueMainViewController {
        let ctrl = R.storyboard.fbLeague.fbLeagueMainViewController()!
        ctrl.leagueId = leagueId
        ctrl.seasonId = seasonId
        return ctrl
    }
    
    
    /// 足球 球队单页
    ///
    /// - Parameter teamId: 球队id
    /// - Returns:
    static func fbTeamMainViewController(teamId: Int) -> FBTeamMainViewController {
        let ctrl = R.storyboard.fbTeam.fbTeamMainViewController()!
        ctrl.teamId = teamId
        return ctrl
    }
    
    
    /// 足球 球员单页
    ///
    /// - Parameter playerId: 球员id
    /// - Returns:
    static func fbPlayerMainViewController(playerId: Int) -> FBPlayerMainViewController {
        let ctrl = FBPlayerMainViewController()
        ctrl.playerId = playerId
        return ctrl
    }
    
    
    /// 足球 赛事分析单页
    ///
    /// - Parameters:
    ///   - matchId: 对阵id
    ///   - lottery: 彩种
    ///   - selectedTab: 选中的标签
    /// - Returns: 
    static func fbMatchMainViewController(matchId: Int, lottery: Lottery?, selectedTab: FBMatchMainViewController.MatchType = .war(.recent)) -> FBMatchMainViewController {
        let ctrl = FBMatchMainViewController()
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.selectedMatchType = selectedTab
        return ctrl
    }
    
    /// 足球 赛事分析 欧赔公司详情
    ///
    /// - Parameters:
    ///   - matchId: 对阵id
    ///   - companyId: 公司id
    ///   - lottery: 彩种
    ///   - selectedTab: 选中的标签
    /// - Returns:
    static func fbMatchOddsEuropeCompanyViewController(matchId: Int, companyId: Int, lottery: Lottery?, selectedTab: FBMatchOddsEuropeCompanyViewController.EuropeType = .history) -> FBMatchOddsEuropeCompanyViewController {
        let ctrl = FBMatchOddsEuropeCompanyViewController()
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.companyId = companyId
        ctrl.selectedEuropeType = selectedTab
        return ctrl
    }

    /// 足球 赛事分析 亚盘公司详情
    ///
    /// - Parameters:
    ///   - matchId: 对阵id
    ///   - companyId: 公司id
    ///   - lottery: 彩种
    ///   - selectedTab: 选中的标签
    /// - Returns:
    static func fbMatchOddsAsiaCompanyViewController(matchId: Int, companyId: Int, lottery: Lottery?, selectedTab: FBMatchOddsAsiaCompanyViewController.AsiaType = .history) -> FBMatchOddsAsiaCompanyViewController {
        let ctrl = FBMatchOddsAsiaCompanyViewController()
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.companyId = companyId
        ctrl.selectedAsiaType = selectedTab
        return ctrl
    }
    
    /// 足球 赛事分析 大小球公司详情
    ///
    /// - Parameters:
    ///   - matchId: 对阵id
    ///   - companyId: 公司id
    ///   - lottery: 彩种
    /// - Returns:
    static func fbMatchOddsBigSmallCompanyViewController(matchId: Int, companyId: Int, lottery: Lottery?) -> FBMatchOddsBigSmallCompanyViewController {
        let ctrl = FBMatchOddsBigSmallCompanyViewController()
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.companyId = companyId
        return ctrl
    }
    
    /// 足球 即时比分 动画直播
    ///
    /// - Parameters:
    ///   - matchId: 对阵id
    /// - Returns:
    static func fbLiveAnimationViewController(matchId: Int) -> FBLiveAnimationViewController {
        let ctrl = FBLiveAnimationViewController()
        ctrl.matchId = matchId
        ctrl.hidesBottomBarWhenPushed = true
        return ctrl
    }
    
    /// 足球 推荐 详情
    ///
    /// - Parameters:
    ///   - recommendId: 推荐id
    /// - Returns:
    static func fbRecommendDetailViewController(recommendId: Int) -> FBRecommendDetailController {
        let ctrl = FBRecommendDetailController()
        ctrl.initWith(resourceId: recommendId)
        return ctrl
    }
    
    /// 足球 推荐 专家
    ///
    /// - Parameters:
    ///   - userId: 用户id
    /// - Returns:
    static func fbRecommendProfessorViewController(userId: Int, oddstype: RecommendDetailOddsType) -> FBRecommendExpertController {
        let ctrl = FBRecommendExpertController()
        ctrl.initWith(userId: userId, oddsType: oddstype)
        return ctrl
    }
}
