//
//  JclqHhTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩篮球 让分胜负
class JclqSfTableCell: UITableViewCell, JclqTableCellProtocol {

    @IBOutlet weak var sf_sp3Btn: UIButton!
    @IBOutlet weak var sf_sp0Btn: UIButton!
    
    @IBOutlet weak var sfOpenSingleImageView: UIImageView!
    
    @IBOutlet weak var sfNotOpenLabel: UILabel!
    
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    
    static let defaultHeight: CGFloat = 92 // 8 + 34 + 35 + 15
    
    private var matchModel: JclqMatchModel?
    
    public var moreBtnActionBlock: ((_ btn: UIButton) -> Void)?
    public var betBtnActionBlock: ((_ btn: UIButton, _ bet: JclqBetKeyType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sf_sp3Btn.titleLabel?.numberOfLines = 2
        sf_sp0Btn.titleLabel?.numberOfLines = 2
        sf_sp3Btn.titleLabel?.textAlignment = .center
        sf_sp0Btn.titleLabel?.textAlignment = .center
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
        sf_sp3Btn.setTitle("主胜\n\(match.sf_sp3.sp.decimal(2))", for: .normal)
        sf_sp0Btn.setTitle("主负\n\(match.sf_sp0.sp.decimal(2))", for: .normal)
        
        sf_sp3Btn.isSelected = betKeyList.contains { $0 == match.sf_sp3 }
        sf_sp0Btn.isSelected = betKeyList.contains { $0 == match.sf_sp0 }
        
    }

    /// 销售状态
    private func configSaleStatus(match: JclqMatchModel) {
        sfNotOpenLabel.isHidden = match.sfFixed
        
        // 单关
        sfOpenSingleImageView.isHidden = !match.sfSingle
    }
    
    @IBAction func sf_sp3BtnAction(_ sender: UIButton) {
        if let key = matchModel?.sf_sp3 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
    @IBAction func sf_sp0BtnAction(_ sender: UIButton) {
        if let key = matchModel?.sf_sp0 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    
}
