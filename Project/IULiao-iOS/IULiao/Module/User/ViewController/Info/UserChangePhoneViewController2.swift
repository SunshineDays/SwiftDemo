//
//  UserChangePhoneViewController2.swift
//  IULiao
//
//  Created by tianshui on 2017/7/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

/// 用户修改手机 第二步
class UserChangePhoneViewController2: BaseTableViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    let smsHandler = UserSMSHandler()
    let secureHandler = UserSecureHandler()
    
    @IBOutlet weak var codeButton: UserCodeMessageButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
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
            smsType: .changePhone,
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
    
    /// 校验验证码
    @IBAction func checkCodeClick(_ sender: UIButton) {
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
        
        secureHandler.changePhone(
            phone: phoneTextField.text ?? "",
            authCode: authCode,
            success: {
                info in
                self.hud.hide(animated: true)
                TSToast.showNotificationWithMessage("手机号修改成功", colorStyle: .success)
                self.navigationController?.popToRootViewController(animated: true)
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })

    }
}
