//
//  FBPlayerDetailTransferView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员 转会金额
class FBPlayerDetailTransferView: UIView {
    
    @IBOutlet weak var currentMoneyLabel: UILabel!
    @IBOutlet weak var maxMoneyLabel: UILabel!
    
    @IBOutlet weak var teamLogoView: UIView!
    @IBOutlet weak var transferChartView: FBPlayerDetailTransferChartView!

    func configView(detail: FBPlayerDetailModel) {
        let transfers = detail.transferList
        let maxMoney = transfers.map({ $0.money }).max() ?? 0
        currentMoneyLabel.text = "\(detail.clubInfo.estimatedValue)万英镑"
        maxMoneyLabel.text = "\(maxMoney)万英镑"
        
        draw(logoList: detail.transferList)
        transferChartView.configView(transferList: detail.transferList, currentMoney: detail.clubInfo.estimatedValue)
    }
    
    private func draw(logoList: [FBPlayerDetailModel.Transfer]) {
        guard let minTime = logoList.first?.beginDate?.timeIntervalSince1970 else {
            return
        }
        let maxTime = Foundation.Date().timeIntervalSince1970
        let boxWidth = teamLogoView.width
        let logoWidth: CGFloat = 30
        
        for (index, transfer) in logoList.enumerated() {
            var x: CGFloat = -logoWidth / 2
            if index != 0 {
                let time = transfer.beginDate?.timeIntervalSince1970 ?? minTime
                x = boxWidth * CGFloat((time - minTime) / (maxTime - minTime)) - logoWidth / 2
            }
            let imageView = UIImageView(frame: CGRect(x: x, y: 0, width: logoWidth, height: logoWidth))
            imageView.image = R.image.empty.teamLogo50x50()
            imageView.contentMode = .scaleAspectFit
            if let logo = TSImageURLHelper(string: transfer.inTeam.logo, w: 60, h: 60).chop(mode: .fillCrop).url {
                imageView.sd_setImage(with: logo, placeholderImage: R.image.empty.teamLogo50x50())
            }
            teamLogoView.addSubview(imageView)
        }
    }
}
