//
//  FBPlayerHeaderViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/15.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员 头部
class FBPlayerHeaderViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerLogoImageView: UIImageView!
    
    @IBOutlet weak var playerNameLabelXConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerLogoImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerLogoImageViewXContraint: NSLayoutConstraint!
    @IBOutlet weak var playerLogoImageViewWidthConstraint: NSLayoutConstraint!
    
    
    let maxHeight: CGFloat = 154
    let minHeight: CGFloat = 64

    override func viewDidLoad() {
        super.viewDidLoad()
        playerLogoImageView.setImageCorner(radius: 35)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}


extension FBPlayerHeaderViewController {
 
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func configView(player: FBPlayerModel) {
        playerNameLabel.text = player.name
        playerLogoImageView.setImageCorner(radius: 35)
        if let logo = TSImageURLHelper(string: player.logo, w: 80, h: 80).chop(mode: .alwayCrop).url {
            playerLogoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.teamLogo120x120(), completed: {
                _, _, _, _ in
                self.playerLogoImageView.setImageCorner(radius: 35)
            })
        }
    }
    
    func viewHeightChangeTo(height: CGFloat) {
        guard height >= minHeight && height <= maxHeight else {
            return
        }
        
        let rate = (height - minHeight) / (maxHeight - minHeight)
        let screenWidth = TSScreen.currentWidth
        
        let nameLabelMaxLeft = (screenWidth - playerNameLabel.width) / 2 - 110
        playerNameLabelXConstraint.constant = (1 - rate) * -nameLabelMaxLeft
        
        let logoImageViewMaxLeft = screenWidth / 2 - 80
        playerLogoImageViewXContraint.constant = (1 - rate) * -logoImageViewMaxLeft
        playerLogoImageViewTopConstraint.constant = (1 - rate) *  -46 + 6
        playerLogoImageViewWidthConstraint.constant = 70 - 34 * (1 - rate)
    }
}
