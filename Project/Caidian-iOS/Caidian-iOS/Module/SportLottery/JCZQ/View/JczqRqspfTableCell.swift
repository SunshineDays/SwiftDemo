//
//  JczqRqspfTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球 让球胜平负
class JczqRqspfTableCell: UITableViewCell, JczqTableCellProtocol {

    @IBOutlet weak var rqspf_sp3Btn: UIButton!
    @IBOutlet weak var rqspf_sp1Btn: UIButton!
    @IBOutlet weak var rqspf_sp0Btn: UIButton!
    
    @IBOutlet weak var otherLetBallLabel: UILabel!
    @IBOutlet weak var rqspfOpenSingleImageView: UIImageView!
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
        configSaleStatus(match: match)
        
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
        rqspf_sp3Btn.setTitle(match.rqspf_sp3.displayName, for: .normal)
        rqspf_sp1Btn.setTitle(match.rqspf_sp1.displayName, for: .normal)
        rqspf_sp0Btn.setTitle(match.rqspf_sp0.displayName, for: .normal)
        
        rqspf_sp3Btn.isSelected = betKeyList.contains { $0 == match.rqspf_sp3 }
        rqspf_sp1Btn.isSelected = betKeyList.contains { $0 == match.rqspf_sp1 }
        rqspf_sp0Btn.isSelected = betKeyList.contains { $0 == match.rqspf_sp0 }
    }
    
    /// 销售状态
    private func configSaleStatus(match: JczqMatchModel) {

        let letBall = Int(match.letBall)
        // 让球胜平负 固定过关
        if letBall > 0 {
            otherLetBallLabel.text = "+\(letBall)"
            otherLetBallLabel.backgroundColor = UIColor.letBall.gt0
        } else if letBall < 0 {
            otherLetBallLabel.text = "\(letBall)"
            otherLetBallLabel.backgroundColor = UIColor.letBall.lt0
        }
        
        // 单关
        rqspfOpenSingleImageView.isHidden = !match.rqspfSingle
    }
    
    @IBAction func rqspf_sp3BtnAction(_ sender: UIButton) {
        if let key = matchModel?.rqspf_sp3 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
    @IBAction func rqspf_sp1BtnAction(_ sender: UIButton) {
        if let key = matchModel?.rqspf_sp1 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
    @IBAction func rqspf_sp0BtnAction(_ sender: UIButton) {
        if let key = matchModel?.rqspf_sp0 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }

}
