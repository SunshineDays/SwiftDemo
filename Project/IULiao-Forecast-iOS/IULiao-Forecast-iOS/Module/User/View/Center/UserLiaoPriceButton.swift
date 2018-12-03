//
//  UserLiaoPriceButton.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/20.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 料豆充值价格按钮
class UserLiaoPriceButton: UIButton {
    
    private lazy var giftImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = R.image.liao.gift()
        addSubview(imageView)
        return imageView
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        label.numberOfLines = 0
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.colour.gamutCCCCCC.cgColor
        layer.borderWidth = 1.pixel
        layer.cornerRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func isSelected(price: Double, liao: Double, gift: Double, isSelected: Bool) {
        let isGift = gift > 0
        
        self.isSelected = isSelected
        giftImageView.isHidden = !isGift
        
        let priceText = "\(price.decimal(0)) 元"
        let liaoText = "\n\(liao.decimal(0))"
        let giftText = "+\(gift.decimal(0))"

        let priceFont = UIFont.systemFont(ofSize: 14)
        let liaoFont = UIFont.systemFont(ofSize: 12)
        let giftFont = UIFont.systemFont(ofSize: 12)
        
        let priceColor = UIColor.colour.gamut333333
        let liaoColor = UIColor.colour.gamutB3B3B3
        let giftColor = UIColor.logo
        
        let selectedColor = UIColor.white
        
        if isSelected {
            if isGift {
                contentLabel.text = priceText + liaoText + giftText + " 料豆"
                contentLabel.attributedText = PublicHelper.attributedString(
                    texts: [priceText, liaoText, giftText, " 料豆"],
                    fonts: [priceFont, liaoFont, giftFont, liaoFont],
                    colors: [selectedColor, selectedColor, selectedColor, selectedColor])
            } else {
                titleLabel?.text = priceText + "\(liaoText) 料豆"
                contentLabel.attributedText = PublicHelper.attributedString(
                    texts: [priceText, "\(liaoText) 料豆"],
                    fonts: [priceFont, liaoFont],
                    colors: [selectedColor, selectedColor])
            }
            backgroundColor = UIColor.logo
        } else {
            if isGift {
                contentLabel.text = priceText + liaoText + giftText + " 料豆"
                contentLabel.attributedText = PublicHelper.attributedString(
                    texts: [priceText, liaoText, giftText, " 料豆"],
                    fonts: [priceFont, liaoFont, giftFont, liaoFont],
                    colors: [priceColor, liaoColor, giftColor, liaoColor])
            } else {
                contentLabel.text = priceText + "\(liaoText) 料豆"
                contentLabel.attributedText = PublicHelper.attributedString(
                    texts: [priceText, "\(liaoText) 料豆"],
                    fonts: [priceFont, liaoFont],
                    colors: [priceColor, liaoColor])
            }
            backgroundColor = UIColor.white
        }
    }

}
