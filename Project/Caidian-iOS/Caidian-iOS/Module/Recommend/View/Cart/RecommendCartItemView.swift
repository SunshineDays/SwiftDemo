//
//  RecommendCartItemView.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/9/14.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 右上角购物车按钮
class RecommendCartItemView: UIView {

    @IBOutlet weak var numberLabel: UILabel!
    
    typealias CartItemTouchBlock = () -> Void
    
    public var cartItemTouchBlock: CartItemTouchBlock?
    
    @IBAction func cartAction(_ sender: UIButton) {
        if let block = cartItemTouchBlock {
            block()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
