import Foundation
import Alamofire

let kTSRouterKeyPage = "page"
let kTSRouterKeyPageSize = "pagesize"
let kTSRouterKeyPhone = "phone"
let kTSRouterKeyAuthCode = "code"


///  url路由
enum TSRouter: URLRequestConvertible {

#if DEBUG
    static let baseURLString: String = {
        let urlMode = UserDefaults.standard.string(forKey: TSSettingKey.debugUrlMode) ?? "online"
        if urlMode == "online" {
            return "https://i.api.\(kBaseDomain)"
        } else if urlMode == "local" {
            return "http://i.api.iuliao.me"
        }
        return "http://i.api.youliaosport.com"
    }()
#else
    static let baseURLString = "https://i.api.\(kBaseDomain)"
#endif

    static private let privateKey = "@(iuliao#@!)@"
    
    /// 是否显示推荐（用于App Storec审核）
    case judgeIsText

    //---------------------------------------------------
    // MARK:- 足球 比分
    //---------------------------------------------------

    /// 比分对阵 issue 期号  彩种id
    case fbLiveMatchList(issue: String?, lottery: Lottery?)

    /// 比分消息
    case fbLiveMsg(liveNum: Int?)
    
    /// 比分对阵2
    case fbLiveMatchList2(issue: String?, lottery: Lottery?)
    
    /// 比分关注对阵
    case fbLiveAttentionList
    
    /// 推送设置列表
    case fbLiveSettingList
    
    /// 推送设置修改
    case fbLiveSettingEdit(liveStart: Int, liveHalf: Int, liveOver: Int, liveGoal: Int, liveRed: Int)

    //---------------------------------------------------
    // MARK:- 足球 爆料
    //---------------------------------------------------

    /// 爆料对阵
    case fbLiaoMatchList(issue: String?)

    //---------------------------------------------------
    // MARK:- 足球 赛事分析
    //---------------------------------------------------

    /// 赛事 信息
    case fbMatchInfo(matchId: Int, lottery: Lottery?)
    
    /// 赛事 统计信息
    case fbMatchStatistics(matchId: Int, lottery: Lottery?)

    /// 赛事 竞彩爆料
    case fbMatchNews(matchId: Int, lottery: Lottery?)

    /// 赛事 有料推荐
    case fbMatchRecommend(matchId: Int, lottery: Lottery?, oddsType: RecommendDetailOddsType)

    /// 赛事 赛况 比赛事件
    case fbMatchAnalyzeEvent(matchId: Int, lottery: Lottery?)

    /// 赛事 赛况 阵容
    case fbMatchAnalyzeLineup(matchId: Int, lottery: Lottery?)

    /// 赛事 战绩 近期
    case fbMatchWarRecent(matchId: Int, lottery: Lottery?)

    /// 赛事 战绩 交锋
    case fbMatchWarVersus(matchId: Int, lottery: Lottery?)

    /// 赛事 战绩 未来
    case fbMatchWarFuture(matchId: Int, lottery: Lottery?)

    /// 赛事 战绩 积分榜
    case fbMatchWarRankScore(matchId: Int, lottery: Lottery?)

    /// 赛事 战绩 相同盘口
    case fbMatchWarSameHandicap(matchId: Int, lottery: Lottery?)

    /// 赛事 战绩 进失球(进球分布)
    case fbMatchWarScoreDistribute(matchId: Int, lottery: Lottery?)

    /// 赔率 欧赔 列表
    case fbMatchEuropeOdds(matchId: Int, lottery: Lottery?)

    /// 赔率 欧赔 详情
    case fbMatchEuropeHistory(matchId: Int, companyId: Int, lottery: Lottery?)

    /// 赔率 欧赔 相同赔率
    case fbMatchEuropeSame(matchId: Int, companyId: Int, lottery: Lottery?)

    /// 赔率 亚盘 列表
    case fbMatchAsiaOdds(matchId: Int, lottery: Lottery?)

    /// 赔率 亚盘 详细
    case fbMatchAsiaHistory(matchId: Int, companyId: Int, lottery: Lottery?)

