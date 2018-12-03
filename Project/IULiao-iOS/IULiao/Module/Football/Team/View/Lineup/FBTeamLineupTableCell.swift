//
//  FBTeamLineupTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/11/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队阵容cell
class FBTeamLineupTableCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.setImageCorner(radius: 20)
    }
    
    func configCell(player: FBPlayerModel) {
        logoImageView.setImageCorner(radius: 20)
        if let logo = TSImageURLHelper(string: player.logo).size(w: 80, h: 80).chop(mode: .fillCrop).url {
            logoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.teamLogo50x50(), completed: {
                _, _, _, _ in
                self.logoImageView.setImageCorner(radius: 20)
            })
        }
        
        playerNameLabel.text = player.name
        
        var number = "-"
        if let n = player.number {
            number = "\(n)"
        }
        var age = ""
        if let a = player.age {
            age = "\(a)岁"
        }
        let info = [number, player.nationality, age].joined(separator: "  ")
        infoLabel.text = info
        
    }
}
