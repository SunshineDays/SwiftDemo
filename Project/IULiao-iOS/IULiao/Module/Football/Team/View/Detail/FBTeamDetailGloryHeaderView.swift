//
//  FBTeamDetailGloryHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBTeamDetailGloryHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configView(glory: FBTeamDetailModel.Glory) {
        titleLabel.text = glory.name + "x\(glory.seasonList.count)" 
    }
}
