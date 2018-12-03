//
//  UserFeedbackViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/3.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户反馈
class UserFeedbackViewController: BaseTableViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    let feedbackHandler = UserFeedbackHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func submitClick(_ sender: UIButton) {
        view.endEditing(true)
        
        let content = contentTextView.text ?? ""
        if content.count < 5 {
            TSToast.showNotificationWithMessage("最小输入五个字符", colorStyle: .error)
            contentTextView.becomeFirstResponder()
            return
        }
        
        let phone = phoneTextField.text ?? ""
        if phone.count > 0 {
            let check = UserRegisterHandler.check(phone: phone)
            if !check.isValid {
                TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
                phoneTextField.becomeFirstResponder()
                return
            }
        }
        
        hud.show(animated: true)
        feedbackHandler.feedback(
            content: content,
            phone: phoneTextField.text,
            success: {
                id in
                TSToast.showNotificationWithMessage("反馈成功", colorStyle: .success)
                self.submitBtn.isEnabled = false
                self.submitBtn.setTitle("反馈成功", for: .normal)
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })
        
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    // 去除tableview 分割线不紧挨着左边
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
}

extension UserFeedbackViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        placeholderLabel.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.text.count > 0
    }
}
