//
//  FBPulldownButtonView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/28.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 排行榜 选择按钮View
class FBPulldownButtonView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    //显示进度的文本标签
//    @IBOutlet weak var textLabel: UILabel!
    
    
    //文本颜色
    @IBInspectable var color: UIColor = UIColor(hex: 0x333333) {
        didSet {
            titleLabel.textColor = color
        }
    }
    
    //初始化默认属性配置
    func initialSetup(){
        titleLabel.textColor = self.color
        titleButton.addTarget(self, action: #selector(titleButtonAction(_:)), for: .touchUpInside)
    }
    
    //布局相关设置
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    var blockTitleButtonAction: ((_ sender: UIButton) -> ())?
    
    @objc private func titleButtonAction(_ sender: UIButton) {
        blockTitleButtonAction?(sender)
    }
    
    
    /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
    private var contentView:UIView!
    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        //初始化属性配置
        initialSetup()
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        //初始化属性配置
        initialSetup()
    }
    //加载xib
    private func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    //设置好xib视图约束
    private func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }
}
