//
//  UserRegisterViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户注册 普通
class UserRegisterViewController: BaseTableViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeButton: UserCodeMessageButton!
   
 
    let smsHandler = UserSMSHandler()
    let registerHandler = UserRegisterHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
  
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    // 获取验证码
    @IBAction func authCodeClick(_ sender: UIButton) {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(phone: phoneTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            phoneTextField.becomeFirstResponder()
            return
        }
        codeButton.isCounting = true
        hud.show(animated: true)
        smsHandler.sendCode(
            phone: phoneTextField.text ?? "",
            smsType: .register,
            success: {
                phone, alreadyRegister, authCode in
                TSToast.showNotificationWithMessage("短信发送成功", colorStyle: .success)
                self.codeTextField.text = authCode
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.codeButton.countdownTimer?.invalidate()
                self.codeButton.countdownTimer = nil
                self.codeButton.remainingSeconds = 0
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })
        
    }
    
    // 明文密文切换
    @IBAction func passwordTextClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
        if !passwordTextField.isSecureTextEntry {
            passwordTextField.keyboardType = .asciiCapable
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        view.endEditing(true)
        
        var check = UserRegisterHandler.check(phone: phoneTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            phoneTextField.becomeFirstResponder()
            return
        }
        
        check = UserRegisterHandler.check(nickname: nicknameTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            nicknameTextField.becomeFirstResponder()
            return
        }
        
        check = UserRegisterHandler.check(password: passwordTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            passwordTextField.becomeFirstResponder()
            return
        }
        
        guard let authCode = codeTextField.text, authCode.count != 0 else {
            TSToast.showNotificationWithMessage("请输入验证码", colorStyle: .error)
            codeTextField.becomeFirstResponder()
            return
        }
        
        hud.show(animated: true)
        
        registerHandler.register(
            phone: phoneTextField.text ?? "",
            authCode: authCode,
            password: passwordTextField.text ?? "",
            nickname: nicknameTextField.text ?? "",
            success: {
                user in
                TSToast.showNotificationWithMessage("注册成功", colorStyle: .success)
                self.hud.hide(animated: true)
                self.dismiss(animated: true, completion: nil)
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })
    }
}

// MARK:- method
extension UserRegisterViewController {
    
    func initView() {
        nicknameTextField.delegate = self
        passwordTextField.delegate = self
    }
}


extension UserRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nicknameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            codeTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
