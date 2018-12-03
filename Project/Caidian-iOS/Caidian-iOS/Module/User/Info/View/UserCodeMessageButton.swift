//
//  UserCodeMessageButton.swift
//  IULiao
//
//  Created by levine on 2017/8/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class UserCodeMessageButton: UIButton {

    // 停留的时间
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
                self.backgroundColor = UIColor.gray
                self.layer.borderColor = UIColor.gray.cgColor
                self.setTitleColor(UIColor(r: 230, g: 230, b: 230), for: .normal)
            }else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                self.backgroundColor = UIColor.white
                self.layer.borderColor = UIColor(r: 244, g: 153, b: 0).cgColor
                self.setTitleColor(UIColor(r: 244, g: 153, b: 0), for: .normal)
            }
            self.isEnabled = !newValue
        }
    }
    @objc private func updateTime() {
        remainingSeconds -= 1
    }

}
