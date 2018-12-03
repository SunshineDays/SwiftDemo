//
//  ForecastTitleTypeSelectView.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

protocol ForecastTitleTypeSelectViewDelegate: class {
    func ForecastTitleSelectedContentView(_ view: ForecastTitleTypeSelectView, selectedButtonClick sender: UIButton, selectedTitle: String)
}

/// 预测类型内容选择view
class ForecastTitleTypeSelectView: UIView {
    
    weak var delegate: ForecastTitleTypeSelectViewDelegate?
    
    var selectedTitle = String()
    
    var titles = [String]() {
        didSet {
            initButtons()
        }
    }
    
    var top: CGFloat = 15
    var left: CGFloat = 10
    var space: CGFloat = 15
    var buttonHeight: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = UIColor.colour.gamut040000.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initButtons() {
        for view in subviews {
            view.removeFromSuperview()
        }
        
        let buttonWidth = (width - left * 2 - space * 2) / 3
        
        for (index, title) in titles.enumerated() {
            let buttonX = left + CGFloat(index % 3) * (buttonWidth + space)
            let buttonY = top + CGFloat(index / 3) * (buttonHeight + top)
            
            let button = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight))
            
            button.setBackgroundColor(UIColor.white, forState: .normal)
            button.setBackgroundColor(UIColor.logo, forState: .selected)
            
            button.setTitle(title, for: .normal)
            
            button.setTitleColor(UIColor.colour.gamut4D4D4D, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            
            button.layer.cornerRadius = 3
            button.layer.borderColor = UIColor.colour.gamutCCCCCC.cgColor
            button.layer.borderWidth = 1.pixel
            button.layer.masksToBounds = true
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            
            button.isSelected = selectedTitle == title
            
            addSubview(button)
        }
        
    }
    
    @objc private func buttonClick(_ sender: UIButton) {
        for view in subviews {
            (view as! UIButton).isSelected = view == sender
        }
        delegate?.ForecastTitleSelectedContentView(self, selectedButtonClick: sender, selectedTitle: sender.currentTitle!)
        isHidden = true
    }
    
}
