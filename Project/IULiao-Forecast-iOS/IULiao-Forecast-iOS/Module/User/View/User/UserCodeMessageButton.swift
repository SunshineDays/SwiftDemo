//
//  UserCodeMessageButton.swift
//  IULiao-Forecast-iOS
//
//  Created by levine on 2017/8/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class UserCodeMessageButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //停留的时间
     var remainingSeconds = 0 {
        willSet {
            self.setTitle("\(newValue)s后重获", for: .normal)
            if newValue <= 0 {
                self.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
     var countdownTimer: Timer?
     var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                self.setTitleColor(UIColor.gray, for: .normal)
            }else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                self.setTitleColor(UIColor.logo, for: .normal)
            }
            self.isEnabled = !newValue
        }
    }
    @objc private func updateTime() {
        remainingSeconds -= 1
    }

}
