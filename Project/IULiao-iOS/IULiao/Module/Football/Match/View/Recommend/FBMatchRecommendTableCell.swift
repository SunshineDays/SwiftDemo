//
//  FBMatchRecommendTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBMatchRecommendTableCell: UITableViewCell {

    @IBOutlet weak var boxView: UIView!
    
    @IBOutlet weak var avatarImagView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var day7PayoffPercentLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var playNameLabel: UILabel!
    @IBOutlet weak var keepWinLabel: UILabel!
    @IBOutlet weak var order10Label: UILabel!
    
    @IBOutlet weak var jingcaiView: UIView!
    @IBOutlet weak var asiaView: UIView!
    @IBOutlet weak var keepWinView: UIView!
    @IBOutlet weak var lookView: UIView!
    
    @IBOutlet weak var jingcaiNormalLabel: UILabel!
    @IBOutlet weak var jiangcaiLetballLabel: UILabel!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var lostButton: UIButton!
    @IBOutlet weak var letWinButton: UIButton!
    @IBOutlet weak var letDrawButton: UIButton!
    @IBOutlet weak var letLostButton: UIButton!
    
    @IBOutlet weak var aboveButton: UIButton!
    @IBOutlet weak var handicapButton: UIButton!
    @IBOutlet weak var belowButton: UIButton!
    
    @IBOutlet weak var playNameLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keepWinLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultImageViewRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var letBallLabel: UILabel!
    
    var userAvatarClickBlock: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        
        aboveButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        aboveButton.setTitleColor(UIColor.white, for: .selected)
        aboveButton.setBackgroundColor(UIColor(hex: 0xF2F2F2), forState: .normal)
        aboveButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        
        handicapButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        handicapButton.setTitleColor(UIColor.white, for: .selected)
        handicapButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        
        belowButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        belowButton.setTitleColor(UIColor.white, for: .selected)
        belowButton.setBackgroundColor(UIColor(hex: 0xF2F2F2), forState: .normal)
        belowButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        
        
        
        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            playNameLabelRightConstraint.constant = -6
            keepWinLabelLeftConstraint.constant = 10
            resultImageViewRightConstraint.constant = -4
        }
        
        avatarImagView.setImageCorner(radius: avatarImagView.height / 2)
        avatarImagView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userAvatarClick)))
        nicknameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userAvatarClick)))
    }
    
    func configCell(recommend: FBMatchRecommendModel) {
        let (recommend, user) = (recommend.recommend, recommend.user)
        
        if let avatar = TSImageURLHelper(string: user.avatar, w: 80, h: 80).chop(mode: .alwayCrop).url {
            avatarImagView.sd_setImage(with: avatar, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: {
                _, _, _, _ in
                self.avatarImagView.setImageCorner(radius: self.avatarImagView.height / 2)
            })
        } else {
            avatarImagView.image = R.image.fbRecommend2.avatar60x60()
        }
        avatarImagView.setImageCorner(radius: avatarImagView.height / 2)
        
        nicknameLabel.text = user.nickname
        day7PayoffPercentLabel.text = user.day7PayoffPercent.decimal(2) + "%"
        createTimeLabel.text = TSUtils.timestampToString(recommend.createTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
        resultImageView.image = recommend.result.image
        
        createTimeLabel.isHidden = recommend.result != .none
        resultImageView.isHidden = recommend.result == .none
        
//        lookView.isHidden = recommend.reason.isEmpty
//        keepWinView.isHidden = !recommend.reason.isEmpty
        
        lookView.isHidden = true
        
        letBallLabel.text = recommend.betOdds.letBall > 0 ? String(format: "+%d", recommend.betOdds.letBall) : (recommend.betOdds.letBall < 0 ? String(format: "%d", recommend.betOdds.letBall) : "")
        letBallLabel.textColor = recommend.betOdds.letBall > 0 ? UIColor(hex: 0xFF3333) : UIColor(hex: 0x009933)

        keepWinLabel.text = "\(user.keepWin)连红"
        order10Label.text = "\(user.order10)"
        
        let playType = recommend.playType
        playNameLabel.text = "\(playType.name ?? ""):"
        playNameLabel.textColor = playType.color
        
        if playType == .jingcai {
            // 竞彩
            jingcaiView.isHidden = false
            asiaView.isHidden = true
            
            configJingcai(recommend: recommend)
        } else {
            jingcaiView.isHidden = true
            asiaView.isHidden = false
            
            if playType == .asia {
                configAsia(recommend: recommend)
            } else if playType == .bigSmall {
                configBigSmall(recommend: recommend)
            }
            else if playType == .europe {
                configEurope(recommend: recommend)
            }
        }
    }
    
    /// 竞彩
    private func configJingcai(recommend: FBRecommendModel2) {
        
        jingcaiNormalLabel.text = "-"
        jiangcaiLetballLabel.text = "-"
        winButton.setTitle("-", for: .normal)
        drawButton.setTitle("-", for: .normal)
        lostButton.setTitle("-", for: .normal)
        letWinButton.setTitle("-", for: .normal)
        letDrawButton.setTitle("-", for: .normal)
        letLostButton.setTitle("-", for: .normal)
        
        winButton.isSelected = false
        drawButton.isSelected = false
        lostButton.isSelected = false
        letWinButton.isSelected = false
        letDrawButton.isSelected = false
        letLostButton.isSelected = false
        
        let betOdds = recommend.betOdds
        let openSale = betOdds.openSale
        let betOnList = recommend.betOnList
        
        if openSale == .all || openSale == .normal {
            // 非让球
            jingcaiNormalLabel.text = "0"
            winButton.setTitle("胜 \(betOdds.jingcaiNormal.win.decimal(2))", for: .normal)
            drawButton.setTitle("平 \(betOdds.jingcaiNormal.draw.decimal(2))", for: .normal)
            lostButton.setTitle("负 \(betOdds.jingcaiNormal.lost.decimal(2))", for: .normal)
            
            winButton.isSelected = betOnList.contains(where: { $0.betKey == .win })
            drawButton.isSelected = betOnList.contains(where: { $0.betKey == .draw })
            lostButton.isSelected = betOnList.contains(where: { $0.betKey == .lost })
            
        }
        if openSale == .all || openSale == .letBall {
            // 让球
            jiangcaiLetballLabel.text = "\(betOdds.letBall)"
            if betOdds.letBall > 0 {
                jiangcaiLetballLabel.textColor = TSColor.matchResult.win
            } else if betOdds.letBall < 0 {
                jiangcaiLetballLabel.textColor = TSColor.matchResult.draw
            } else {
                jiangcaiLetballLabel.textColor = TSColor.gray.gamut333333
            }
            letWinButton.setTitle("让胜 \(betOdds.jingcaiLetball.win.decimal(2))", for: .normal)
            letDrawButton.setTitle("让平 \(betOdds.jingcaiLetball.draw.decimal(2))", for: .normal)
            letLostButton.setTitle("让负 \(betOdds.jingcaiLetball.lost.decimal(2))", for: .normal)
            
            letWinButton.isSelected = betOnList.contains(where: { $0.betKey == .letWin })
            letDrawButton.isSelected = betOnList.contains(where: { $0.betKey == .letDraw })
            letLostButton.isSelected = betOnList.contains(where: { $0.betKey == .letLost })
        }
    }
    
    
    /// 亚盘
    private func configAsia(recommend: FBRecommendModel2) {
        handicapButton.setBackgroundColor(UIColor.clear, forState: .normal)
        let betOdds = recommend.betOdds
        let betOnList = recommend.betOnList
        let asia = betOdds.asia
        
        aboveButton.setTitle("主 \(asia.above.decimal(2))", for: .normal)
        handicapButton.setTitle("\(asia.handicap)", for: .normal)
        belowButton.setTitle("客 \(asia.below.decimal(2))", for: .normal)
        
        aboveButton.isSelected = betOnList.contains(where: { $0.betKey == .above })
        handicapButton.isSelected = betOnList.contains(where: { $0.betKey == .handicap })
        belowButton.isSelected = betOnList.contains(where: { $0.betKey == .below })
    }
    
    /// 大小
    private func configBigSmall(recommend: FBRecommendModel2) {
        handicapButton.setBackgroundColor(UIColor.clear, forState: .normal)
        let betOdds = recommend.betOdds
        let betOnList = recommend.betOnList
        let bigSmall = betOdds.bigSmall
        
        aboveButton.setTitle("大球 \(bigSmall.big.decimal(2))", for: .normal)
        handicapButton.setTitle("\(bigSmall.handicap)", for: .normal)
        belowButton.setTitle("小球 \(bigSmall.small.decimal(2))", for: .normal)
        
        aboveButton.isSelected = betOnList.contains(where: { $0.betKey == .big })
        handicapButton.isSelected = betOnList.contains(where: { $0.betKey == .handicap })
        belowButton.isSelected = betOnList.contains(where: { $0.betKey == .small })
    }
    /// 欧赔
    private func configEurope(recommend: FBRecommendModel2) {
        handicapButton.setBackgroundColor(UIColor(hex: 0xF2F2F2), forState: .normal)

        let betOdds = recommend.betOdds
        let betOnList = recommend.betOnList
        let europe = betOdds.europe
        
        aboveButton.setTitle("胜 \(europe.win.decimal(2))", for: .normal)
        handicapButton.setTitle("平 \(europe.draw.decimal(2))", for: .normal)
        belowButton.setTitle("负 \(europe.lost.decimal(2))", for: .normal)
        
        aboveButton.isSelected = betOnList.contains(where: { $0.betKey == .win })
        handicapButton.isSelected = betOnList.contains(where: { $0.betKey == .draw })
        belowButton.isSelected = betOnList.contains(where: { $0.betKey == .lost })
    }
    
    @objc private func userAvatarClick() {
        userAvatarClickBlock?()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            boxView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.boxView.backgroundColor = UIColor.white
            },
                completion: nil
            )
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            boxView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            boxView.backgroundColor = UIColor.white
        }
    }
    
}
