//
//  ForecastExpertHeaderInSectionView.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/14.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

class ForecastExpertHeaderInSectionView: UIView {

    private lazy var lineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 10, width: 3, height: 20))
        view.backgroundColor = UIColor.logo
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: lineView.frame.maxX + 8, y: 0, width: 200, height: 40))
        label.textColor = UIColor.colour.gamut333333
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    
    public var title = String() {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.groupTableViewBackground
        addSubview(lineView)
        addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
