//
//  JczqLeagueInfoView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 联赛信息
class SLLeagueInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentView = R.nib.slLeagueInfoView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    public func configView(serial: String, leagueName: String, color: UIColor, date: String) {
        serialLabel.text = serial
        leagueNameLabel.text = leagueName
        leagueNameLabel.textColor = color
        dateLabel.text = date
    }
    
    public func configView(date: String, weekday: String, xid: String) {
        serialLabel.text = date
        leagueNameLabel.text = weekday
        dateLabel.text = xid
    }
}
