//
//  RecommendFooterCartView.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/9/10.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol RecommendFooterCartViewDelegate: class {
    /// 购物车
    func recommendFooterCartView(_ view: RecommendFooterCartView, cartButtonClick sender: UIButton)
    /// 加入投注
    func recommendFooterCartView(_ view: RecommendFooterCartView, addToCartButtonClick sender: UIButton)
    /// 立即投注
    func recommendFooterCartView(_ view: RecommendFooterCartView, betButtonClick sender: UIButton)
}

class RecommendFooterCartView: UIView {

    @IBOutlet weak var addOneLabelBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addOneLabel: UILabel!
    
    @IBOutlet weak var cartImageButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var betButton: UIButton!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberView: UIView!
    
    private var timer: Timer?
    
    public weak var delegate: RecommendFooterCartViewDelegate?
    
    public var cartNumber = 0 {
        didSet {
            numberLabel.text = cartNumber.string()
        }
    }
    
    public func addToCart() {
        addOneLabel.isHidden = false
        cartNumber += 1
        addOneLabelBottomConstraint.constant = 0
        addOneLabel.font = UIFont.systemFont(ofSize: 20)
        addOneLabel.alpha = 1
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(changeFrame), userInfo: nil, repeats: true)
    }

    public var isGray = false {
        didSet {
            numberView.backgroundColor = isGray ? UIColor(hex: 0xCCCCCC) : UIColor.logo
            addToCartButton.backgroundColor = isGray ? UIColor(hex: 0xD9D9D9) : UIColor(hex: 0xFFB922)
            betButton.backgroundColor = isGray ? UIColor(hex: 0xCCCCCC) : UIColor.logo
            cartButton.isUserInteractionEnabled = !isGray
            cartImageButton.setImage(isGray ? R.image.cartGray() : R.image.cartBlack(), for: .normal)
            addToCartButton.isUserInteractionEnabled = !isGray
            betButton.isUserInteractionEnabled = !isGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addOneLabel.isHidden = true
    }

}

extension RecommendFooterCartView {
    
    @objc private func changeFrame() {
        addOneLabelBottomConstraint.constant += 1
        addOneLabel.font = UIFont.systemFont(ofSize: 20 + addOneLabelBottomConstraint.constant / 3)
        if addOneLabelBottomConstraint.constant >= 50 {
            addOneLabel.alpha = 1 - (addOneLabelBottomConstraint.constant - 50) / 50
        }
        if addOneLabelBottomConstraint.constant >= 100 {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @IBAction func cartAction(_ sender: UIButton) {
        delegate?.recommendFooterCartView(self, cartButtonClick: sender)
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        delegate?.recommendFooterCartView(self, addToCartButtonClick: sender)
        
    }
    
    @IBAction func betAction(_ sender: UIButton) {
        delegate?.recommendFooterCartView(self, betButtonClick: sender)
    }
    
}
