//
//  JclqHhTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩篮球 让分胜负
class JclqRfsfTableCell: UITableViewCell, JclqTableCellProtocol {

    @IBOutlet weak var rfsf_sp3Btn: UIButton!
    @IBOutlet weak var rfsf_sp0Btn: UIButton!
    
    @IBOutlet weak var rfsfOpenSingleImageView: UIImageView!
    
    @IBOutlet weak var rfsfNotOpenLabel: UILabel!
    
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    
    static let defaultHeight: CGFloat = 92 // 8 + 34 + 35 + 15
    
    private var matchModel: JclqMatchModel?
    
    public var moreBtnActionBlock: ((_ btn: UIButton) -> Void)?
    public var betBtnActionBlock: ((_ btn: UIButton, _ bet: JclqBetKeyType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        rfsf_sp3Btn.titleLabel?.numberOfLines = 2
        rfsf_sp0Btn.titleLabel?.numberOfLines = 2
        rfsf_sp3Btn.titleLabel?.textAlignment = .center
        rfsf_sp0Btn.titleLabel?.textAlignment = .center
    }
    
    public func configCell(match: JclqMatchModel, betKeyList: [JclqBetKeyType]) {
        matchModel = match
        
        configSp(match: match, betKeyList: betKeyList)
        configSaleStatus(match: match)

        leagueView.configView(serial: match.serial, leagueName: match.leagueName, color: match.color, date: "\(match.saleEndTimeString) 截止")
        teamView.configBasketballView(homeName: match.home, awayName: match.away)
    }
    
    /// sp
    private func configSp(match: JclqMatchModel, betKeyList: [JclqBetKeyType]) {
        
        let attr = NSMutableAttributedString()
        let letBall = match.letBall > 0 ? "+\(match.letBall)" : "\(match.letBall)"
        let sp3 = match.rfsf_sp3.sp.decimal(2)
        attr.append(NSAttributedString(string: "主胜"))
        attr.append(NSAttributedString(string: "(\(letBall))\n", attributes: [.foregroundColor: match.letBall > 0 ? UIColor.letBall.gt0 : UIColor.letBall.lt0]))
        attr.append(NSAttributedString(string: sp3))
        rfsf_sp3Btn.setAttributedTitle(attr, for: .normal)
        let selectedAttr = NSAttributedString(string: "主胜(\(letBall))\n\(sp3)", attributes: [.foregroundColor: UIColor.white])
        rfsf_sp3Btn.setAttributedTitle(selectedAttr, for: .highlighted)
        rfsf_sp3Btn.setAttributedTitle(selectedAttr, for: .selected)
        
        rfsf_sp0Btn.setTitle("主负\n\(match.rfsf_sp0.sp.decimal(2))", for: .normal)
        
        rfsf_sp3Btn.isSelected = betKeyList.contains { $0 == match.rfsf_sp3 }
        rfsf_sp0Btn.isSelected = betKeyList.contains { $0 == match.rfsf_sp0 }
        
    }

    /// 销售状态
    private func configSaleStatus(match: JclqMatchModel) {
        rfsfNotOpenLabel.isHidden = match.rfsfFixed
        
        // 单关
        rfsfOpenSingleImageView.isHidden = !match.rfsfSingle
    }
    
    @IBAction func rfsf_sp3BtnAction(_ sender: UIButton) {
        if let key = matchModel?.rfsf_sp3 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
    @IBAction func rfsf_sp0BtnAction(_ sender: UIButton) {
        if let key = matchModel?.rfsf_sp0 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
}
