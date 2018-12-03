//
//  CommonCommentCell.swift
//  IULiao
//
//  Created by levine on 2017/9/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import YYText

protocol CommonCommentCellDelegate: NSObjectProtocol {
    func commentCell(_ commentCell: CommonCommentCell,didClickedUser user: FBRecommendUserModel?)
}

class CommonCommentCell: UITableViewCell {


    var commentFrame: CommonCommentFrame? {
        didSet {
            if let commentFrame = commentFrame {
                contairnerView?.frame = commentFrame.contairnerViewFrame
                contentLabel?.frame = commentFrame.textFrame

                contentLabel?.attributedText = commentFrame.attributedContentTexts
            }

        }
    }

    weak var delegate: CommonCommentCellDelegate?


    var contentLabel: YYLabel?
    var contairnerView: UIView?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        contentView.backgroundColor = UIColor.white


        contairnerView = UIView()
        contairnerView?.backgroundColor = UIColor(r: 242, g: 242, b: 242)
        contentView.addSubview(contairnerView!)
        contentLabel = YYLabel()
//        contentLabel?.textColor = UIColor(r: 242, g: 242, b: 242)
        contentLabel?.numberOfLines = 0 ;
        contentLabel?.textAlignment = .left;
        contentView.addSubview(contentLabel!)
        contentLabel?.highlightTapAction = {
            [weak self] (containerView: UIView, text: NSAttributedString, range: NSRange, rect: CGRect) in

            let highLightText = containerView.value(forKey: "_highlight") as? YYTextHighlight
            if self?.delegate != nil {
                self?.delegate?.commentCell(self!, didClickedUser: highLightText?.userInfo![kCommentUserKey] as? FBRecommendUserModel)
            }
        }
    }
}
