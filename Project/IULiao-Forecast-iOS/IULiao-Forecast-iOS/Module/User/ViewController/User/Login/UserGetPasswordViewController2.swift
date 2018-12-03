//
//  UserGetPasswordViewController2.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户找回密码 第二步
class UserGetPasswordViewController2: BaseTableViewController {
    
    @IBOutlet weak var passwordTextField1: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    
    var phone: String!
    var authCode: String!
    let secureHandler = UserSecureHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField1.delegate = self
        passwordTextField2.delegate = self
    }
    
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func changePasswordClick(_ sender: UIButton) {
        changePassword()
    }
    
    func changePassword() {
        view.endEditing(true)
        let check = UserRegisterHandler.check(password: passwordTextField1.text)
        if !check.isValid {
            MBProgressHUD.show(info: check.msg)
            passwordTextField1.becomeFirstResponder()
            return
        }
        
        guard let password1 = passwordTextField1.text, let password2 = passwordTextField2.text, password1 == password2 else {
            MBProgressHUD.show(info: "两次输入的密码不相同")
            passwordTextField2.becomeFirstResponder()
            return
        }
        
        MBProgressHUD.showProgress(toView: view)
        
        secureHandler.getPassword(
            phone: phone,
            authCode: authCode,
            password: password1,
            success: {
                user in
                MBProgressHUD.hide(from: self.view)
                MBProgressHUD.show(success: "修改成功")
                self.dismiss(animated: true, completion: nil)
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
        
    }
}

extension UserGetPasswordViewController2: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField1:
            passwordTextField2.becomeFirstResponder()
        case passwordTextField2:
            changePassword()
        default:
            break
        }
        return true
    }
}