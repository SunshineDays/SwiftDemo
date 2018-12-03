//
//  UserFeedbackViewController.swift
//  IULiao-Forecast-iOS
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
            MBProgressHUD.show(info: "最少输入五个字符")
            contentTextView.becomeFirstResponder()
            return
        }
        
        let phone = phoneTextField.text ?? ""
        if phone.count > 0 {
            let check = UserRegisterHandler.check(phone: phone)
            if !check.isValid {
                MBProgressHUD.show(info: check.msg)
                phoneTextField.becomeFirstResponder()
                return
            }
        }
        
        MBProgressHUD.showProgress(toView: view)
        
        feedbackHandler.feedback(
            content: content,
            phone: phoneTextField.text,
            success: {
                id in
                MBProgressHUD.hide(from: self.view)
                MBProgressHUD.show(success: "反馈成功")
                self.submitBtn.isEnabled = false
                self.submitBtn.setTitle("反馈成功", for: .normal)
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
        
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
