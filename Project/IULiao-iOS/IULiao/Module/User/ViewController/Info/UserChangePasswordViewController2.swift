//
//  UserChangePasswordViewController2.swift
//  IULiao
//
//  Created by tianshui on 2017/7/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

/// 用户修改密码 第二步
class UserChangePasswordViewController2: BaseTableViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
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
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            passwordTextField1.becomeFirstResponder()
            return
        }
        
        guard let password1 = passwordTextField1.text, let password2 = passwordTextField2.text, password1 == password2 else {
            TSToast.showNotificationWithMessage("两次输入的密码不相同", colorStyle: .error)
            passwordTextField2.becomeFirstResponder()
            return
        }
        
        hud.show(animated: true)
        
        secureHandler.changePassword(
            phone: phone,
            authCode: authCode,
            password: password1,
            success: {
                user in
                TSToast.showNotificationWithMessage("密码修改成功", colorStyle: .success)
                self.hud.hide(animated: true)
                self.navigationController?.popToRootViewController(animated: true)
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })
        
    }
}

extension UserChangePasswordViewController2: UITextFieldDelegate {
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
