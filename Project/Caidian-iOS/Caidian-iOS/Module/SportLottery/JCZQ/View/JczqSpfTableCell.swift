//
//  JczqSpfTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球 胜平负
class JczqSpfTableCell: UITableViewCell, JczqTableCellProtocol {
    
    @IBOutlet weak var spf_sp3Btn: UIButton!
    @IBOutlet weak var spf_sp1Btn: UIButton!
    @IBOutlet weak var spf_sp0Btn: UIButton!
    
    @IBOutlet weak var spfOpenSingleImageView: UIImageView!
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    
    @IBOutlet weak var statisticsView: JczpHistoryInfoView!
    @IBOutlet weak var showButton: UIButton!

    
    @IBAction func showAction(_ sender: UIButton) {
        showBlock?(sender)
    }
    public var showBlock: ((_ sender: UIButton) -> Void)?
    
    static let defaultHeight: CGFloat = 79 + 15
    
    private var matchModel: JczqMatchModel?
    public var betBtnActionBlock: ((_ btn: UIButton, _ bet: JczqBetKeyType) -> Void)?

    public func configCell(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        matchModel = match
        
        configSp(match: match, betKeyList: betKeyList)
        spfOpenSingleImageView.isHidden = !match.spfSingle
        
        let date = "\(Date(timeIntervalSince1970: match.saleEndTime).string(format: "HH:mm")) 截止"
        leagueView.configView(serial: match.serial, leagueName: match.leagueName, color: match.color, date: date)
        teamView.configFootballView(homeName: match.home, awayName: match.away)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showButton.setImage(R.image.lottery.show_down(), for: .normal)
        showButton.setImage(R.image.lottery.show_up(), for: .selected)
    }

    /// sp
    private func configSp(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        spf_sp3Btn.setTitle(match.spf_sp3.displayName, for: .normal)
        spf_sp1Btn.setTitle(match.spf_sp1.displayName, for: .normal)
        spf_sp0Btn.setTitle(match.spf_sp0.displayName, for: .normal)
        
        spf_sp3Btn.isSelected = betKeyList.contains { $0 == match.spf_sp3 }
        spf_sp1Btn.isSelected = betKeyList.contains { $0 == match.spf_sp1 }
        spf_sp0Btn.isSelected = betKeyList.contains { $0 == match.spf_sp0 }
    }
    
    @IBAction func spf_sp3BtnAction(_ sender: UIButton) {
        if let key = matchModel?.spf_sp3 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
    @IBAction func spf_sp1BtnAction(_ sender: UIButton) {
        if let key = matchModel?.spf_sp1 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
    @IBAction func spf_sp0BtnAction(_ sender: UIButton) {
        if let key = matchModel?.spf_sp0 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
}
