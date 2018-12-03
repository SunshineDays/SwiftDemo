//
//  UpdateCheckView.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 版本更新
class UpdateCheckView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var updateButton: UIButton!

    @IBOutlet weak var nextButton: UIButton!
    
    private let updateCheckHandler = UpdateCheckHandler()
    
    private var model: UpdateCheckModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight)
        backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        
        backgroundView.layer.cornerRadius = 6
        backgroundView.layer.masksToBounds = true
        
        backgroundView.frame.origin.y = TSScreen.currentHeight
        
        updateButton.addTarget(self, action: #selector(loadURL), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.frame.origin.y = (TSScreen.currentHeight - self.backgroundView.width) / 2
        }
    }
    
    public func initWith(model: UpdateCheckModel) {
        self.model = model
        titleLabel.text = "有新的版本(\(model.version.decimal(1)))"
        contentLabel.text = model.message
    }
    
    @objc private func loadURL() {
        if UIApplication.shared.canOpenURL(URL(string: model.downloadURL)!) {
            UIApplication.shared.openURL(URL(string: model.downloadURL)!)
        }
        dismiss()
    }
    
    @objc private func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.isHidden = true
            self.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    
    
}
