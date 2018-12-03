//
//  RecommendCartEmptyView.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/9/13.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购物车为空
class RecommendCartEmptyView: UIView {

    typealias GoToRecommendBlock = () -> Void
    public var goToRecommendBlock: GoToRecommendBlock?
    
    @IBAction func recommendAction(_ sender: UIButton) {
        if let block = goToRecommendBlock {
            block()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
