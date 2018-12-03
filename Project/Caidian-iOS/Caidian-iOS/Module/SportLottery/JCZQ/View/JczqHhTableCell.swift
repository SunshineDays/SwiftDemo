//
//  JczqHhTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol JczqTableCellProtocol: class {
    var betBtnActionBlock: ((_ btn: UIButton, _ bet: JczqBetKeyType) -> Void)? { get set }
    func configCell(match: JczqMatchModel, betKeyList: [JczqBetKeyType])
    
    var showBlock: ((_ sender: UIButton) -> Void)? { get set }
    
    var statisticsView: JczpHistoryInfoView! { get set }
    
    var showButton: UIButton! { get set }
}

/// 竞彩足球混合
class JczqHhTableCell: UITableViewCell, JczqTableCellProtocol {

    @IBOutlet weak var spf_sp3Btn: UIButton!
    @IBOutlet weak var spf_sp1Btn: UIButton!
    @IBOutlet weak var spf_sp0Btn: UIButton!
    @IBOutlet weak var rqspf_sp3Btn: UIButton!
    @IBOutlet weak var rqspf_sp1Btn: UIButton!
    @IBOutlet weak var rqspf_sp0Btn: UIButton!
    
    @IBOutlet weak var zeroLetBallLabel: UILabel!
    @IBOutlet weak var otherLetBallLabel: UILabel!
    
    @IBOutlet weak var spfOpenSingleImageView: UIImageView!
    @IBOutlet weak var rqspfOpenSingleImageView: UIImageView!
    
    @IBOutlet weak var spfNotOpenLabel: UILabel!
    @IBOutlet weak var rqspfNotOpenLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    
    @IBOutlet weak var moreBtnRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var statisticsView: JczpHistoryInfoView!
    
    @IBAction func showAction(_ sender: UIButton) {
        showBlock?(sender)
    }
    public var showBlock: ((_ sender: UIButton) -> Void)?
    
    static var defaultHeight: CGFloat = 106 + 15
    
    private var matchModel: JczqMatchModel?
    
    public var moreBtnActionBlock: ((_ btn: UIButton) -> Void)?
    public var betBtnActionBlock: ((_ btn: UIButton, _ bet: JczqBetKeyType) -> Void)?
    
    public func configCell(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        matchModel = match
        
        configSp(match: match, betKeyList: betKeyList)
        configSaleStatus(match: match)
        configMoreBtn(betKeyList: betKeyList)

        leagueView.configView(serial: match.serial, leagueName: match.leagueName, color: match.color, date: "\(match.saleEndTimeString) 截止")
        teamView.configFootballView(homeName: match.home, awayName: match.away)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showButton.setImage(R.image.lottery.show_down(), for: .normal)
        showButton.setImage(R.image.lottery.show_up(), for: .selected)
    }
    
    /// more btn
    private func configMoreBtn(betKeyList: [JczqBetKeyType]) {
        moreBtn.isSelected = !betKeyList.isEmpty
        if betKeyList.isEmpty {
            moreBtn.setTitle("展\n\n开", for: .normal)
        } else if betKeyList.count < 10 {
            // 小于10用全角
            let countStr = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"][betKeyList.count]
            moreBtn.setTitle("已\n选\n\(countStr)\n项", for: .normal)
        } else {
            moreBtn.setTitle("已\n选\n\(betKeyList.count)\n项", for: .normal)
        }
    }

    /// sp
    private func configSp(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        spf_sp3Btn.setTitle(match.spf_sp3.displayName, for: .normal)
        spf_sp1Btn.setTitle(match.spf_sp1.displayName, for: .normal)
        spf_sp0Btn.setTitle(match.spf_sp0.displayName, for: .normal)
        rqspf_sp3Btn.setTitle(match.rqspf_sp3.displayName, for: .normal)
        rqspf_sp1Btn.setTitle(match.rqspf_sp1.displayName, for: .normal)
        rqspf_sp0Btn.setTitle(match.rqspf_sp0.displayName, for: .normal)
        
        spf_sp3Btn.isSelected = betKeyList.contains { $0 == match.spf_sp3 }
        spf_sp1Btn.isSelected = betKeyList.contains { $0 == match.spf_sp1 }
        spf_sp0Btn.isSelected = betKeyList.contains { $0 == match.spf_sp0 }
        rqspf_sp3Btn.isSelected = betKeyList.contains { $0 == match.rqspf_sp3 }
        rqspf_sp1Btn.isSelected = betKeyList.contains { $0 == match.rqspf_sp1 }
        rqspf_sp0Btn.isSelected = betKeyList.contains { $0 == match.rqspf_sp0 }
        
    }

    /// 销售状态
    private func configSaleStatus(match: JczqMatchModel) {
        spfNotOpenLabel.isHidden = match.spfFixed
        rqspfNotOpenLabel.isHidden = match.rqspfFixed
        
        // 胜平负 固定过关
        if match.spfFixed {
            zeroLetBallLabel.text = "0"
        } else {
            zeroLetBallLabel.text = "-"
        }

        let letBall = Int(match.letBall)
        // 让球胜平负 固定过关
        if match.rqspfFixed {
            if letBall > 0 {
                otherLetBallLabel.text = "+\(letBall)"
                otherLetBallLabel.backgroundColor = UIColor.letBall.gt0
            } else if letBall < 0 {
                otherLetBallLabel.text = "\(letBall)"
                otherLetBallLabel.backgroundColor = UIColor.letBall.lt0
            }
        } else {
            otherLetBallLabel.text = "-"
            otherLetBallLabel.backgroundColor = UIColor.letBall.zero
        }
        
        // 单关
        spfOpenSingleImageView.isHidden = !match.spfSingle
        rqspfOpenSingleImageView.isHidden = !match.rqspfSingle
    }
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        moreBtnActionBlock?(sender)
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