    /// 赔率 亚盘 相同盘口
    case fbMatchAsiaSame(matchId: Int, companyId: Int, lottery: Lottery?)

    /// 赔率 大小球 列表
    case fbMatchBigSmallOdds(matchId: Int, lottery: Lottery?)

    /// 赔率 大小球 详情
    case fbMatchBigSmallHistory(matchId: Int, companyId: Int, lottery: Lottery?)

    /// 赔率 比分 列表
    case fbMatchScoreOdds(matchId: Int, lottery: Lottery?)

    /// 赔率 必发
    case fbMatchBetfairOdds(matchId: Int, lottery: Lottery?)

    //---------------------------------------------------
    // MARK:- 足球 赔率
    //---------------------------------------------------

    /// 赛事对阵
    case fbOddsMatchList(issue: String?, lottery: Lottery?)

    //---------------------------------------------------
    // MARK:- 足球 资料库 联赛
    //---------------------------------------------------

    /// 资料库首页
    case fbLeagueCountryList

    /// 联赛 详情
    case fbLeagueDetail(leagueId: Int, seasonId: Int?)

    /// 联赛 赛季列表
    case fbLeagueSeasonList(leagueId: Int)

    /// 联赛 排行榜 大小球
    case fbLeagueRankBigSmall(leagueId: Int, seasonId: Int?)

    /// 联赛 排行榜 亚盘
    case fbLeagueRankAsia(leagueId: Int, seasonId: Int?)

    /// 联赛 排行榜 积分
    case fbLeagueRankScore(leagueId: Int, seasonId: Int?)

    /// 联赛 赛季阶段
    case fbLeagueStageList(leagueId: Int, seasonId: Int?)

    /// 联赛 阶段赛事
    case fbLeagueStageMatch(leagueId: Int, seasonId: Int?, stageId: Int?, groupId: Int?)

    //---------------------------------------------------
    // MARK:- 足球 资料库 球队
    //---------------------------------------------------

    /// 球队 详情
    case fbTeamDetail(teamId: Int)

    /// 球队 赛程
    case fbTeamSchedule(teamId: Int)

    /// 球队 阵容
    case fbTeamLineup(teamId: Int)

    /// 球队 资讯
    case fbTeamNews(teamId: Int, page: Int, pageSize: Int)
    
    //---------------------------------------------------
    // MARK:- 足球 资料库 球员
    //---------------------------------------------------
    
    /// 球员 详情
    case fbPlayerDetail(playerId: Int)
    
    /// 球员 技术统计
    case fbPlayerStatistics(playerId: Int)
    
    /// 球员 比赛表现
    case fbPlayerMatchList(playerId: Int, page: Int, pageSize: Int)

    //---------------------------------------------------
    // MARK:- 用户中心
    //---------------------------------------------------

    /// 注册 普通注册
    case userRegisterNormal(phone: String, authCode: String, password: String, nickname: String)

    /// 注册 第三方注册或绑定
    case userRegisterThird(phone: String, authCode: String, nickname: String, openInfo: UserOpenModel)

    /// 登录 手机号+密码
    case userLoginPassword(phone: String, password: String)

    /// 登录 手机号+验证码
    case userLoginAuthCode(phone: String, authCode: String)

    /// 登录 第三方
    case userLoginThird(openInfo: UserOpenModel)

    /// 登录 退出登录
    case userLogout

    /// 手机 找回密码
    case userGetPassword(phone: String, authCode: String, password: String)

    /// 手机 修改密码
    case userChangePassword(phone: String, authCode: String, password: String)

    /// 手机 更换手机
    case userChangePhone(phone: String, authCode: String)

    /// 信息 详情
    case userInfoDetail

    /// 信息 修改
    case userInfoUpdate(nickname: String?, gender: UserGenderType?)

    /// 用户 足迹
    case userVisitList(module: UserVisitType, page: Int, pageSize: Int)

    /// 用户 反馈
    case userFeedbackApp(content: String, phone: String?)

    //---------------------------------------------------
    // MARK:- 通用
    //---------------------------------------------------

    /// 上传头像
    case commonUploadAvatar

    /// 用户关注
    case commonAttentionFollow(resourceId: Int, module: ModuleAttentionType)

