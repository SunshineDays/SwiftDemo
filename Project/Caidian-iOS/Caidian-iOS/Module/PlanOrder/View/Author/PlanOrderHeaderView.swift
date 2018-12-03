//
//  PlanOrderHeaderView.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/29.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 计划跟单 首页累计中奖统计View
class PlanOrderHeaderView: UIView  {
    //    @IBOutlet weak var planExplainLabel: UILabel!

    @IBOutlet weak var totalAwardLabel: UILabel!
    
    @IBOutlet weak var authorButton: UIButton!
    
    public var authorBlock: (() -> Void)?
    
    @IBAction func authorAction(_ sender: UIButton) {
        authorBlock?()
    }
    
    var uiViewController : UIViewController?
    
    var defaultHeight : CGFloat = 41
    override func awakeFromNib() {
        super.awakeFromNib()
//        planExplainLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newDetail)))
//        planExplainLabel.isUserInteractionEnabled = false
        self.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: defaultHeight)
    }
    
    func configView(uiViewController : UIViewController, planModel:PlanModel)  {
//        planExplainLabel.isUserInteractionEnabled = true
        self.uiViewController = uiViewController
        totalAwardLabel.text = planModel.totalBonus.moneyText(2)
//        planExplainLabel.text = "圣手计划说明"
        authorButton.setTitle(" " + planModel.author + "战绩", for: .normal)
    }
    
    
    /// 如何合理跟单
    @objc func newDetail() {
        let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: 60)
        ctrl.hidesBottomBarWhenPushed = true
        uiViewController?.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
}
