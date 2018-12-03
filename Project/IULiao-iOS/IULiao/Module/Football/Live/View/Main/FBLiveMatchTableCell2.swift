//
//  FBLiveMatchTableCell2.swift
//  IULiao
//
//  Created by tianshui on 2018/1/12.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
                self.contentView.backgroundColor = UIColor.white
            }, completion: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            contentView.backgroundColor = UIColor(hex: 0xF2F2F2)
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
//    override var isHighlighted: Bool {
//        didSet {
//            if isHighlighted {
//                contentView.backgroundColor = UIColor(hex: 0xF2F2F2)
//            } else {
//                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
//                    self.contentView.backgroundColor = UIColor.white
//                }, completion: nil)
//            }
//        }
//    }
//
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                contentView.backgroundColor = UIColor(hex: 0xF2F2F2)
//            } else {
//                contentView.backgroundColor = UIColor.white
//            }
//        }
//    }
    
}


class FBLiveMatchTableCell2: UITableViewCell {

    @IBOutlet weak var attentionButton: UIButton!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeRedLabel: UILabel!
    @IBOutlet weak var awayRedLabel: UILabel!
    @IBOutlet weak var homeYellowLabel: UILabel!
    @IBOutlet weak var awayYellowLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var blinkImageView: UIImageView!
    @IBOutlet weak var homeBoxView: UIView!
    @IBOutlet weak var awayBoxView: UIView!
    @IBOutlet weak var homeRankLabel: UILabel!
    @IBOutlet weak var awayRankLabel: UILabel!
    
    @IBOutlet weak var liveAnimationButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var otherBoxView: UIView!
    
    @IBOutlet weak var statisticsView: FBLiveMatchStatisticsView!
    
    /// 统计信息组
    @IBOutlet var statisticImageViews: [UIImageView]!
    
    @IBOutlet weak var lineViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeYellowLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayYellowLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeRankLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayRankLabelWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scoreBoxWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayLabelLeftConstraint: NSLayoutConstraint!
    
    private var match: FBLiveMatchModel2?
    
    typealias ButtonClickBlock = (UIButton) -> Void
    
    typealias ImageViewClickBlock = () -> Void
    
    var moreButtonClickBlock: ButtonClickBlock?
    var attentionButtonClickBlock: ButtonClickBlock?
    var liveAnimationButtonClickBlock: ButtonClickBlock?
    var recommendImageViewClickBlock: ImageViewClickBlock?
    var liaoImageViewClickBlock: ImageViewClickBlock?
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        restoreColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        restoreColor()
    }
    
    private func restoreColor() {
        if awayBoxView.backgroundColor == UIColor(hex: 0xFC9A39) {
            awayBoxView.backgroundColor = UIColor(hex: 0xFC9A39)
        }
        awayRedLabel.backgroundColor = UIColor(hex: 0xEE2F2F)
        awayYellowLabel.backgroundColor = UIColor(hex: 0xFDEA47)
        homeRedLabel.backgroundColor = UIColor(hex: 0xEE2F2F)
        homeYellowLabel.backgroundColor = UIColor(hex: 0xFDEA47)

        for v1 in statisticsView.contentView.subviews {
            for v2 in v1.subviews {
                if v2.height <= 1 {
                    v2.backgroundColor = UIColor(hex: 0xCCCCCC)
                }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let img1 = R.image.fbLive.blink1()!
        let img2 = R.image.fbLive.blink2()!
        blinkImageView.animationImages = [img1, img2]
        blinkImageView.animationDuration = 1
        if TSScreen.currentWidth == TSScreen.iPhone5Width {
            homeLabelRightConstraint.constant = 0
            awayLabelLeftConstraint.constant = 0
            scoreBoxWidthConstraint.constant = 44
        } else {
            homeLabelRightConstraint.constant = 2
            awayLabelLeftConstraint.constant = 2
            scoreBoxWidthConstraint.constant = 50
        }
        let imageActions = [#selector(recommendAction(_:)), #selector(liaoAction(_:)), #selector(liaoAction(_:))]
        for i in 0 ..< statisticImageViews.count {
            statisticImageViews[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: imageActions[i]))
        }
    }
    
    func configCell(match: FBLiveMatchModel2, isFirstRow: Bool = false, statistics: FBMatchStatisticsModel? = nil) {
        
        self.match = match
        serialLabel.isHidden = match.serial == "000"
        serialLabel.text = match.serial
        homeLabel.text = match.home[0..<4]
        awayLabel.text = match.away[0..<4]
        leagueLabel.text = match.league.name
        leagueLabel.textColor = match.league.color
        matchTimeLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "HH:mm", isIntelligent: false)
        attentionButton.isSelected = match.isAttention
        lineViewHeightConstraint.constant = isFirstRow ? 0 : 5
        moreButton.setImage(match.isExpandStatisticsView ? R.image.fbLive.moreUp()! : R.image.fbLive.moreDown(), for: .normal)
        
        statisticsView.isHidden = !match.isExpandStatisticsView
        if let statistics = statistics {
            statisticsView.configView(match: match, statistics: statistics)
        }
        configRedYellowCard(match: match)
        configStatistic(match: match)
        configOtherInfo(match: match)
        configRank(match: match)
        configLive(match: match)
    }

    @IBAction func moreButtonAction(_ sender: UIButton) {
        moreButtonClickBlock?(sender)
    }
    
    @IBAction func attentionButtonAction(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        attentionButtonClickBlock?(sender)
    }
    
    @IBAction func liveAnimationButtonAction(_ sender: UIButton) {
        liveAnimationButtonClickBlock?(sender)
    }
    
    @objc private func recommendAction(_ gesture: UITapGestureRecognizer) {
        recommendImageViewClickBlock?()
    }
    
    @objc private func liaoAction(_ gesture: UITapGestureRecognizer) {
        liaoImageViewClickBlock?()
    }
    
}

