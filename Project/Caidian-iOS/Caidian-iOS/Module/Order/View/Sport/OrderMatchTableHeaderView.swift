//
//  OrderMatchTableHeaderView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 订单赛事头部
class OrderMatchTableHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftTeamName: UILabel!
    @IBOutlet weak var rightTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scoreLabelWidthConstraint: NSLayoutConstraint!
    
    static let defaultHeight: CGFloat = 25
    
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
        contentView = R.nib.orderMatchTableHeaderView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
}
