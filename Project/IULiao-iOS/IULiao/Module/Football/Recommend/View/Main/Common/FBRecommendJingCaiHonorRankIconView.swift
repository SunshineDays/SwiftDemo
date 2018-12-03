//
//  RankIconView.swift
//  IULiao
//
//  Created by 李来伟 on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBRecommendJingCaiHonorRankIconView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        tipView.setCornerRadius(radius: tipView.height / 2, borderWidth: 0, backgroundColor: UIColor(r: 252, g: 63, b: 81), borderColor: UIColor.clear)
    }
    
    @IBOutlet weak var honorLogo: UIImageView!
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var hitprecedentLabel: UILabel!
    
    /// 盈利达人
    public var payoffPercentModel: FBRecommend2RankModel? {
        didSet {
            honorLogo.sd_setImage(with: URL(string: TSImageURLHelper(string: (payoffPercentModel?.user.avatar)!, size: CGSize(width: 80, height: 80)).chop().urlString)) {[weak self] (image, error, type, url) in
                if error == nil {
                    self?.honorLogo.setImageCorner(radius: 20)
                } else {
                    self?.honorLogo.image = R.image.fbRecommend.placeholdAvatar36x36()
                    self?.honorLogo.setImageCorner(radius: 20)
                }
            }
            tipView.isHidden = !(payoffPercentModel?.hasnewRecommend)!
            nicknameLabel.text = payoffPercentModel?.user.nickname
            hitprecedentLabel.text = String(format: "  盈利率:%.f%%  ", payoffPercentModel?.payoffPercent ?? 0)
        }
    }
    
    /// 命中高手
    public var hitpercentModel: FBRecommend2RankModel? {
        didSet {
            honorLogo.sd_setImage(with: URL(string: TSImageURLHelper(string: (hitpercentModel?.user.avatar)!, size: CGSize(width: 80, height: 80)).chop().urlString)) {[weak self] (image, error, type, url) in
                if error == nil {
                    self?.honorLogo.setImageCorner(radius: 20)
                } else {
                    self?.honorLogo.image = R.image.fbRecommend.placeholdAvatar36x36()
                    self?.honorLogo.setImageCorner(radius: 20)
                }
            }
            tipView.isHidden = !(hitpercentModel?.hasnewRecommend)!
            nicknameLabel.text = hitpercentModel?.user.nickname
            hitprecedentLabel.text = String(format: "  命中率:%.f%%  ", hitpercentModel?.hitPercent ?? 0)
        }
    }
    
    

}
