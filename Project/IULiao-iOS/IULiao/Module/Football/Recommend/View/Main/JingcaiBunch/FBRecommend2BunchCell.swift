//
//  FBRecommend2BunchCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 竞彩2串1 今日推荐 UITableViewCell
class FBRecommend2BunchCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 用户信息
    @IBOutlet weak var userInforView: UIView!
    @IBOutlet weak var userInforViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var hitPercentDay7: UILabel!
    @IBOutlet weak var hitPercentOrder10: UILabel!
    
    // 发布日期
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleDateLabel: UILabel!
    
    // 联赛名1
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var result1ImageView: UIImageView!
    
    @IBOutlet weak var reason2Lbael: UILabel!
    @IBOutlet weak var reasonLabelTopConstraint: NSLayoutConstraint!
    
    // 联赛名2
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var league2Label: UILabel!
    @IBOutlet weak var time2label: UILabel!
    @IBOutlet weak var homeTeam2Label: UILabel!
    @IBOutlet weak var awayTeam2Label: UILabel!
    @IBOutlet weak var vs2Label: UILabel!
    @IBOutlet weak var result2Label: UILabel!
    
    @IBOutlet weak var match2View: UIView!
    
    /// 赢
    private let selectedColor = UIColor(hex: 0xFF4444)
    /// 输
    private let defaultColor = UIColor(hex: 0xCCCCCC)
    /// 没有比赛结果
    private let emptyColor = UIColor(hex: 0xFC9A39)
    
    /// 竞彩2串1列表
    public func setupConfigView(model: FBRecommend2BunchUserModel) {
        hiddenUserInforView()
        hiddenDataView()
        matchView(oddsType: model.oddstype)
        reason2Lbael.text = model.reason.count > 0 ? "理据" : ""
        matchView(match: model.match, match2: model.match2)
        resultLabel(label: resultLabel, match: model.match, betons: model.betons)
        resultLabel(label: result2Label, match: model.match2, betons: model.betons2)
        resultImageView(oddsType: model.oddstype)
    }
    
    /// 推荐详情2串1
    public func setupConfigViewWithDetail(model: FBRecommendDetailModel) {
        selectionStyle = .none
        hiddenUserInforView()
        hiddenReasonLabel()
        matchView(oddsType: model.oddsType)
        matchView(match: model.match, match2: model.match2)
        resultLabel(label: resultLabel, match: model.match, betons: model.betons)
        resultLabel(label: result2Label, match: model.match2, betons: model.betons2)
        resultImageView(oddsType: model.oddsType)
        titleDateLabel.text = "发布时间：" + TSUtils.timestampToString(TimeInterval(model.created), withFormat: "yyyy-MM-dd HH:mm", isIntelligent: false)
    }
    
    /// 专家历史推荐（成绩单）
    public func setupConfigViewWithHistory(model: FBRecommendExpertHistoryListModel) {
        hiddenUserInforView()
        matchView(oddsType: model.oddsType)
        reason2Lbael.text = model.reason.count > 0 ? "理据" : ""
        matchView(match: model.match, match2: model.match2)
        resultLabel(label: resultLabel, match: model.match, betons: model.betons)
        resultLabel(label: result2Label, match: model.match2, betons: model.betons2)
        resultImageView(oddsType: model.oddsType)
        titleDateLabel.text = "发布时间：" + TSUtils.timestampToString(TimeInterval(model.created), withFormat: "yyyy-MM-dd HH:mm", isIntelligent: false)
    }
    
    /// 竞彩列表（赛事推荐）
    public func setupConfigViewWithRecommendFromJingcai(model: FBMatchRecommendModel) {
        matchView(oddsType: model.recommend.oddsType)
        userView(model: model.recommend.user)
        reason2Lbael.text = model.recommend.reason.count > 0 ? "理据" : ""
        matchView(match: model.recommend.match, match2: model.recommend.match2)
        resultLabel(label: resultLabel, match: model.recommend.match, betons: model.recommend.betons)
        resultLabel(label: result2Label, match: model.recommend.match2, betons: model.recommend.betons2)
        resultImageView(oddsType: model.recommend.oddsType)
        titleDateLabel.text = "发布时间：" + TSUtils.timestampToString(model.recommend.createTime, withFormat: "yyyy-MM-dd HH:mm", isIntelligent: false)
    }
    
    private func matchView(oddsType: RecommendDetailOddsType) {
        match2View.isHidden = oddsType == .single
        reasonLabelTopConstraint.constant = oddsType == .single ? 20 : 45
    }
    
    /// 赛事数据
    private func matchView(match: FBRecommendSponsorMatchModel, match2: FBRecommendSponsorMatchModel) {
        matchView(model: match, dateLabel: dateLabel, leagueLabel: leagueLabel, timeLabel: timeLabel, homeTeamLabel: homeTeamLabel, awayTeamLabel: awayTeamLabel, vsLabel: vsLabel)
        matchView(model: match2, dateLabel: date2Label, leagueLabel: league2Label, timeLabel: time2label, homeTeamLabel: homeTeam2Label, awayTeamLabel: awayTeam2Label, vsLabel: vs2Label)
    }
    
    /// 赛事界面
    private func matchView(model: FBRecommendSponsorMatchModel, dateLabel: UILabel, leagueLabel: UILabel, timeLabel: UILabel, homeTeamLabel: UILabel, awayTeamLabel: UILabel, vsLabel: UILabel) {
        dateLabel.text = model.serial
        leagueLabel.text = model.lName
        leagueLabel.textColor = UIColor(rgba: model.color)
        timeLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "HH:mm")
        homeTeamLabel.text = model.home
        awayTeamLabel.text = model.away
        if model.hScore.isEmpty || model.aScore.isEmpty {
            vsLabel.text = "VS"
            vsLabel.textColor = UIColor(hex: 0x333333)
        } else {
            vsLabel.text = "\(model.hScore)" + ":" + "\(model.aScore)"
            vsLabel.textColor = selectedColor
        }
    }
    
    /// 用户信息
    private func userView(model: FBRecommendDetailUserModel) {
        if let url = TSImageURLHelper(string: model.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
        avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
        } else {
        avatarButton.setImage(R.image.fbRecommend2.avatar60x60(), for: .normal)
        }
        nicknameLabel.text = model.nickname
        hitPercentDay7.text = model.day7PayoffPercent.decimal(2) + "%"
        hitPercentOrder10.text = model.order10PayoffPercent.decimal(2) + "%"
    }
    
    /// 设置文本属性
    private func resultLabel(label: UILabel, match: FBRecommendSponsorMatchModel, betons: [BetOn]) {
        let homeScore = Int(match.hScore) ?? 0
        let letHomeScore = homeScore + match.letBall
        let awayScore = Int(match.aScore) ?? 0
        if match.hScore.isEmpty || match.aScore.isEmpty {
            label.textColor = emptyColor
            label.layer.borderColor = emptyColor.cgColor
        } else {
            result1ImageView.isHidden = false
            // 如果选择的有任意一个中了，那就是中了
            for i in betons {
                if i.betKey == .win {
                    let isSelected = homeScore > awayScore
                    labelTextColor(label: label, isSelected: isSelected)
                    if isSelected {
                        break
                    }
                }
                if i.betKey == .draw {
                    let isSelected = homeScore == awayScore
                    labelTextColor(label: label, isSelected: isSelected)
                    if isSelected {
                        break
                    }
                }
                if i.betKey == .lost {
                    let isSelected = homeScore < awayScore
                    labelTextColor(label: label, isSelected: isSelected)
                    if isSelected {
                        break
                    }
                }
                if i.betKey == .letWin {
                    let isSelected = letHomeScore > awayScore
                    labelTextColor(label: label, isSelected: isSelected)
                    if isSelected {
                        break
                    }
                }
                if i.betKey == .letDraw {
                    let isSelected = letHomeScore == awayScore
                    labelTextColor(label: label, isSelected: isSelected)
                    if isSelected {
                        break
                    }
                }
                if i.betKey == .letLost {
                    let isSelected = letHomeScore < awayScore
                    labelTextColor(label: label, isSelected: isSelected)
                    if isSelected {
                        break
                    }
                }
            }
        }
        label.text = resultText(match: match, betons: betons)
    }
    
    /// label内容
    private func resultText(match: FBRecommendSponsorMatchModel, betons: [BetOn]) -> String {
        var str = ""
        for i in betons {
            switch i.betKey {
            case .letWin, .letDraw, .letLost:
                str = str + (match.letBall > 0 ? String(format: "主+%d球 ", match.letBall) : String(format: "主%d球 ", match.letBall))
            default: break
            }
            switch i.betKey {
            case .letWin, .win:
                str = str + "胜"
            case .letDraw, .draw:
                str = str + "平"
            case .letLost, .lost:
                str = str + "负"
            default: break
            }
            str = str + String(format: "(%.2f)", i.sp)
            str = str + "、"
        }
        if !str.isEmpty {
            str.removeLast()
        }
        return str
    }
    
    /// label边框和文字颜色
    private func labelTextColor(label: UILabel, isSelected: Bool) {
        label.textColor = isSelected ? selectedColor : defaultColor
        label.layer.borderColor = isSelected ? selectedColor.cgColor : defaultColor.cgColor
    }
    
    /// 结果图标
    private func resultImageView(oddsType: RecommendDetailOddsType) {
        if oddsType == .single {
            if resultLabel.textColor == selectedColor {
                result1ImageView.image = R.image.fbRecommend.jingcaihonorHistorywin()
            } else if resultLabel.textColor == emptyColor {
                result1ImageView.isHidden = true
            } else {
                result1ImageView.image = R.image.fbRecommend.jingcaihonorHistorylost()
            }
        } else {
            if resultLabel.textColor == selectedColor && result2Label.textColor == selectedColor {
                result1ImageView.image = R.image.fbRecommend.jingcaihonorHistorywin()
            } else if resultLabel.textColor == emptyColor || result2Label.textColor == emptyColor {
                result1ImageView.isHidden = true
            } else {
                result1ImageView.image = R.image.fbRecommend.jingcaihonorHistorylost()
            }
        }
        
    }
    
    private func hiddenUserInforView() {
        userInforView.isHidden = true
        userInforViewHeightConstraint.constant = 0
    }
    
    private func hiddenDataView() {
        dateView.isHidden = true
        dateViewHeightConstraint.constant = 0
    }
    
    private func hiddenReasonLabel() {
        reason2Lbael.isHidden = true
    }

}
