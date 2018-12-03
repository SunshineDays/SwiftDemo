//
//  FBRecommendRankCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 排行榜 UITableViewCell
class FBRecommendRankCell: UITableViewCell {

    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var rankingImageView: UIImageView!
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var payoffPercentLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var isAttentionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avaterImageView.layer.cornerRadius = avaterImageView.width / 2
        avaterImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configView(model: FBRecommend2RankModel, index: Int, rankType: RecommendRankType) {
        rankingLabel.text = String(format: "%d", index + 1)
        if index < 3 {
            let array = [R.image.fbRecommend.rankFrist(), R.image.fbRecommend.rankSecond(), R.image.fbRecommend.rankThird()]
            rankingImageView.image = array[index]
            rankingImageView.isHidden = false
            rankingLabel.textColor = UIColor.white
            if rankType == .keepLost {
                nicknameLabel.textColor = UIColor(hex: 0x333333)
                payoffPercentLabel.textColor = UIColor(hex: 0x333333)
                resultLabel.textColor = UIColor(hex: 0x333333)
            }
            else {
                nicknameLabel.textColor = UIColor(hex: 0xFF4444)
                payoffPercentLabel.textColor = UIColor(hex: 0xFF4444)
                resultLabel.textColor = UIColor(hex: 0xFF4444)
            }
        }
        else {
            rankingImageView.isHidden = true
            rankingLabel.textColor = UIColor(hex: 0x999999)
            nicknameLabel.textColor = UIColor(hex: 0x999999)
            payoffPercentLabel.textColor = UIColor(hex: 0x999999)
            resultLabel.textColor = UIColor(hex: 0x999999)
        }
        
        if let url = TSImageURLHelper.init(string: model.user.avatar, w: 60, h: 60).chop(mode: .fillCrop).url {
            avaterImageView.sd_setImage(with: url, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
        }
        else {
            avaterImageView.image = R.image.fbRecommend2.avatar60x60()
        }
        nicknameLabel.text = model.user.nickname
        
        switch rankType {
        case .keepWin:
            payoffPercentLabel.text = String(format: "%d连红", model.keepWin)
        case .payoff:
            payoffPercentLabel.text = String(format: "%.2f%%", model.payoffPercent)
        case .hitPercent:
            payoffPercentLabel.text = String(format: "%.2f%%", model.hitPercent)
        case .keepLost:
            payoffPercentLabel.text = String(format: "%d连黑", model.keepLost)
        default:
            break
        }
        
        
        resultLabel.text = String(format: "%d/%d/%d", model.win + model.winHalf, model.draw, model.lost + model.lostHalf)

        
        
        isAttentionButton.setImage(model.isAttention ? R.image.fbRecommend2.attentionS() : R.image.fbRecommend2.attention(), for: .normal)
    }
    
}

