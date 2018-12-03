//
//  CommonCommentHeaderView.swift
//  IULiao
//
//  Created by levine on 2017/9/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import YYText
import MBProgressHUD
private let kCommentContentLineSpacing: CGFloat = 10.0
protocol CommonTopicHeaderViewDelegate: NSObjectProtocol {
    /** 点击头像或昵称的事件回调 */
    func commentHeaderViewDidClickedUser(commentHeaderView: CommonTopicHeaderView)

    /** 点击头像或昵称的事件回调 */
    func commentHeaderViewDidClickedTopicContent(commentHeaderView: CommonTopicHeaderView)

    /** 用户评论按钮 */
    func commentHeaderViewClickedCommentAction(commentHeaderView: CommonTopicHeaderView)

    /** 用户点击点赞按钮 */
    func commentHeaderViewClickedThumbAction(commentHeaderView: CommonTopicHeaderView, didClickThumnButton thumbButton: FBRecommendFireWorkButton)
}

class CommonTopicHeaderView: UITableViewHeaderFooterView {

    /** 头像 */
    var avatarView: UIImageView?
    /** 昵称 */
    var nickLabel: YYLabel?
    /** 评论 */
    var commentButton: UIButton?
    /** 点赞 */
    var thumbButton: FBRecommendFireWorkButton?
    /** 创建时间 */
    var createTimeLabel: YYLabel?
    /** ContentView */
    var contentBaseView: UIView?
    /** 文本内容 */
    var contentLabel: YYLabel?


    //** 话题模型数据源 */
    var topicFrame: CommonTopicFrame? {
        didSet {
            if let topicFrame = topicFrame {
                let topicModel = topicFrame.topicModel
                avatarView?.frame = topicFrame.avatarImageVFrame

                avatarView?.sd_setImage(with: URL(string: TSImageURLHelper(string: (topicModel?.user.avatar)!, size: CGSize(width: 100, height: 100)).chop().urlString)) {

                    [weak self] (image, error, type, url) in
                    if error == nil {
                        self?.avatarView?.setImageCorner(radius: 20)
                    }else {
                        self?.avatarView?.image = R.image.fbRecommend.placeholdAvatar36x36()
                        self?.avatarView?.setImageCorner(radius: 20)
                    }
                }
                nickLabel?.frame = topicFrame.nicknameLabelFrame
                nickLabel?.text = topicModel?.user.nickName



                thumbButton?.frame = topicFrame.thumbButtonFrame
                //MARK:  标记一下
                if topicModel?.isKill == 1 {
                    thumbButton?.setTitle("\(topicFrame.topicModel?.pollUp ?? 0)", for: .normal)

                }else {
                    if (topicModel?.pollScore)! > 0 {
                        thumbButton?.isSelected = true
                        thumbButton?.setTitle("\(topicFrame.topicModel?.pollUp ?? 0)", for: .selected)
                    }else {
                        thumbButton?.setTitle("\(topicFrame.topicModel?.pollUp ?? 0)", for: .normal)
                    }
                }

                
                commentButton?.frame = topicFrame.commenButtontFrame
                
                commentButton?.setTitle("\(topicFrame.commentFrames.count)", for: .normal)

//                thumbButton?.isSelected = (topicModel?.pollScore)! == 0 ? false : true

                createTimeLabel?.frame = topicFrame.createTimeLabelFrame
                createTimeLabel?.text = TSUtils.timestampToString((topicModel?.created)!)

                contentLabel?.frame = topicFrame.contentLabelFrame
                //此评论已经被删除
                contentLabel?.attributedText = topicModel?.attributedContentText

            }

        }
    }
    var indexPath: IndexPath?

