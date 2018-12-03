//
//  FBRecommendTodayNewsCell.swift
//  IULiao
//
//  Created by levine on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage

/// 推荐 今日推荐 按人找 UITableViewCell
class FBRecommendTodayNewsCell: UITableViewCell {

    @IBOutlet weak var userImageV: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var ordderHitPercentLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var lNameLabel: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var guessTypeLabel: UILabel!
    

    @IBOutlet weak var checkButton: UIButton!
    
    private var model: FBRecommend2TodayNewsFromUserModel?
    
    public func setupConfigView(model: FBRecommend2TodayNewsFromUserModel) {
        self.model = model
        userImageV.sd_setImage(with: URL(string: TSImageURLHelper(string: model.user.avatar, size: CGSize(width: 100, height: 100)).chop().urlString)) {[weak self] (image, error, type, url) in
            if error == nil {
                self?.userImageV.setImageCorner(radius: 23)
            } else {
                self?.userImageV.image = R.image.fbRecommend.placeholdAvatar60x60()
                self?.userImageV.setImageCorner(radius: 23)
            }
        }
        userImageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userImageTapAction)))
        
        nickNameLabel.text = model.user.nickName
        
        ordderHitPercentLabel.text = String(format: "%.2f%%", model.user.order10PayoffPercent)

        lNameLabel.text = model.match.lName
        lNameLabel.textColor = UIColor(rgba: model.match.color)
        teamLabel.text = model.match.home + " vs " + model.match.away
        
        guessTypeLabel.text = model.oddsType.message
        guessTypeLabel.textColor = model.oddsType.color
        
        timeLabel.text = TSUtils.timesAfterNowToString(TimeInterval(model.mTime), withFormat: "yyyy-MM-dd HH:mm:ss", isIntelligent: true)
        
        resultLabel.text = model.user.day7

    }

    @objc private func userImageTapAction(tap: UITapGestureRecognizer) {
        //专家页
        if let model = self.model {
            let vc = FBRecommendExpertController()
            vc.initWith(userId: model.userId, oddsType: .football)
            vc.hidesBottomBarWhenPushed = true
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