    /// 取消关注
    case commonAttentionUnFollow(resourceId: Int, module: ModuleAttentionType)

    /// 评论列表
    case commonCommentList(resourceId: Int, module: ModuleAttentionType, page: Int, pageSize: Int)

    /// 发表评论
    case commonCommentPost(resourceId: Int, module: ModuleAttentionType, content: String, parentId: Int?)

    /// 获取关注 列表
    case commonAttentionList(module: ModuleAttentionType, page: Int, pageSize: Int)

    /// 短信 发送
    case commonSMSSendCode(phone: String, smsType: UserSMSType)

    /// 短信 验证
    case commonSMSCheckCode(phone: String, authCode: String, smsType: UserSMSType)

    /// 浏览 用户
    case commonVisitUser(resourceId: Int, module: ModuleAttentionType, page: Int, pageSize: Int)

    /// 投票 赞踩
    case commonPollVote(resourceId: Int, module: ModuleAttentionType, score: Int)

    //---------------------------------------------------
    // MARK:- 广场 资讯
    //---------------------------------------------------
    case piazzaList

    /// 资讯列表
    case newsList(taxonomyId: Int?, sport: Int?, page: Int, pageSize: Int)

    /// 资讯焦点图
    case newsTopList(limit: Int?)

    /// 资讯详情
    case newsDetail(newsId: Int)

    /// 资讯搜索
    case newsSearch(keyword: String, type: NewsSearchType, page: Int, pageSize: Int)


    //---------------------------------------------------
    // MARK:- 足球 推荐
    //---------------------------------------------------

    /// 今日推荐
    case fbRecommendToday

    /// 竞猜达人
    case fbRecommendJingcaiSpecial

    /// 排行榜
    case fbRecommendRank(limit: Int, oddsType: OddStype, rankType: RankType, region: FBRegionDay)

    /// 专家详情
    case fbRecommendProfessorDetail(userId: Int)

    /// 专家历史推荐
    case fbRecommendProfessorHistory(userId: Int, page: Int, pageSize: Int)

    /// 单场推荐
    case fbRecommendDetail(recommendId: Int)

    /// 赛事选择列表
    case fbRecommendPostMatchList(lotyId: Int)

    /// 赛事详情
    case fbRecommendPostDetail(matchId: Int, lotyId: Int)

    /// 发起推荐  beton:投注串 betkey1=sp1,betkey2=sp2
    case fbRecommendPostCreate(beton: String, lotyId: Int, matchId: Int, oddsType: OddStype, reason: String?)
    
    /// 单场推荐排行
    case fbRecommendSingleList(rankType: RecommendRankType, region: RecommendRegionType, oddsType: RecommendDetailOddsType)

    /// 推荐详情
    case fbRecommend2Detail(recommendId: Int)
    
    /// 专家详情
    case fbRecommend2ExpertDetail(userId: Int)
    
    /// 专家历史推荐
    case fbRecommend2ExpertHistoryList(userId: Int, oddsType: RecommendDetailOddsType, page: Int, pageSize: Int)
    
    /// 发起 活动
    case fbRecommend2SponsorActivity
    
    /// 发起 赛事选择列表(足球)
    case fbRecommend2SponsorMatchList
    
    /// 发起 赛事选择列表(竞彩)
    case fbRecommend2SponsorMatchJingcaiList
    
    /// 发起 单场详情（投注选择）
    case fbRecommend2SponsorMatchBet(mId: Int)
    
    /// 发起 推荐发布
    case fbRecommend2SponsorMatchBetResult(json: String)
    
    /// 今日推荐 按人找
    case fbRecommend2TodayNewFromUser
    
    /// 今日推荐 按比赛
    case fbRecommend2TodayNewFromMatch
    
    /// 竞彩2串1方案
    case fbRecommend2BunchWithJingCaiList
    
