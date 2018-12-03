//
//  UserRechargeMoneyView.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/27.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 充值时的金额选择view
@IBDesignable
class UserRechargeMoneyView: UIView {

    @IBOutlet var boxView: UIView!
    @IBOutlet weak var checkedImageView: UIImageView!
    @IBOutlet weak var serialBtn: UIButton!

    override func awakeFromNib() {
        boxView.borderColor = UIColor.grayGamut.gamut999999
    }

    var serialBtnClickBlock: ((_ btn: UIButton, _ isChecked: Bool) -> Void)?

    /// 选中
    @IBInspectable var isChecked: Bool = false {
        didSet {
            serialBtn.isSelected = isChecked
            checkedImageView.isHidden = !isChecked
            if isChecked {
                boxView.borderColor = UIColor.logo
            } else {
                boxView.borderColor = UIColor.grayGamut.gamut999999
            }
        }
    }
    
    @IBInspectable var attributedNormalTitle: NSMutableAttributedString = NSMutableAttributedString() {
        didSet {
            serialBtn.titleLabel?.numberOfLines = 0
            serialBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            serialBtn.titleLabel?.textAlignment = NSTextAlignment.center
            serialBtn.setAttributedTitle(attributedNormalTitle, for: .normal)
        }
    }
    
    @IBInspectable var attributedFocusedTitle: NSMutableAttributedString = NSMutableAttributedString() {
        didSet {
            serialBtn.titleLabel?.numberOfLines = 0
            serialBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            serialBtn.titleLabel?.textAlignment = NSTextAlignment.center
            serialBtn.setAttributedTitle(attributedFocusedTitle, for: .selected)
            
        }
    }

    @IBAction func serialBtnAction(_ sender: UIButton) {
        serialBtnClickBlock?(sender, isChecked)
    }

    @IBInspectable var text: String = "" {
        didSet {
            serialBtn.titleLabel?.numberOfLines = 0
            serialBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            serialBtn.titleLabel?.textAlignment = NSTextAlignment.center
            serialBtn.setTitle(text, for: .normal)

        }
    }


    /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
    var contentView: UIView!

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

    func initialSetup() {
        serialBtn.setTitle("100元", for: .normal)
        isChecked = false
    }

    //加载xib
    func loadViewFromNib() -> UIView {
        let view = R.nib.userRechargeMoneyView.firstView(owner: self)!
        return view
    }

    //设置好xib视图约束
    func addConstraints() {
        contentView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }

}
