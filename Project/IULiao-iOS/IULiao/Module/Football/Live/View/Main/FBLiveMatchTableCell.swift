//
//  FBLiveMatchTableCell.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBLiveMatchTableCell: UITableViewCell {

    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeRedLabel: UILabel!
    @IBOutlet weak var awayRedLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var blinkImageView: UIImageView!
    
    @IBOutlet weak var homeRedWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var awayRedWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var liveButtonTrailingLayoutConstraint: NSLayoutConstraint!


    private var match: FBLiveMatchModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        let img1 = R.image.fbLive.blink1()!
        let img2 = R.image.fbLive.blink2()!
        blinkImageView.animationImages = [img1, img2]
        blinkImageView.animationDuration = 1
        if TSScreen.currentWidth == TSScreen.iPhone5Width {
            liveButtonTrailingLayoutConstraint.constant = 15
        }
    }
    
    func configCell(match: FBLiveMatchModel) {
        self.match = match
        serialLabel.text = match.serial
        homeLabel.text = match.home
        awayLabel.text = match.away
        leagueLabel.text = match.league.name
        leagueLabel.textColor = match.league.color
        matchTimeLabel.text = TSUtils.timestampToString(match.matchTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
        
        homeRedLabel.text = "\(match.homeRed)"
        awayRedLabel.text = "\(match.awayRed)"
        if match.homeRed == 0 {
            homeRedLabel.isHidden = true
            homeRedWidthConstraint.constant = 0
        } else {
            homeRedLabel.isHidden = false
            homeRedWidthConstraint.constant = 12
        }
        if match.awayRed == 0 {
            awayRedLabel.isHidden = true
            awayRedWidthConstraint.constant = 0
        } else {
            awayRedLabel.isHidden = false
            awayRedWidthConstraint.constant = 12
        }
        
        
        
        if match.stateType == .uptHalf || match.stateType == .downHalf {
            stateLabel.text = "\(match.stateType.name)\(match.liveTime())"
            blinkImageView.isHidden = false
            blinkImageView.startAnimating()
        } else {
            stateLabel.text = match.stateType.name
            blinkImageView.isHidden = true
            blinkImageView.stopAnimating()
        }
        
        let scoreAttrString = NSMutableAttributedString(string: "\(match.homeScore ?? 0)-\(match.awayScore ?? 0)")
        var isScoreChanged = false
        
        /// 球队进球方 球队名与比分标记红色
        if match.lastHomeScore != nil && match.lastHomeScore != match.homeScore {
            isScoreChanged = true
            homeLabel.textColor = FBColorType.red.color
            let length = "\(match.homeScore ?? 0)".count
            scoreAttrString.addAttributes([NSAttributedStringKey.foregroundColor: FBColorType.red.color], range: NSMakeRange(0, length))
        } else {
            homeLabel.textColor = UIColor.black
        }
        
        if match.lastAwayScore != nil && match.lastAwayScore != match.awayScore {
            isScoreChanged = true
            awayLabel.textColor = FBColorType.red.color
            let length = "\(match.awayScore ?? 0)".count
            let loc = "\(match.homeScore ?? 0)-".count
            scoreAttrString.addAttributes([NSAttributedStringKey.foregroundColor: FBColorType.red.color], range: NSMakeRange(loc, length))
        } else {
            awayLabel.textColor = UIColor.black
        }
        
        // 比分改变 改变背景
        if isScoreChanged {
            let v = UIView(frame: frame)
            v.backgroundColor = UIColor(hex: 0xffffdd)
            backgroundView = v
        } else {
            backgroundView = nil
        }
        
        stateLabel.textColor = match.stateType.color
        scoreLabel.textColor = match.stateType.color

        switch match.stateType {
        case .notStarted, .cancel, .delaye:
            scoreLabel.text = "VS"
        default:
            scoreLabel.attributedText = scoreAttrString
        }
    }

    @IBAction func liveButtonAction(_ sender: UIButton) {
        
        if let match = match {
            let ctrl = TSEntryViewControllerHelper.fbLiveAnimationViewController(matchId: match.id)
            ctrl.hidesBottomBarWhenPushed = true
            viewController?.navigationController?.pushViewController(ctrl, animated: true)
        }

    }

    
}
