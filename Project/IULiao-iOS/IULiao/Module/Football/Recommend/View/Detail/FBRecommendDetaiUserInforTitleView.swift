//
//  FBRecommendDetaiUserInforTitleView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/4.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 个人信息头视图
class FBRecommendDetaiUserInforTitleView: UIView {
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var followButton: UIButton!

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var followsLabel: UILabel!
    
    @IBOutlet weak var shoveAndTrueLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var payoffPercentLabel: UILabel!
    @IBOutlet weak var keepWinLabel: UILabel!
    @IBOutlet weak var expertLabel: UILabel!
    @IBOutlet weak var expertLeagueLabel: UILabel!
    
    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        followButton.layer.cornerRadius = 4
        followButton.layer.borderColor = UIColor.white.cgColor
        followButton.layer.borderWidth = 1
        
        if #available(iOS 10.0, *) {
            
        }
        else {
            backButtonTopConstraint.constant = TSScreen.statusBarHeight
        }
        
    }
 
    @IBAction func backAction(_ sender: UIButton) {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func avatarAction(_ sender: UIButton) {
        let vc = FBRecommendExpertController()
        vc.hidesBottomBarWhenPushed = true
        switch model.oddsType {
        case .jingcai, .serial, .single:
            vc.initWith(userId: userModel.id, oddsType: .jingcai)
        default:
            vc.initWith(userId: userModel.id, oddsType: .football)
        }
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func followButtonAction(_ sender: UIButton) {
        
    }
    
    public func setupConfigView(model: FBRecommendDetailModel) {
        self.model = model
        self.userModel = model.user
    }
    
    private var model: FBRecommendDetailModel!
    
    private var userModel: FBRecommendDetailUserModel! = nil {
        didSet {
            if let url = TSImageURLHelper.init(string: userModel.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
                avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
            }
            else {
                avatarButton.setImage(R.image.fbRecommend2.avatar60x60(), for: .normal)
            }
            
            if userModel.isAttention == true {
                followButton.layer.borderColor = UIColor.clear.cgColor
                followButton.setTitle("已关注", for: .normal)
            }
            
            followButton.isHidden = userModel.id == UserToken.shared.userInfo?.id
            
            nicknameLabel.text = String(format: "%@", userModel.nickname)
            followsLabel.text = String(format: "粉丝：%d", userModel.follow)
            shoveAndTrueLabel.text = String(format: "推/中:%d/%d", userModel.orderCount, userModel.win + userModel.winHalf)
            percentLabel.text = String(format: "胜率:%.2f%%", userModel.hitPercent)
            payoffPercentLabel.text = String(format: "盈利率:%.2f%%", userModel.payoffPercent)
            keepWinLabel.text = String(format: "最长连红:%d", userModel.keepWin)
            expertLabel.text = String(format: "擅长玩法:%@", userModel.skilledOddsType.message)
            expertLeagueLabel.text = String(format: "擅长联赛:%@", userModel.skilledLeague)
        }
    }
    
}

