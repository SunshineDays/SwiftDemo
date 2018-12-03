//
//  IULiao
//
//  Created by tianshui on 2017/12/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 赛况 阵容 奇数 cell
class FBMatchAnalyzeLineupEvenTableCell: UITableViewCell {

    @IBOutlet var playerViews: [FBMatchAnalyzeLineupPlayerView]!
    
    var buttonClickBlock: ((_ button: UIButton, _ player: FBMatchAnalyzeLineupModel.Player?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(players: [FBMatchAnalyzeLineupModel.Player]) {
        playerViews.forEach { $0.isHidden = true }
        var showViews = [FBMatchAnalyzeLineupPlayerView]()
        if players.count == 1 {
            showViews.append(playerViews[2])
        } else if players.count == 3 {
            showViews.append(playerViews[1])
            showViews.append(playerViews[2])
            showViews.append(playerViews[3])
        } else if players.count == 5 {
            showViews = playerViews
        }
        
        for (index, v) in showViews.enumerated() {
            v.isHidden = false
            v.configView(player: players[index])
            v.buttonClickBlock = {
                [weak self] btn, player in
                self?.buttonClickBlock?(btn, player)
            }
        }
    }
}
