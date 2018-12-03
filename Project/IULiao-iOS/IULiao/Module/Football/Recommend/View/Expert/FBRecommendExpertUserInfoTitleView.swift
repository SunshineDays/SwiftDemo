//
//  FBRecommendExpertUserInfoTitleView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 专家页 个人信息头视图
class FBRecommendExpertUserInfoTitleView: UIView {

    @IBOutlet weak var backAction: UIButton!
    
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var keepWinLabel: UILabel!
    
    @IBOutlet weak var expertLabel: UILabel!
    
    @IBOutlet weak var expertLeagueLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var followLabel: UILabel!
    
    @IBAction func backAction(_ sender: UIButton) {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: 167 + TSScreen.statusBarHeight)
        if #available(iOS 10.0, *) {
            
        }
        else {
            backButtonTopConstraint.constant = TSScreen.statusBarHeight
        }
    }
    
    public var isAttention: Bool! = nil {
        didSet {
            if isAttention {
                followButton.layer.borderColor = UIColor.clear.cgColor
                followButton.setTitle("已关注", for: .normal)
            }
            else {
                followButton.setTitle("+关注", for: .normal)
                followButton.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    private var oddstype: RecommendDetailOddsType?
    
    public func setupConfigView(model: FBRecommendExpertUserModel, oddsType: RecommendDetailOddsType) {
        self.oddstype = oddsType
        if let url = TSImageURLHelper.init(string: model.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
            avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
        }
        else {
            avatarButton.setImage(R.image.fbRecommend2.avatar60x60(), for: .normal)
        }

        isAttention = model.isAttention
        followButton.isHidden = UserToken.shared.userInfo?.id == model.id

        nicknameLabel.text = String(format: "%@", model.nickname)
        
        followLabel.text = String(format: "粉丝：%d", model.follow)
        
        keepWinLabel.text = String(format: "最长连红:%d", model.keepWin)
        expertLabel.text = String(format: "擅长玩法:%@", model.skilledOddsType.message)
        expertLeagueLabel.text = String(format: "擅长联赛:%@", model.skilledLeague)
        initSegmentedControl()
    }
    
    private func initSegmentedControl() {
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0x333333),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0xFF974B),
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.sectionTitles = ["足球推荐", "竞彩推荐"]
        segmentedControl.selectedSegmentIndex = oddstype == .football ? 0 : 1
    }
    
}
