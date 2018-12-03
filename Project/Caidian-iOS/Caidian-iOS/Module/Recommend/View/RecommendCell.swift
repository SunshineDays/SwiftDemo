//
//  RecommendCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐首页
class RecommendCell: UITableViewCell {
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var oreder5WinButton: UIButton!
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    @IBOutlet weak var lookNumberLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    static var defaultHeight: CGFloat = 140
    
    typealias RecommendCellBlock = (_ avatarButton: UIButton) -> Void
    
    private var avatarBlock: RecommendCellBlock?
    
    public func configCell(model: RecommendOrderListModel, avatarBlock: @escaping RecommendCellBlock) {
        self.avatarBlock = avatarBlock
        if let url = TSImageURLHelper(string: model.userInfo.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
            avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.empty.image100x100(), completed: nil)
        } else {
            avatarButton.setImage(R.image.empty.image100x100(), for: .normal)
        }
        
        nicknameLabel.text = model.userInfo.name
        let order5 = model.order.orderCount.string() + "中" + model.order.win.string()
        oreder5WinButton.setTitle(order5, for: .normal)
        updateTimeLabel.text = TSUtils.timestampToString(model.updateTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
        
        lookNumberLabel.text = model.hits.string()
        
        titleLabel.text = "【" + model.matchInfo.serial + "】" + model.title
        
        leagueLabel.text = model.matchInfo.leagueName
        leagueLabel.textColor = model.matchInfo.color
        matchTimeLabel.text = TSUtils.timestampToString(model.matchInfo.matchTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
        homeTeamLabel.text = model.matchInfo.home
        awayTeamLabel.text = model.matchInfo.away
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func avatarAction(_ sender: UIButton) {
        avatarBlock?(sender)
    }
    
}
