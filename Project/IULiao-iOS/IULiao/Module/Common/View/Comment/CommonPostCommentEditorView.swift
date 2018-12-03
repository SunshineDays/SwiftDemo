//
//  CommonPostCommentEditorView.swift
//  IULiao
//
//  Created by levine on 2017/9/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
protocol CommonPostCommentEditorViewDelegate: class {

    func commonPostCommentEditorView(_ commonCommentIditorView: CommonPostCommentEditorView, didClickCommitButton commitButton: UIButton, textContent textStr: String)
    func commonPostCommentEditorView(_ commonCommentIditorView: CommonPostCommentEditorView, didClickCancleButton cancleButton: UIButton)
}
class CommonPostCommentEditorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate: CommonPostCommentEditorViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initView() {
        backgroundColor = UIColor(r: 230, g: 230, b: 230)
        addSubview(titleLabel)
        addSubview(cancleButton)
        addSubview(commitButton)
        addSubview(inputTextView)
        addSubview(placeholderLabel)
    }

    private func setUpLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(12)
        }

        cancleButton.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(24)
            make.leading.equalTo(self).offset(22)
            make.centerY.equalTo(titleLabel)
        }
        commitButton.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(24)
            make.trailing.equalTo(self).offset(-22)
            make.centerY.equalTo(titleLabel)
        }

        inputTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        placeholderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(inputTextView.snp.leading).offset(8)
            make.top.equalTo(inputTextView.snp.top).offset(8)
        }
        
    }
    private lazy var commitButton : UIButton = {
        let commitButton = UIButton(type: .custom)
        commitButton.adjustsImageWhenHighlighted = false
        commitButton.setTitle("发送", for: .normal)
        commitButton.isEnabled = false
        commitButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        commitButton.setTitleColor(UIColor(r: 252, g: 154, b: 57), for: .normal)
        commitButton.setTitleColor(UIColor(r: 170, g: 170, b: 170), for: .disabled)
        commitButton.addTarget(self, action: #selector(commitButtonAction), for: .touchUpInside)
        return commitButton
    }()
    private lazy var cancleButton : UIButton = {
        let cancleButton = UIButton(type: .custom)
        cancleButton.adjustsImageWhenHighlighted = false
        cancleButton.setTitle("取消", for: .normal)
        cancleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancleButton.setTitleColor(UIColor(r: 252, g: 154, b: 57), for: .highlighted)
        cancleButton.setTitleColor(UIColor(r: 102, g: 102, b: 102), for: .normal)
        cancleButton.addTarget(self, action: #selector(cancleButtonAction), for: .touchUpInside)
        return cancleButton
    }()

     lazy var inputTextView: UITextView = {
       let inputTextView = UITextView()
        inputTextView.font = UIFont.systemFont(ofSize: 14)
        inputTextView.bounces = false
        inputTextView.delegate = self
        return inputTextView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "发表评论"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(r: 51, g: 51, b: 51)
        return titleLabel
    }()
     lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "发表你的评论"
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.textAlignment = .left
        placeholderLabel.textColor = UIColor(r: 204, g: 204, b: 204)
        return placeholderLabel
    }()
    //点击弹出 编辑 评论信息界面
    @objc func commitButtonAction(sender: UIButton) {

        if inputTextView.text.lengthOfBytes(using: .utf8) > 0 {

            let trimmingContent = inputTextView.text.trimmingCharacters(in: .whitespaces)
            if trimmingContent.lengthOfBytes(using: .utf8) == 0 {
                TSToast.hudTextLoad(view: self.superview!, text: "请输入评论内容", mode: .text, margin: 10, duration: 2)
            }else {
                delegate?.commonPostCommentEditorView(self, didClickCommitButton: sender, textContent: trimmingContent)

            }


        }

    }
    //发表评论
    @objc func cancleButtonAction(sender: UIButton) {
        delegate?.commonPostCommentEditorView(self, didClickCancleButton: sender)
    }

}
extension CommonPostCommentEditorView: UITextViewDelegate {
    
    //监听UITextView事件
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text.lengthOfBytes(using: .utf8) > 0 {
            //文本框内有文字个数大于0 进行相应操作
            commitButton.isEnabled = true
            placeholderLabel.isHidden = true
        }else {
            //文本框内有文字个数等于0 进行相应操作
            commitButton.isEnabled = false
            placeholderLabel.isHidden = false
        }

    }



    func textViewDidChange(_ textView: UITextView) {
        if textView.text.lengthOfBytes(using: .utf8) > 0 {
            //文本框内有文字个数大于0 进行相应操作
           commitButton.isEnabled = true
           placeholderLabel.isHidden = true
        }else {
             //文本框内有文字个数等于0 进行相应操作
            commitButton.isEnabled = false
            placeholderLabel.isHidden = false
        }
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
            commitButton.isEnabled = false
        }else {
            placeholderLabel.isHidden = true
            commitButton.isEnabled = true
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {

        }
        return true
    }
}
