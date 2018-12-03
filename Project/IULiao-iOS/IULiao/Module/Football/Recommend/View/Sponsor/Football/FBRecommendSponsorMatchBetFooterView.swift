//
//  FBRecommendSponsorMatchBetFooterView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/17.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 足球推荐 发布
class FBRecommendSponsorMatchBetFooterView: UIView, UITextViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = TSScreen.currentWidth
//        reasonTextView.delegate = self
    }

    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()//收起键盘
//        }
//        return true
//    }
    
    
}