extension FBLiveMatchTableCell2 {
    /// 即时比分
    private func configLive(match: FBLiveMatchModel2) {
        let state = match.stateType
        if state == .uptHalf || state == .downHalf {
            stateLabel.text = "\(state.name) \(match.liveTime())"
            blinkImageView.isHidden = false
            blinkImageView.startAnimating()
        } else {
            stateLabel.text = state.name
            blinkImageView.isHidden = true
            blinkImageView.stopAnimating()
        }
        
        
        stateLabel.textColor = state.color
        vsLabel.textColor = state.color
        homeScoreLabel.textColor = state.color
        awayScoreLabel.textColor = state.color
        
        /// 球队进球方 球队名标记背景 比分标记红色
        if match.lastHomeScore != nil && match.lastHomeScore ?? 0 < match.homeScore  ?? 0 {
            homeScoreLabel.textColor = FBColorType.red.color
            homeBoxView.backgroundColor = TSColor.logo
            homeLabel.textColor = UIColor.white
            homeRankLabel.textColor = UIColor.white
        } else {
            homeBoxView.backgroundColor = UIColor.clear
            homeLabel.textColor = TSColor.gray.gamut444444
            homeRankLabel.textColor = TSColor.gray.gamut999999
        }
        
        if match.lastAwayScore != nil && match.lastAwayScore ?? 0 < match.awayScore ?? 0 {
            awayScoreLabel.textColor = FBColorType.red.color
            awayBoxView.backgroundColor = TSColor.logo
            awayLabel.textColor = UIColor.white
            awayRankLabel.textColor = UIColor.white
        } else {
            awayBoxView.backgroundColor = UIColor.clear
            awayLabel.textColor = TSColor.gray.gamut444444
            awayRankLabel.textColor = TSColor.gray.gamut999999
        }
        
        if let homeScore = match.homeScore {
            homeScoreLabel.text = "\(homeScore)"
        }
        if let awayScore = match.awayScore {
            awayScoreLabel.text = "\(awayScore)"
        }
        
        switch state {
        case .notStarted, .cancel, .delaye:
            //            vsLabel.text = "VS"
            homeScoreLabel.isHidden = true
            awayScoreLabel.isHidden = true
        default:
            //            vsLabel.text = "-"
            homeScoreLabel.isHidden = false
            awayScoreLabel.isHidden = false
        }
    }
    
    /// 排名
    private func configRank(match: FBLiveMatchModel2) {
        if match.homeRank > 0 {
            homeRankLabel.text = "[\(match.homeRank)]"
            homeRankLabel.isHidden = false
//            homeRankLabelWidthConstraint.constant = 20
        } else {
            homeRankLabel.isHidden = true
//            homeRankLabelWidthConstraint.constant = 0
        }
        
        if match.awayRank > 0 {
            awayRankLabel.text = "[\(match.awayRank)]"
            awayRankLabel.isHidden = false
//            awayRankLabelWidthConstraint.constant = 20
        } else {
            awayRankLabel.isHidden = true
//            awayRankLabelWidthConstraint.constant = 0
        }
    }
    
