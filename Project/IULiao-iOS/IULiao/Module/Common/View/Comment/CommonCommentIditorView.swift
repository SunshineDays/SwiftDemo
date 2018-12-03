//
//  CommonCommentIditorView.swift
//  IULiao
//
//  Created by levine on 2017/9/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit
protocol CommonCommentIditorViewDelegate: class {
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickEditor editorImageView: UIImageView)
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickComment commentButton: UIButton)
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickcollection collectionButton: UIButton)
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickShare shareButton: UIButton)
}
private let kMargin: CGFloat = (TSScreen.currentWidth - 210 - 25 * 3) / 4
class CommonCommentIditorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //外部变量传递参数
    var paragram: (comments: Int, isAttention: Bool)? {
        didSet {

            commentCountLabel.text = "\(paragram?.0 ?? 0)"
          let width =   commentCountLabel.getLabWidth(labelStr: commentCountLabel.text!,font: UIFont.systemFont(ofSize: 9), height: 10)
            commentCountLabel.snp.updateConstraints { (make) in
                make.width.equalTo(width + 5)
            }
            collectionButton.isSelected = (paragram?.1)!
        }
    }
    
    weak var delegate: CommonCommentIditorViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        setUpLayout();
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        backgroundColor = UIColor.white
        addSubview(lineView)
        addSubview(editorImageView)
        addSubview(shareButton)
        addSubview(commentButton)
        addSubview(collectionButton)
        addSubview(commentCountLabel)

    }

    private func setUpLayout() {
        lineView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self)
            make.height.equalTo(0.3 * (UIScreen.main.scale / 2))
        }
        editorImageView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
        shareButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.trailing.equalTo(self).offset(-kMargin)
            make.centerY.equalTo(self)
        }
        collectionButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.trailing.equalTo(shareButton.snp.leading).offset(-kMargin)
            make.centerY.equalTo(self)
        }
        commentButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.centerY.equalTo(self)
            make.trailing.equalTo(collectionButton.snp.leading).offset(-kMargin)
        }
        commentCountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(commentButton).offset(10)
            make.centerY.equalTo(commentButton).offset(-8)
            make.height.equalTo(10)
            make.width.equalTo(0)
        }

    }
    private lazy var editorImageView: UIImageView = {
        let editorImageView = UIImageView()
        editorImageView.image = R.image.common.commentBg()
        editorImageView.isUserInteractionEnabled = true
        editorImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editorAction)))
        return editorImageView
    }()

    private lazy var commentButton : UIButton = {
        let commentButton = UIButton(type: .custom)
        commentButton.adjustsImageWhenHighlighted = false
        commentButton.setImage(R.image.common.commentNormal(), for: .normal)
        commentButton.setImage(R.image.common.commentHigh(), for: .highlighted)
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        return commentButton
    }()
     lazy var collectionButton : UIButton = {
        let collectionButton = UIButton(type: .custom)
        collectionButton.adjustsImageWhenHighlighted = false
        collectionButton.setImage(R.image.common.collectNormal(), for: .normal)
        collectionButton.setImage(R.image.common.collectSelect(), for: .selected)
        collectionButton.addTarget(self, action: #selector(collectionButtonAction), for: .touchDown)
        return collectionButton
    }()
    private lazy var shareButton : UIButton = {
        let shareButton = UIButton(type: .custom)
        shareButton.adjustsImageWhenHighlighted = false
        shareButton.setImage(R.image.common.shareNormal(), for: .normal)
        shareButton.setImage(R.image.common.shareHigh(), for: .highlighted)
        shareButton.addTarget(self, action: #selector(shareButtonButtonAction), for: .touchUpInside)
        return shareButton
    }()
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 204, g: 204, b: 204)
        return lineView
    }()
    private lazy var commentCountLabel: UILabel = {
        let commentCountLabel = UILabel()
        commentCountLabel.text = "0"
        commentCountLabel.font = UIFont.systemFont(ofSize: 9)
        commentCountLabel.layer.cornerRadius = 5
        commentCountLabel.layer.masksToBounds = true
        commentCountLabel.textAlignment = .center
        commentCountLabel.textColor = UIColor.white
        commentCountLabel.backgroundColor = UIColor(r: 252, g: 154, b: 57)
        return commentCountLabel
    }()
    //点击弹出 编辑 评论信息界面
    @objc func editorAction(tap: UITapGestureRecognizer) {
        delegate?.commonCommentIditorView(self, didClickEditor: tap.view as! UIImageView)
    }
    //发表评论
    @objc func commentButtonAction(sender: UIButton) {
        delegate?.commonCommentIditorView(self, didClickComment: sender)
    }
    //收藏 按钮
    @objc func collectionButtonAction(sender: UIButton) {
        delegate?.commonCommentIditorView(self, didClickcollection: sender)
    }
    // 分享
    @objc func shareButtonButtonAction(sender: UIButton) {
        delegate?.commonCommentIditorView(self, didClickShare: sender)
    }
}
