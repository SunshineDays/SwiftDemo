//
//  UserAttentionAnalystCell.swift
//  IULiao
//
//  Created by levine on 2017/9/2.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
protocol UserAttentionAnalystCellDelegate: class {
    func userAttentionAnalystCell(_ userAttentionAnalystCell: UserAttentionAnalystCell,didClickFollow followBtn: UIButton, currentRow row: Int)
}

class UserAttentionAnalystCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nickNameLabel: UILabel!

    @IBOutlet weak var payoffLabel: UILabel!

    @IBOutlet weak var hitPercentLabel: UILabel!

    @IBOutlet weak var fansLabel: UILabel!

    @IBOutlet weak var dayLabel: UILabel!

    @IBOutlet weak var hitCountLabel: UILabel!

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var hasNewsLabel: UILabel!
    
    var unAttentionType: ((_ button: UIButton, _ userId: Int) -> ())?
    
    // 代理
    weak var delegate: UserAttentionAnalystCellDelegate?
    private var recommendAttentionHandler = CommonAttentionHandler()//关注 handler
    override func awakeFromNib() {
        super.awakeFromNib()
        hasNewsLabel.setCornerRadius(radius: 2.5, borderWidth: 0, backgroundColor: UIColor(r: 255, g: 0, b: 0), borderColor: UIColor.clear)
        // Initialization code
    }
    @IBAction func followButtonAction(_ sender: UIButton) {
        if UserToken.shared.userInfo?.id == expertModel?.userId {
            TSToast.hudTextLoad(view: self, text: "不能关注自己哦", mode: .text, margin: 10, duration: 3)
            return
        }
        //delegate?.userAttentionAnalystCell(self, didClickFollow: sender, currentRow: indexPath.row)
        else {
            unAttentionType?(sender , (expertModel?.userId)!)
        }
    }

    var indexPath: IndexPath!
    var expertModel: FBRecommendRankModel? {
        didSet {
            if let expertModel = expertModel {
                avatarImageView.sd_setImage(with: URL(string: TSImageURLHelper(string: expertModel.user.avatar, size: CGSize(width: 80, height: 80)).chop().urlString), completed: { [weak self] (image, error, type, url) in
                    if error == nil {
                        self?.avatarImageView.setImageCorner(radius: 19)
                    }else {
                        self?.avatarImageView.image = R.image.fbRecommend.placeholdAvatar36x36()
                        self?.avatarImageView.setImageCorner(radius: 19)
                    }
                })
                nickNameLabel.text = expertModel.user.nickName
                hitPercentLabel.text = String(format: "%.2f", expertModel.payoffpercent) + "%"
                fansLabel.text = "粉丝：" + "\(expertModel.follow)"
                hitCountLabel.text = expertModel.order10

                followButton.isSelected = expertModel.isAttention
                followButton.layer.borderWidth = expertModel.isAttention ? 0 : 1
                hasNewsLabel.isHidden = !expertModel.hasNewRecommend
            }
        }
    }

}

