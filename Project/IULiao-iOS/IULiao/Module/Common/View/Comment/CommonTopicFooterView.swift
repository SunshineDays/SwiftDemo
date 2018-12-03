//
//  CommonTopicFooterView.swift
//  IULiao
//
//  Created by levine on 2017/9/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

class CommonTopicFooterView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //第几组
    var section: Int?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func  initView() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(cutLine)
//        contentView.addSubview(bgView)
//        contentView.addSubview(checkMoreButton)
        cutLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(contentView)
            make.height.equalTo(0.3 * (UIScreen.main.scale / 2))
        }
    }
    lazy var checkMoreButton: UIButton = {
        let checkMoreButton = UIButton(type: .custom)
        checkMoreButton.adjustsImageWhenHighlighted = false
        checkMoreButton.setTitle("查看全部评论", for: .normal)
        checkMoreButton.backgroundColor = UIColor(r: 255, g: 128, b: 0)
        return checkMoreButton
    }()
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(r: 242, g: 242, b: 242)
        return bgView
    }()
    private lazy var cutLine: UIView = {
        let cutLine = UIView()
        cutLine.backgroundColor = UIColor(r: 204, g: 204, b: 204)
        return cutLine
    }()


    // 共有方法
    func setSection(section: Int, allSection:Int) {
        self.section = section
    }

}
