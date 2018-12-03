//
//  SLTableHeaderView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import Rswift

/// 竞技选择 节头
class SLChooseTableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var contentBoxView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var shoppingImageView: UIImageView!
    @IBOutlet weak var shoppingLabel: UILabel!
    var contentViewClickBlock: (() -> Void)?
    
    func configView<MatchType: SLMatchModelProtocol>(group: SLDataModel<MatchType>.MatchGroup) {
        
        if group.day == "购物车" {
            shoppingLabel.text = "已选赛事"
            shoppingLabel.isHidden = false
            shoppingImageView.isHidden = false
            titleLabel.isHidden = true
            lineView.isHidden = true
            
        }else{
            shoppingLabel.isHidden = true
            shoppingImageView.isHidden = true
            lineView.isHidden = false
            titleLabel.isHidden = false
            
            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "\(group.day)  ", attributes: [:]))
            attrStr.append(NSAttributedString(string: "\(group.weekday)  ", attributes: [:]))
            attrStr.append(NSAttributedString(string: "\(group.matchList.count)", attributes: [.foregroundColor: UIColor.logo]))
            attrStr.append(NSAttributedString(string: "场可投", attributes: [:]))
            titleLabel.attributedText = attrStr
            arrowImageView.image = group.isExpand ? R.image.bet.serialArrowDown() : R.image.bet.serialArrowUp()
        }
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViewFromNib()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentBoxView = R.nib.slChooseTableHeaderView().instantiate(withOwner: self, options: nil).first as! UIView
        contentBoxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentBoxView)
        contentBoxView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
        contentBoxView.isUserInteractionEnabled = true
        contentBoxView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contentViewAction)))
    }
    
    @objc private func contentViewAction() {
        contentViewClickBlock?()
    }

}
