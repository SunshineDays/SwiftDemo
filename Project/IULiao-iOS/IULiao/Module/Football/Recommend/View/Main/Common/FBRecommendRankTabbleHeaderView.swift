//
//  RankTabHeaderView.swift
//  IULiao
//
//  Created by 李来伟 on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol FBRecommendRankTabbleHeaderViewDelegate:class {
    func rankTabHeaderView(_ rankTabHeaderView:FBRecommendRankTabbleHeaderView,didClickIcon index:Int?)
}

/// 推荐 盈利达人
class FBRecommendRankTabbleHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userButton.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        userButton.setTitleColor(UIColor(hex: 0xFF4444), for: .selected)
        matchButton.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        matchButton.setTitleColor(UIColor(hex: 0xFF4444), for: .selected)
    }
    
    ///  盈利达人
    var payoffPercentModels: [FBRecommend2RankModel]? {
        didSet {
            if let models = payoffPercentModels {
                // 性能问题  代码不写 引起重复添加 造成内存持续上升
                for subView in self.subviews {
                    if subView.isKind(of: FBRecommendJingCaiHonorRankIconView.classForCoder()) {
                        subView.removeFromSuperview()
                    }
                }
                for i in 0 ..< 8 {
                    let index = i % 4
                    let page = i / 4
                    let iconView  = Bundle.main.loadNibNamed("FBRecommendJingCaiHonorRankIconView", owner: nil, options: nil)?.last as! FBRecommendJingCaiHonorRankIconView
                    iconView.tag = i
                    
                    iconView.frame = CGRect(x: CGFloat(index)*(iconView_Width + Width_Space) + Start_X, y: CGFloat(page)*(iconView_Height + Height_Space) + Start_Y, width: iconView_Width, height: 100)
                    if models.count > i {
                        iconView.payoffPercentModel = models[i]
                    }
                    iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iconViewAction)))
                    addSubview(iconView)
                }
            }
        }
    }
    
    /// 命中高手
    var hitPercentModels: [FBRecommend2RankModel]? {
        didSet {
            viewTopConstraint.constant = 110
            rankTitleLabel.text = "命中高手"
            titleLabel.text = "今日2串1方案推荐"
            linView.isHidden = true
            userButton.isHidden = true
            matchButton.isHidden = true
            
            if let hitPercentModels = hitPercentModels {
                // 性能问题  代码不写 引起重复添加 造成内存持续上升
                for subView in self.subviews {
                    
                    if subView.isKind(of: FBRecommendJingCaiHonorRankIconView.classForCoder()) {
                        subView.removeFromSuperview()
                    }
                }
                for i in 0 ..< 4 {
                    let index = i % 4
                    let page = i / 4
                    let iconView  = Bundle.main.loadNibNamed("FBRecommendJingCaiHonorRankIconView", owner: nil, options: nil)?.last as! FBRecommendJingCaiHonorRankIconView
                    iconView.tag = i
                    
                    iconView.frame = CGRect(x: CGFloat(index)*(iconView_Width + Width_Space) + Start_X, y: CGFloat(page)*(iconView_Height + Height_Space) + Start_Y, width: iconView_Width, height: 100)
                    if hitPercentModels.count > i {
                        iconView.hitpercentModel = hitPercentModels[i]
                    }
                    iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iconViewAction)))
                    addSubview(iconView)
                }
            }
        }
    }
    
    
    @IBOutlet weak var userButton: UIButton!
    
    @IBOutlet weak var matchButton: UIButton!
    
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var linView: UIView!
    
    @IBOutlet weak var rankTitleLabel: UILabel!
    
    weak var delegate : FBRecommendRankTabbleHeaderViewDelegate?
    private let Start_X  : CGFloat = 10.0
    private let Start_Y : CGFloat = 40.0
    private let Width_Space : CGFloat = 10.0
    private let Height_Space : CGFloat = 0.0
    private let iconView_Width : CGFloat = (TSScreen.currentWidth - 10 * 5) / 4
    private let iconView_Height : CGFloat = 100.0

    @IBAction func moreButton(_ sender: UIButton) {
        let ctrl = FBRecommendRankBaseViewController()
        ctrl.initWith(title: payoffPercentModels != nil ? .football : .jingcai)
        ctrl.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(ctrl, animated: true)
    }
    @objc func iconViewAction(tap:UITapGestureRecognizer){
        delegate?.rankTabHeaderView(self, didClickIcon: tap.view?.tag)
    }
    
    
    var userIsSelected: Bool = true {
        didSet {
            userButton.isSelected = userIsSelected
            matchButton.isSelected = !userIsSelected
        }
    }
    
    var findWayType: TodayNewsFindWayType = .user {
        didSet {
            userButton.isSelected = findWayType == .user
            matchButton.isSelected = findWayType == .match
        }
    }

    
}
