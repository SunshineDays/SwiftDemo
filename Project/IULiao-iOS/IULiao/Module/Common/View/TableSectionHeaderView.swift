//
//  TableSectionHeaderView.swift
//  IULiao
//
//  Created by levine on 2017/8/2.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit
class TableSectionHeaderView: UIView {
    
    var title :String
    var frameHeight: CGFloat
    init(frame: CGRect,title:String) {
        self.title = title
        self.frameHeight = frame.size.height
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(frameHeight - 5)
        }
        lineView.snp.makeConstraints { (make) in
            make.width.equalTo(3)
            make.height.equalTo(16)
            make.leading.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineView)
            make.leading.equalTo(lineView.snp.trailing).offset(8)
        }
    }
    private lazy var lineView : UIView = { [weak self] in
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 244, g: 153, b: 0)
        return lineView
        }()
    private lazy var titleLabel :UILabel = { [weak self] in
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(r: 244, g: 153, b: 0)
        return titleLabel
        }()
    private lazy var contentView : UIView = { [weak self] in
        let contenView = UIView()
        
        return contenView
        }()
    private lazy var bottomLineView : UIView = { [weak self] in
        let bottomLineView = UIView(frame: CGRect(x: 0, y: (self?.contentView.height)!-0.3, width: (self?.contentView.width)!, height: 0.3))
        bottomLineView.backgroundColor = UIColor(r: 190, g: 190, b: 190)
        return bottomLineView
        }()
    
}
extension TableSectionHeaderView{
    private func setupUI(){
        self.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(lineView)
        contentView.addSubview(titleLabel)
        // contentView.addSubview(bottomLineView)
        addSubview(contentView)
        titleLabel.text = title
    }
}
