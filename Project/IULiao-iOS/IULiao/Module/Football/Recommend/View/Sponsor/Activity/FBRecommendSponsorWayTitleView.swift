//
//  FBRecommendSponsorWayTitleView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 发起推荐 推荐方式
class FBRecommendSponsorWayTitleView: UIView {

    @IBOutlet weak var qqLabel: UILabel!
    
    @IBOutlet weak var footballButton: UIButton!
    
    @IBOutlet weak var lotteryButton: UIButton!
    
    @IBAction func footballAction(_ sender: UIButton) {
        let vc = FBRecommendSponsorMatchController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func lotteryAction(_ sender: UIButton) {
        let vc = FBRecommendSponsorMatchJingcaiController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let height = (TSScreen.currentWidth - 35) / 2 * 200 / 173 + 40 + 55
        self.frame = CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: height)
    }
    
    public func setupConfigView(model: FBRecommendSponsorActivityModel) {
        qqLabel.text = "推荐QQ群：" + model.qq
    }
    
}