    weak var delegate: CommonTopicHeaderViewDelegate?

   

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // 初始化
        initView()
        //
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func  initView() {
        contentView.backgroundColor = UIColor.white

        avatarView = UIImageView()
        avatarView?.isUserInteractionEnabled = true
        avatarView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarOrNicknameDidClicked)))
        contentView.addSubview(avatarView!)

        nickLabel = YYLabel()
        nickLabel?.text = ""
        nickLabel?.font = UIFont.systemFont(ofSize: 14)
        nickLabel?.textColor = UIColor(r: 51, g: 51, b: 51)
        nickLabel?.textAlignment = .left
        contentView.addSubview(nickLabel!)
        nickLabel?.textTapAction = {
           [weak self] (containerView: UIView, text: NSAttributedString, range: NSRange, rect: CGRect) in
            self?.avatarOrNicknameDidClicked()
        }


        thumbButton = FBRecommendFireWorkButton(type: .custom)
        thumbButton?.layoutImageViewPosition(.left, withOffset: 4)
        thumbButton?.adjustsImageWhenHighlighted = false
        thumbButton?.setImage(R.image.common.pollupNormal(), for: .normal)
        thumbButton?.setImage(R.image.common.pollupSelect(), for: .selected)
        thumbButton?.setTitleColor(UIColor(r: 102, g: 102, b: 102), for: .normal)
        thumbButton?.setTitle("", for: .normal)
        thumbButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        thumbButton?.setTitleColor(UIColor(r: 244, g: 153, b: 0), for: .selected)
        thumbButton?.addTarget(self, action: #selector(thumAction), for: .touchUpInside)
        contentView.addSubview(thumbButton!)

        commentButton = UIButton(type: .custom)
        commentButton?.layoutImageViewPosition(.top, withOffset: 4)
        commentButton?.adjustsImageWhenHighlighted = false
        commentButton?.setImage(R.image.common.commentNormal(), for: .normal)
        commentButton?.setImage(R.image.common.commentHigh(), for: .highlighted)
        commentButton?.setTitleColor(UIColor(r: 102, g: 102, b: 102), for: .normal)
        commentButton?.setTitle("", for: .normal)
        commentButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        commentButton?.addTarget(self, action: #selector(commendAction), for: .touchUpInside)
        contentView.addSubview(commentButton!)

        createTimeLabel = YYLabel()
        createTimeLabel?.text = ""
        createTimeLabel?.font = UIFont.systemFont(ofSize: 12)
        createTimeLabel?.textColor = UIColor(r: 153, g: 153, b: 153)
        createTimeLabel?.textAlignment = .left
        createTimeLabel?.textTapAction = {
            [weak self] (containerView: UIView, text: NSAttributedString, range: NSRange, rect: CGRect) in
            self?.contentTextDidClicked()
        }
        contentView.addSubview(createTimeLabel!)

        contentLabel = YYLabel()
        // 设置文本的额外区域，修复用户点击文本没有效果
        contentLabel?.font = UIFont.systemFont(ofSize: 14)
        contentLabel?.numberOfLines = 0
        contentLabel?.textColor = UIColor(r: 153, g: 153, b: 153)
        contentLabel?.textAlignment = .left
        contentView.addSubview(contentLabel!)
        contentLabel?.textTapAction = {
            [weak self] (containerView: UIView, text: NSAttributedString, range: NSRange, rect: CGRect) in
            self?.contentTextDidClicked()
        }

    }
    //头像和昵称共有一个事件
    @objc private func avatarOrNicknameDidClicked() {

        if delegate != nil {
            delegate?.commentHeaderViewDidClickedUser(commentHeaderView: self)
        }
    }
    //评论事件
    @objc private func commendAction() {
        if topicFrame?.topicModel?.isKill == 1 {
            TSToast.hudTextLoad(view: self, text: "此评论涉嫌违规,已被删除", mode: MBProgressHUDMode.text, margin: 10, duration: 2)
            return
        }

        if delegate != nil {
            delegate?.commentHeaderViewClickedCommentAction(commentHeaderView: self)
        }
    }
    //点赞事件
    @objc private func thumAction(sender: FBRecommendFireWorkButton) {
        if topicFrame?.topicModel?.isKill == 1 {
            TSToast.hudTextLoad(view: self, text: "此评论涉嫌违规,已被删除", mode: MBProgressHUDMode.text, margin: 10, duration: 2)
            return
        }
        if delegate != nil {
            delegate?.commentHeaderViewClickedThumbAction(commentHeaderView: self,didClickThumnButton: sender)
        }
    }
    //文本区域点击事件
    private func contentTextDidClicked() {
        if topicFrame?.topicModel?.isKill == 1 {
            TSToast.hudTextLoad(view: self, text: "此评论涉嫌违规,已被删除", mode: MBProgressHUDMode.text, margin: 10, duration: 2)
            return
        }
        if delegate != nil {
            delegate?.commentHeaderViewDidClickedTopicContent(commentHeaderView: self)
        }
    }

}
