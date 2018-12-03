//
//  CommonCommentFrame.swift
//  IULiao
//
//  Created by levine on 2017/9/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import YYText
private let kCommentContairnerSpacing: CGFloat = 60.0
private let kMarginSpacing: CGFloat = 10.0
private let kCommentContentLineSpacing: CGFloat = 44.0

private let kContentMargin: CGFloat = 80.0
let kCommentUserKey: String = "kCommentUserKey"
class CommonCommentFrame: NSObject {

    /** 容器内容尺寸 */
    var contairnerViewFrame: CGRect = CGRect.zero
    /** 内容尺寸 */
    var textFrame: CGRect = CGRect.zero
    /** cell高度 */
     private(set) var cellHeight: CGFloat = 0.0
    /** 最大宽度 外界传递 */
    var maxW: CGFloat = 0.0
    /** 评论模型 外界传递 */
    var commentModel: CommonTopicModel? {
        didSet {

            let textLimitSize  = CGSize(width: maxW - kContentMargin , height: CGFloat(MAXFLOAT))

            let textHeight = (YYTextLayout(container: YYTextContainer(size: textLimitSize), text: (attributedContentTexts)!)?.textBoundingRect.height)!
            contairnerViewFrame = CGRect(x: kCommentContairnerSpacing + kMarginSpacing , y: 0, width: maxW - kCommentContairnerSpacing , height: textHeight + 10)
            textFrame = CGRect(x: kCommentContairnerSpacing + 2 * kMarginSpacing, y: kMarginSpacing / 2, width: textLimitSize.width, height: textHeight)
            cellHeight = contairnerViewFrame.maxY 
        }
    }

    var attributedContentTexts: NSAttributedString? {

        //评论内容
        var userNameText = String(format: "%@：%@", (commentModel?.user.nickName)!,(commentModel?.content)!)
        if commentModel?.isKill == 1 {
            userNameText = "该条评论涉嫌违规,已被删除"
        }

        let mutableAttributedString = NSMutableAttributedString(string: userNameText)
        mutableAttributedString.yy_font = UIFont.systemFont(ofSize: 14)
        mutableAttributedString.yy_color = UIColor(r: 102, g: 102, b: 102)
        mutableAttributedString.yy_lineSpacing = 6
        if commentModel?.isKill == 1 {
            mutableAttributedString.yy_setTextStrikethrough(YYTextDecoration(style: YYTextLineStyle.single), range: NSMakeRange(0, mutableAttributedString.length))
        }else {
            let range = NSMakeRange(0, (commentModel?.user.nickName.count)!)

            let highUserNameText = YYTextHighlight(backgroundColor: UIColor(white: 0.0, alpha: 0.22))
            // 标记一下---..
            highUserNameText.userInfo = [kCommentUserKey : commentModel?.user ?? (Any).self]
            mutableAttributedString.yy_setTextHighlight(highUserNameText, range: range)
            // 设置昵称颜色
            mutableAttributedString.yy_setColor(UIColor(r: 51, g: 51, b: 51), range: NSMakeRange(0, ((commentModel?.user.nickName.count)! + 1)))

        }

        return mutableAttributedString

    }
}