    /// 竞彩个人未开奖
    case fbRecommend2CloseWithJingCaiList(userId: Int)
    
    
    // MARK:- method
    /// 路径与参数
    var pathAndParameters: (path: String, parameters: [String: Any]) {
        var result: (path: String, parameters: [String: Any])
        switch self {

        /// 是否显示推荐（用于App Storec审核）
        case .judgeIsText:
            result = ("/app/setting/permissions_list", [:])
            
        //---------------------------------------------------
        // MARK:- 广场
        //---------------------------------------------------

        // 广场
        case .piazzaList:
            result = ("/main/home/plaza", [:])

        // 新闻资讯
        case let .newsList(taxonomyId, sport, page, pageSize):
            result = ("/main/news/lists", [kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            if let taxonomyId = taxonomyId {
                result.parameters.updateValue(taxonomyId, forKey: "taxonomyid")
            }
            if let sport = sport {
                result.parameters.updateValue(sport, forKey: "sport")
            }

        // 资讯推荐
        case let .newsTopList(limit):
            result = ("/main/news/tops", ["limit": limit ?? 6])

        // 资讯详情
        case let .newsDetail(newsId):
            result = ("/main/news/detail", ["id": newsId])

        // 资讯搜索
        case let .newsSearch(keyword, type, page, pageSize):
            result = ("/main/news/search", [kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize, "keyword": keyword])
            if type != .none {
                result.parameters.updateValue(type.rawValue, forKey: "type")
            }

        //---------------------------------------------------
        // MARK:- 足球 比分
        //---------------------------------------------------

        // 比分对阵
        case let .fbLiveMatchList(issue, lottery):
            result = ("/football/live2/match_list", [:])
            if let issue = issue {
                result.parameters.updateValue(issue, forKey: "issue")
            }
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 比分消息
        case let .fbLiveMsg(liveNum):
            result = ("/football/live/livemsg", [:])
            if let liveNum = liveNum {
                result.parameters.updateValue(liveNum, forKey: "livenum")
            }
            
        // 比分对阵2
        case let .fbLiveMatchList2(issue, lottery):
            result = ("/football/live2/match_list", [:])
            if let issue = issue {
                result.parameters.updateValue(issue, forKey: "issue")
            }
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }
            
        // 比分关注列表
        case .fbLiveAttentionList:
            result = ("/football/live2/attention_list", [:])
            
        /// 推送设置列表
        case .fbLiveSettingList:
            result = ("user/setting/detail", [:])
        /// 推送设置修改
        case let .fbLiveSettingEdit(liveStart, liveHalf, liveOver, liveGoal, liveRed):
            result = ("user/setting/update", ["live_start": liveStart, "live_half": liveHalf, "live_over": liveOver, "live_goal": liveGoal, "live_red": liveRed])


        //---------------------------------------------------
        // MARK:- 足球 爆料
        //---------------------------------------------------

        // 爆料对阵
        case let .fbLiaoMatchList(issue):
            result = ("/football/liao/matchlist", [:])
            if let issue = issue {
                result.parameters.updateValue(issue, forKey: "issue")
            }

        //---------------------------------------------------
        // MARK:- 足球 赛事分析
        //---------------------------------------------------

        // 赛事 详情
        case let .fbMatchInfo(matchId, lottery):
            result = ("/football/match/info", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }
            
        // 赛事 统计信息
        case let .fbMatchStatistics(matchId, lottery):
            result = ("/football/match/home/statistics", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 竞彩爆料
        case let .fbMatchNews(matchId, lottery):
            result = ("/football/match/news", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 有料推荐
        case let .fbMatchRecommend(matchId, lottery, oddsType):
            result = ("/football/match/recommend/index2", ["mid": matchId, "oddstype": oddsType.rawValue])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 赛况 比赛事件
        case let .fbMatchAnalyzeEvent(matchId, lottery):
            result = ("/football/match/analyze/event", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 赛况 阵容
        case let .fbMatchAnalyzeLineup(matchId, lottery):
            result = ("/football/match/analyze/lineup", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 战绩 近期
        case let .fbMatchWarRecent(matchId, lottery):
            result = ("/football/match/war/recent", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 战绩 交锋
        case let .fbMatchWarVersus(matchId, lottery):
            result = ("/football/match/war/versus", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 战绩 未来
        case let .fbMatchWarFuture(matchId, lottery):
            result = ("/football/match/war/future", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 战绩 积分榜
        case let .fbMatchWarRankScore(matchId, lottery):
            result = ("/football/match/war/rank_score", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 战绩 相同盘口
        case let .fbMatchWarSameHandicap(matchId, lottery):
            result = ("/football/match/war/same_handicap", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赛事 战绩 进失球(进球分布)
        case let .fbMatchWarScoreDistribute(matchId, lottery):
            result = ("/football/match/war/score_distribute", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赔率 欧赔 列表
        case let .fbMatchEuropeOdds(matchId, lottery):
            result = ("/football/match/europe/odds", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赔率 欧赔 详情
        case let .fbMatchEuropeHistory(matchId, companyId, lottery):
            result = ("/football/match/europe/history", ["mid": matchId, "company_id": companyId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赔率 欧赔 相同赔率
        case let .fbMatchEuropeSame(matchId, companyId, lottery):
            result = ("/football/match/europe/same", ["mid": matchId, "company_id": companyId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }
        // 赔率 亚盘 列表
        case let .fbMatchAsiaOdds(matchId, lottery):
            result = ("/football/match/asia/odds", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赔率 亚盘 详细
        case let .fbMatchAsiaHistory(matchId, companyId, lottery):
            result = ("/football/match/asia/history", ["mid": matchId, "company_id": companyId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }
        // 赔率 亚盘 相同盘口
        case let .fbMatchAsiaSame(matchId, companyId, lottery):
            result = ("/football/match/asia/same", ["mid": matchId, "company_id": companyId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }
        // 赔率 大小球 列表
        case let .fbMatchBigSmallOdds(matchId, lottery):
            result = ("/football/match/big_small/odds", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赔率 大小球 详情
        case let .fbMatchBigSmallHistory(matchId, companyId, lottery):
            result = ("/football/match/big_small/history", ["mid": matchId, "company_id": companyId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }
        // 赔率 比分 列表
        case let .fbMatchScoreOdds(matchId, lottery):
            result = ("/football/match/score/odds", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        // 赔率 必发
        case let .fbMatchBetfairOdds(matchId, lottery):
            result = ("/football/match/betfair/odds", ["mid": matchId])
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        //---------------------------------------------------
        // MARK:- 足球 赔率
        //---------------------------------------------------

        // 对阵
        case let .fbOddsMatchList(issue, lottery):
            result = ("/football/odds/matchlist", [:])
            if let issue = issue {
                result.parameters.updateValue(issue, forKey: "issue")
            }
            if let lottery = lottery {
                result.parameters.updateValue(lottery.lotyid, forKey: "lotyid")
            }

        //---------------------------------------------------
        // MARK:- 足球 推荐
        //---------------------------------------------------

        // 推荐排行
        case let .fbRecommendRank(limit, oddsType, rankType, region):
            result = ("/football/recommend/rank", ["limit": limit, "oddstype": oddsType.rawValue, "ranktype": rankType.rawValue, "region": region.rawValue])

        // 竞彩达人
        case .fbRecommendJingcaiSpecial:
            result = ("/football/recommend/jingcai_special", [:])

        // 今日推荐
        case .fbRecommendToday:
            result = ("/football/recommend/today", [:])

        // 专家详情
        case let .fbRecommendProfessorDetail(userId):
            result = ("/football/recommend/professor", ["userid": userId])

        // 专家历史
        case let .fbRecommendProfessorHistory(userId, page, pageSize):
            result = ("/football/recommend/professor_history", ["userid": userId, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

        // 推荐详情
        case let .fbRecommendDetail(recommendId):
            result = ("/football/recommend/detail", ["id": recommendId])

        // 推荐发起列表
        case let .fbRecommendPostMatchList(lotyId):
            result = ("/football/recommend_post/matchlist", ["lotyid": lotyId])

        // 推荐详情
        case let .fbRecommendPostDetail(matchId, lotyId):
            result = ("/football/recommend_post/detail", ["mid": matchId, "lotyid": lotyId])

        // 推荐发起
        case let .fbRecommendPostCreate(beton, lotyId, matchId, oddsType, reason):
            result = ("/football/recommend_post/create", ["mid": matchId, "beton": beton, "lotyid": lotyId, "oddstype": oddsType.rawValue])
            if let reason = reason {
                result.parameters.updateValue(reason, forKey: "reason")
            }
          
        // 单场推荐
        case let .fbRecommendSingleList(rankType, region, oddsType):
            result = ("/football/recommend2/rank", ["ranktype": rankType.rawValue, "region": region.rawValue, "oddstype": oddsType.rawValue])
            
        // 推荐详情
        case let .fbRecommend2Detail(recommeId):
            result = ("/football/recommend2/detail", ["id": recommeId])
            
        // 专家详情
        case let .fbRecommend2ExpertDetail(userId):
            result = ("/football/recommend2/professor", ["userid": userId])

        // 专家历史推荐
        case let .fbRecommend2ExpertHistoryList(userId, oddsType, page, pageSize):
            result = ("/football/recommend2/professor_history", ["userid": userId, "oddstype": oddsType.rawValue, "page": page, "pagesize": pageSize])
        
        // 发起 活动
        case .fbRecommend2SponsorActivity:
            result = ("/football/recommend_post2", [:])
            
        // 发起 赛事选择列表(足球)
        case .fbRecommend2SponsorMatchList:
            result = ("/football/recommend_post2/football", [:])
            
        /// 发起 赛事选择列表(竞彩)
        case .fbRecommend2SponsorMatchJingcaiList:
            result = ("/football/recommend_post2/jingcai", [:])
           
        // 发起 单场详情（投注选择）
        case let .fbRecommend2SponsorMatchBet(mId):
            result = ("/football/recommend_post2/football_detail", ["mid": mId])
            
        // 发起 推荐发布
        case let .fbRecommend2SponsorMatchBetResult(json):
            result = ("/football/recommend_post2/create", ["json": json])
            
        /// 今日推荐 按人找
        case .fbRecommend2TodayNewFromUser:
            result = ("/football/recommend2/football_today_by_user", [:])
            
        /// 今日推荐 按比赛
        case .fbRecommend2TodayNewFromMatch:
            result = ("/football/recommend2/football_today_by_match", [:])
            
            
        /// 竞彩2串1方案
        case .fbRecommend2BunchWithJingCaiList:
            result = ("/football/recommend2/jingcai_today", [:])
        /// 竞彩个人未开奖
        case let .fbRecommend2CloseWithJingCaiList(userId):
            result = ("/football/recommend2/jingcai_user_recommend", ["userid": userId])

        //---------------------------------------------------
        // MARK:- 资料库 联赛
        //---------------------------------------------------

        // 国家列表
        case .fbLeagueCountryList:
            result = ("/football/league/countrylist", [:])

        // 联赛 详情
        case let .fbLeagueDetail(leagueId, seasonId):
            result = ("/football/league/detail", ["lid": leagueId])
            if let seasonId = seasonId {
                result.parameters.updateValue(seasonId, forKey: "sid")
            }

        // 联赛 赛季列表
        case let .fbLeagueSeasonList(leagueId):
            result = ("/football/league/seasonlist", ["lid": leagueId])

        // 联赛 排行榜 亚盘
        case let .fbLeagueRankAsia(leagueId, seasonId):
            result = ("/football/league/rank_asia", ["lid": leagueId])
            if let seasonId = seasonId {
                result.parameters.updateValue(seasonId, forKey: "sid")
            }

        // 联赛 排行榜 大小球
        case let .fbLeagueRankBigSmall(leagueId, seasonId):
            result = ("/football/league/rank_daxiao", ["lid": leagueId])
            if let seasonId = seasonId {
                result.parameters.updateValue(seasonId, forKey: "sid")
            }

        // 联赛 排行榜 积分
        case let .fbLeagueRankScore(leagueId, seasonId):
            result = ("/football/league/rank_score", ["lid": leagueId])
            if let seasonId = seasonId {
                result.parameters.updateValue(seasonId, forKey: "sid")
            }
        
        // 联赛 阶段
        case let .fbLeagueStageList(leagueId, seasonId):
            result = ("/football/league/stagelist", ["lid": leagueId])
            if let seasonId = seasonId {
                result.parameters.updateValue(seasonId, forKey: "sid")
            }
            
        // 联赛 阶段赛事
        case let .fbLeagueStageMatch(leagueId, seasonId, stageId, groupId):
            result = ("/football/league/stagematch", ["lid": leagueId])
            if let seasonId = seasonId {
                result.parameters.updateValue(seasonId, forKey: "sid")
            }
            if let stageId = stageId {
                result.parameters.updateValue(stageId, forKey: "stageid")
            }
            if let groupId = groupId {
                result.parameters.updateValue(groupId, forKey: "groupid")
            }

        //---------------------------------------------------
        // MARK:- 资料库 球队
        //---------------------------------------------------

        /// 球队 详情
        case let .fbTeamDetail(teamId):
            result = ("/football/team/detail", ["tid": teamId])

        /// 球队 赛程
        case let .fbTeamSchedule(teamId):
            result = ("/football/team/schedule", ["tid": teamId])

        /// 球队 阵容
        case let .fbTeamLineup(teamId):
            result = ("/football/team/lineup", ["tid": teamId])

        /// 球队 资讯
        case let .fbTeamNews(teamId, page, pageSize):
            result = ("/football/team/news", ["tid": teamId, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])


        //---------------------------------------------------
        // MARK:- 资料库 球队
        //---------------------------------------------------

        /// 球员 详情
        case let .fbPlayerDetail(playerId):
            result = ("/football/player/detail", ["pid": playerId])

        /// 球员 技术统计
        case let .fbPlayerStatistics(playerId):
            result = ("/football/player/statistics", ["pid": playerId])

        /// 球员 比赛表现
        case let .fbPlayerMatchList(playerId, page, pageSize):
            result = ("/football/player/matchlist", ["pid": playerId, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            
        //---------------------------------------------------
        // MARK:- 用户
        //---------------------------------------------------

        case let .userRegisterNormal(phone, authCode, password, nickname):
            result = ("/user/register/normal", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password, "nickname": nickname])

        case let .userRegisterThird(phone, authCode, nickname, open):
            result = ("/user/register/thirdregister", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "nickname": nickname, "openid": open.openID, "gender": open.gender.rawValue, "access_token": open.accessToken, "expiration": open.expiration, "genre": open.thirdType.rawValue])
            if let avatarUrl = open.avatarUrl {
                result.parameters.updateValue(avatarUrl, forKey: "avatar_url")
            }
            if let refreshToken = open.refreshToken {
                result.parameters.updateValue(refreshToken, forKey: "refresh_token")
            }

        case let .userLoginPassword(phone, password):
            result = ("/user/login/normal", [kTSRouterKeyPhone: phone, "password": password])

        case let .userLoginAuthCode(phone, authCode):
            result = ("/user/login/normal", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode])

        case let .userLoginThird(open):
            result = ("/user/login/thirdlogin", ["nickname": open.nickname, "openid": open.openID, "gender": open.gender.rawValue, "access_token": open.accessToken, "expiration": open.expiration, "genre": open.thirdType.rawValue])
            if let avatarUrl = open.avatarUrl {
                result.parameters.updateValue(avatarUrl, forKey: "avatar_url")
            }
            if let refreshToken = open.refreshToken {
                result.parameters.updateValue(refreshToken, forKey: "refresh_token")
            }
        case .userLogout:
            result = ("/user/login/logout", [:])

        case let .userGetPassword(phone, authCode, password):
            result = ("/user/phone/getpassword", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password])

        case let .userChangePassword(phone, authCode, password):
            result = ("/user/phone/changepassword", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode, "password": password])

        case let .userChangePhone(phone, authCode):
            result = ("/user/phone/changephone", [kTSRouterKeyPhone: phone, kTSRouterKeyAuthCode: authCode])

        case let .userVisitList(module, page, pageSize):
            result = ("/user/visit/lists", ["module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

        case let .userFeedbackApp(content, phone):
            result = ("/user/feedback/app", ["content": content])
            if let phone = phone {
                result.parameters.updateValue(phone, forKey: kTSRouterKeyPhone)
            }

        case .userInfoDetail:
            result = ("/user/info/detail", [:])

        case let .userInfoUpdate(nickname, gender):
            result = ("/user/info/update", [:])
            if let nickname = nickname {
                result.parameters.updateValue(nickname, forKey: "nickname")
            }
            if let gender = gender {
                result.parameters.updateValue(gender.rawValue, forKey: "gender")
            }

        //---------------------------------------------------
        // MARK:- 通用
        //---------------------------------------------------

        // 关注 添加
        case let .commonAttentionFollow(resourceId, module):
            result = ("/common/attention/follow", ["sid": resourceId, "module": module.rawValue])

        // 关注 取消
        case let .commonAttentionUnFollow(resourceId, module):
            result = ("/common/attention/unfollow", ["sid": resourceId, "module": module.rawValue])

        // 关注 列表
        case let .commonAttentionList(module, page, pageSize):
            result = ("/common/attention/lists", ["module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

        // 评论 列表
        case let .commonCommentList(resourceId, module, page, pageSize):
            result = ("/common/comment/lists", ["sid": resourceId, "module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])

        // 评论 发起
        case let .commonCommentPost(resourceId, module, content, parentId):
            result = ("/common/comment/post", ["sid": resourceId, "module": module.rawValue, "content": content, "parentid": parentId ?? 0])

        // 短信 发送
        case let .commonSMSSendCode(phone, smsType):
            result = ("/common/sms/sendcode", [kTSRouterKeyPhone: phone, "type": smsType.rawValue])

        // 短信 校验
        case let .commonSMSCheckCode(phone, authCode, smsType):
            result = ("/common/sms/checkcode", [kTSRouterKeyPhone: phone, "type": smsType.rawValue, kTSRouterKeyAuthCode: authCode])

        // 上传 头像
        case .commonUploadAvatar:
            result = ("/common/upload/avatar", [:])

        // 用户浏览
        case let .commonVisitUser(resourceId, module, page, pageSize):
            result = ("/common/visit/user", ["sid": resourceId, "module": module.rawValue, kTSRouterKeyPage: page, kTSRouterKeyPageSize: pageSize])
            
        // 投票赞踩
        case let .commonPollVote(resourceId, module, score):
            result = ("/common/poll/vote", ["sid": resourceId, "module": module.rawValue, "score": score])

        }

        //统一添加 版本 token 时间戳 随机字符串
        let version = TSAppInfoHelper.appVersion
        let time = Int(Foundation.Date().timeIntervalSince1970)
        let random = TSUtils.randomString(8)

        result.parameters.updateValue(version, forKey: "v")
        result.parameters.updateValue(time, forKey: "t")
        result.parameters.updateValue(random, forKey: "r")
        result.parameters.updateValue("i", forKey: "p")

        if let token = UserToken.shared.token {
            result.parameters.updateValue(token, forKey: "token")
        }

        return result
    }

    // url request  配置请求参数 以及URLRequest、类型
    func asURLRequest() throws -> URLRequest {
        var (path, parameters) = pathAndParameters
        let signStr = sign(parameters)
        // 添加签名 加密操作
        parameters.updateValue(signStr, forKey: "sign")

        let url = try TSRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        let request = try URLEncoding.default.encode(urlRequest, with: parameters)

        return request
    }

    // 请求方法
    private var method: HTTPMethod {
#if DEBUG
        return .get
#else
        return .post
#endif
    }

    // 签名规则 所有参数key按字典序排列 key + privateKey + value 最后md5
    func sign(_ parameters: [String: Any]) -> String {
        var keys = Array(parameters.keys)
        keys.sort()

        var str = ""
        for key in keys {
            if let value = parameters[key] {
                str += "\(key)\(TSRouter.privateKey)\(value)"
            }
        }
        return str.md5

    }

    // 每个请求根据path 和 parameters算出来的md5(不包含时间t和随机数，签名sign)
    var md5: String {
        var (path, parameters) = pathAndParameters
        parameters.removeValue(forKey: "t")
        parameters.removeValue(forKey: "sign")
        parameters.removeValue(forKey: "r")
        return (path + parameters.description).md5
    }

}