    /// 其他信息 半场角球点球加时
    private func configOtherInfo(match: FBLiveMatchModel2) {
        let state = match.stateType
        var isShowOtherInfo = UserToken.shared.isLiveShowInfo
        if state != .uptHalf && state != .halfTime && state != .downHalf && state != .over {
            // 比赛未开始 当做不显示其他信息
            isShowOtherInfo = false
        }
        if isShowOtherInfo {
            
            if state == .uptHalf || state == .halfTime || state == .downHalf {
                // 比赛进行 直播
                liveAnimationButton.isHidden = !(match.liveAnimationCount > 0)
                liveAnimationButton.setImage(R.image.fbLive.animationLive(), for: .normal)
            } else if state == .over {
                // 比赛结束 回播
                liveAnimationButton.isHidden = !(match.liveAnimationCount > 0)
                liveAnimationButton.setImage(R.image.fbLive.animationReplay(), for: .normal)
            } else {
                // 其他状态 隐藏
                liveAnimationButton.isHidden = true
            }
            
            var infos = [String]()
            if state == .halfTime || state == .downHalf || state == .over {
                if let home = match.homeHalfScore, let away = match.awayHalfScore {
                    infos.append("半场\(home)-\(away)")
                }
            }
            if state == .over {
                if let home = match.homeOverTime, let away = match.awayOverTime {
                    infos.append("加时\(home)-\(away)")
                }
            }
            if match.homeCorner > 0 || match.awayCorner > 0 {
                infos.append("角球\(match.homeCorner)-\(match.awayCorner)")
            }
            if state == .over {
                if let home = match.homePenalty, let away = match.awayPenalty {
                    infos.append("点球\(home)-\(away)")
                }
            }
            let str = infos.joined(separator: "    ")
            otherLabel.text = str
            otherBoxView.isHidden = false
        } else {
            liveAnimationButton.isHidden = true
            otherBoxView.isHidden = true
        }
    }
    /// 统计信息
    private func configStatistic(match: FBLiveMatchModel2) {
        statisticImageViews.forEach {
            $0.isHidden = true
        }
        if !UserToken.shared.isLiveShowLiao {
            return
        }
        
        let items: [(name: String, count: Int, image: UIImage?)] = [
            ("recommend", match.recommendCount, R.image.fbLive.statisticRecommend()),
            ("brief", match.briefNewsCount, R.image.fbLive.statisticBrief()),
            ("injury", match.injuryCount, R.image.fbLive.statisticInjury()),
            ]
        var i = 0
        for item in items {
            if item.count <= 0 {
                continue
            }
            
            statisticImageViews[safe: i]?.isHidden = false
            statisticImageViews[safe: i]?.image = item.image
            
            i += 1
        }
    }
    
    /// 红黄牌
    private func configRedYellowCard(match: FBLiveMatchModel2) {
        homeRedLabel.isHidden = true
        awayRedLabel.isHidden = true
        if UserToken.shared.isLiveShowRed {
            homeRedLabel.text = "\(match.homeRed)"
            awayRedLabel.text = "\(match.awayRed)"
            if match.homeRed > 0 {
                homeRedLabel.isHidden = false
            }
            if match.awayRed > 0 {
                awayRedLabel.isHidden = false
            }
        }
        
        homeYellowLabel.isHidden = true
        awayYellowLabel.isHidden = true
        if UserToken.shared.isLiveShowYellow {
            homeYellowLabel.text = "\(match.homeYellow)"
            awayYellowLabel.text = "\(match.awayYellow)"
            if match.homeYellow > 0 {
                homeYellowLabel.isHidden = false
                // 根据红牌是否显示调整黄牌的位置
                if homeRedLabel.isHidden {
                    homeYellowLabelRightConstraint.constant = -10
                } else {
                    homeYellowLabelRightConstraint.constant = 5
                }
            }
            if match.awayYellow > 0 {
                awayYellowLabel.isHidden = false
                if awayRedLabel.isHidden {
                    awayYellowLabelLeftConstraint.constant = -10
                } else {
                    awayYellowLabelLeftConstraint.constant = 5
                }
            }
        }
    }
}
