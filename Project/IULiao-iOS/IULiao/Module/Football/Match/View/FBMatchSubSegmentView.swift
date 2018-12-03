//
//  FBMatchSubSegmentView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 二级segment
class FBMatchSubSegmentView: UIView {

    /// title
    var sectionTitles = [String]() {
        didSet {
            configView(titles: sectionTitles)
        }
    }
    
    /// 选中的索引
    var selectedIndex = 0 {
        didSet {
            if oldValue != selectedIndex {
                selectedIndexChange(index: selectedIndex)
            }
        }
    }
    
    /// 选中改变
    var indexChangeBlock: ((_ button: UIButton, _ index: Int) -> Void)?

    private var stackView = UIStackView()
    private var buttons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    private func loadView() {
        
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
        }
        
        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 1)
        backgroundColor = UIColor.white
    }
    
    private func configView(titles: [String]) {
        
        buttons.removeAll()
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
            stackView.removeArrangedSubview($0)
        }

        let offset: CGFloat = TSScreen.currentWidth < TSScreen.iPhone6Width ? 10 : 16
        
        for title in titles {
            let btn = UIButton(type: .custom)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(TSColor.gray.gamut333333, for: .normal)
            btn.setTitleColor(TSColor.gray.gamut333333, for: .highlighted)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)

            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: offset)
            btn.addTarget(self, action: #selector(buttonSelectedAction(button:)), for: .touchUpInside)
            btn.setBackgroundColor(UIColor.white, forState: .normal)
            btn.setBackgroundColor(UIColor.white, forState: .highlighted)
            btn.setBackgroundColor(TSColor.logo, forState: .selected)
            let v = UIView()
            v.backgroundColor = UIColor.white
            v.isUserInteractionEnabled = true
            v.addSubview(btn)
            stackView.addArrangedSubview(v)
            buttons.append(btn)
            
            btn.snp.makeConstraints {
                make in
                make.center.equalToSuperview()
                make.height.equalTo(24)
            }
        }
        
        selectedIndexChange(index: selectedIndex)
    }
    
    @objc func buttonSelectedAction(button: UIButton) {
        if let index = buttons.index(of: button) {
            selectedIndexChange(index: index)
            indexChangeBlock?(button, index)
        }
    }
    
    private func selectedIndexChange(index: Int) {
        if index >= 0 && index < buttons.count {
            buttons.forEach {
                $0.isSelected = false
                $0.cornerRadius = 0
            }
            let btn = buttons[index]
            btn.isSelected = true
            btn.cornerRadius = 12
        }
    }
}

