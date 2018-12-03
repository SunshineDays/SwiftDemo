//
//  CommonCommentTitleCell.swift
//  IULiao
//
//  Created by levine on 2017/9/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class CommonCommentTitleCell: UITableViewCell {


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initView() {
       let headerView = TableSectionHeaderView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: 48), title: "所有评论")
        contentView.addSubview(headerView)
    }

}
