//
//  UserRegisterThirdViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

private let kUserRegisterThirdNicknameSegue = "UserRegisterThirdNicknameSegue"

/// 用户注册 第三方 绑定
class UserRegisterThirdViewController: BaseTableViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var codeButton: UserCodeMessageButton!
    let smsHandler = UserSMSHandler()
    let registerHandler = UserRegisterHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == kUserRegisterThirdNicknameSegue {
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kUserRegisterThirdNicknameSegue {
            if let vc = segue.destination as? UserRegisterThirdViewController2,
                let phone = phoneTextField.text, let authCode = codeTextField.text {
                vc.phone = phone
                vc.authCode = authCode
            }
        }
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
        
        hud.show(animated: true)
        codeButton.isCounting = true
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
    
    // 检查验证码
    @IBAction func checkAuthCodeClick(_ sender: UIButton) {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(phone: phoneTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            phoneTextField.becomeFirstResponder()
            return
        }
        
        guard let authCode = codeTextField.text, authCode.count != 0 else {
            TSToast.showNotificationWithMessage("请输入验证码", colorStyle: .error)
            codeTextField.becomeFirstResponder()
            return
        }
        
        hud.show(animated: true)
        
        smsHandler.checkCode(
            phone: phoneTextField.text ?? "",
            authCode: authCode,
            smsType: .register,
            success: {
                phone, alreadyRegister, smsType in
                
                self.hud.hide(animated: true)
                if alreadyRegister {
                    // 绑定
                    self.bind()
                } else {
                    // 修改昵称
                    self.performSegue(withIdentifier: kUserRegisterThirdNicknameSegue, sender: self)
                }
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })
    }
    
    // 绑定
    func bind() {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(phone: phoneTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            phoneTextField.becomeFirstResponder()
            return
        }
        
        guard let authCode = codeTextField.text, authCode.count != 0 else {
            TSToast.showNotificationWithMessage("请输入验证码", colorStyle: .error)
            codeTextField.becomeFirstResponder()
            return
        }
        
        guard let userOpenInfo = UserLoginHandler.userOpenInfo else {
            TSToast.showNotificationWithMessage("请先第三方登录", colorStyle: .error)
            return
        }
        
        hud.show(animated: true)
        
        
        registerHandler.registerThird(
            phone: phoneTextField.text ?? "",
            authCode: authCode,
            nickname: userOpenInfo.nickname,
            openInfo: userOpenInfo,
            success: {
                user in
                TSToast.showNotificationWithMessage("绑定成功", colorStyle: .success)
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
