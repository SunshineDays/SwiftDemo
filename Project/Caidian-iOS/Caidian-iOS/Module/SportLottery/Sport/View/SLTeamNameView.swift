//
//  JczqTeamNameView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 球队信息
class SLTeamNameView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftTeamLabel: UILabel!
    @IBOutlet weak var rightTeamLabel: UILabel!
    
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
        contentView = R.nib.slTeamNameView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    /// 配置 足球view
    ///
    /// - Parameters:
    ///   - homeName: 主队名
    ///   - awayName: 客队名
    ///   - letBall: 让球 不为0 时会加入左边名中
    public func configFootballView(homeName: String, awayName: String, letBall: Int = 0) {
        if letBall == 0 {
            leftTeamLabel.text = homeName
        } else {
            let attr = NSMutableAttributedString()
            let color = letBall > 0 ? UIColor.letBall.gt0 : UIColor.letBall.lt0
            let str = letBall > 0 ? "+\(letBall)" : "\(letBall)"
            attr.append(NSAttributedString(string: "\(homeName)"))
            attr.append(NSAttributedString(string: "(\(str))", attributes: [.foregroundColor: color]))
            
            leftTeamLabel.attributedText = attr
        }
        rightTeamLabel.text = awayName
    }
    
    /// 配置 篮球view
    ///
    /// - Parameters:
    ///   - homeName: 主队名
    ///   - awayName: 客队名
    ///   - letScore: 让分 不为0 时会加入右边名中
    public func configBasketballView(homeName: String, awayName: String, letScore: Double = 0) {
        if letScore == 0 {
            rightTeamLabel.text = homeName
        } else {
            let attr = NSMutableAttributedString()
            let color = letScore > 0 ? UIColor.letBall.gt0 : UIColor.letBall.lt0
            let str = letScore > 0 ? "+\(letScore)" : "\(letScore)"
            attr.append(NSAttributedString(string: "\(homeName)"))
            attr.append(NSAttributedString(string: "(\(str))", attributes: [.foregroundColor: color]))
            
            rightTeamLabel.attributedText = attr
        }
        leftTeamLabel.text = awayName
    }
}
