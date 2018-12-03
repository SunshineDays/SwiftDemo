//
//  CommonTopicFrame.swift
//  IULiao
//
//  Created by levine on 2017/9/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit
import YYText

private let kTopicHorizontalSpace: CGFloat = 20.0
private let kTopicVerticalSpace: CGFloat = 10.0
private let kTopicBottomSpace: CGFloat = 15.0
private let kTopicAvatarWH: CGFloat = 40.0

private let kthumbButtonWidth: CGFloat = 50.0
private let kthumbButtonY: CGFloat = 16.0

private let kcommenButtontY: CGFloat = 20.0
private let kcommenButtontWidth: CGFloat = 45.0
private let kcommenButtontHeight: CGFloat = 25.0

private let kNickNameHeight: CGFloat = 16.0
private let kCreateTimeHeight: CGFloat = 14.0
class CommonTopicFrame: NSObject {
    // 头像frame
    private(set) var avatarImageVFrame: CGRect = CGRect.zero
    // 昵称frame
    private(set) var nicknameLabelFrame: CGRect = CGRect.zero
    // 评论frame
    private(set) var commenButtontFrame: CGRect = CGRect.zero
    // 点赞frame
    private(set) var thumbButtonFrame: CGRect = CGRect.zero
    // 时间frame
    private(set) var createTimeLabelFrame: CGRect = CGRect.zero
    // 话题内容frame
    private(set) var contentLabelFrame: CGRect = CGRect.zero

    //评论尺寸数组 存放尺寸模型
    var commentFrames: NSMutableArray = []

    //整个话题占据的高度
    private(set) var height: CGFloat = 0.0



    // 话题模型  ==> 存储的所有 控件的 frame  =>根据服务器返回的数据
    var topicModel: CommonTopicModel? {
        didSet {
            if let topicModel = topicModel {
                let width = TSScreen.currentWidth
                //头像
                avatarImageVFrame = CGRect(x: kTopicHorizontalSpace, y: kTopicVerticalSpace, width: kTopicAvatarWH, height: kTopicAvatarWH)
                //点赞

                thumbButtonFrame = CGRect(x: width - kthumbButtonWidth - 22, y: kthumbButtonY, width: kthumbButtonWidth, height: 25)
                //评论

                commenButtontFrame = CGRect(x: thumbButtonFrame.origin.x - kcommenButtontWidth - 2, y: kthumbButtonY + 4, width: kcommenButtontWidth, height: kcommenButtontHeight)
                //昵称
                let nickNameX = avatarImageVFrame.maxX + kTopicVerticalSpace
                nicknameLabelFrame = CGRect(x:nickNameX , y: avatarImageVFrame.minY, width: commenButtontFrame.minX - nickNameX, height: kNickNameHeight)
                // 时间
                createTimeLabelFrame = CGRect(x: nickNameX, y: nicknameLabelFrame.maxY + 6, width: nicknameLabelFrame.width, height: kCreateTimeHeight)

                //内容

                let textX = nickNameX
                let textY = createTimeLabelFrame.maxY + kTopicVerticalSpace
                let textLimitSize  = CGSize(width: width - textX - 22, height: CGFloat(MAXFLOAT))
        
                let textHeight = (YYTextLayout(container: YYTextContainer(size: textLimitSize), text: topicModel.attributedContentText)?.textBoundingRect.height)!
                contentLabelFrame = CGRect(x: textX, y: textY, width: textLimitSize.width, height: textHeight)


                if topicModel.children.count > 0 {
                    for commentModel in topicModel.children {
                        let commentModel = commentModel 
                        let commentFrame = CommonCommentFrame()
                        commentFrame.maxW = width - kTopicVerticalSpace * 2
                        commentFrame.commentModel = commentModel

                        self.commentFrames.add(commentFrame)
                    }
                }
//                if topicModel.children.count > 5 {
//                    
//                }
                /// 自身的高度
                self.height = contentLabelFrame.maxY + 14
            }
        }
    }

}
