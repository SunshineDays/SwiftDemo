//
//  UserGetPasswordViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

private let kUserGetPasswordSegue = "UserGetPasswordSegue"

/// 用户找回密码 第一步
class UserGetPasswordViewController: BaseTableViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var codeButton: UserCodeMessageButton!
    let smsHandler = UserSMSHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == kUserGetPasswordSegue {
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kUserGetPasswordSegue {
            if let vc = segue.destination as? UserGetPasswordViewController2, let phone = phoneTextField.text, let authCode = codeTextField.text {
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
            TSToast.showText(view: view, text: check.msg, color: .error)
            phoneTextField.becomeFirstResponder()
            return
        }
        codeButton.isCounting = true
        hud.show(animated: true)
        smsHandler.sendCode(
            phone: phoneTextField.text ?? "",
            smsType: .getPassword,
            success: {
                phone, alreadyRegister, authCode in
                TSToast.showText(view: self.view, text: "短信发送成功", color: .success)
                self.codeTextField.text = authCode
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.codeButton.countdownTimer?.invalidate()
                self.codeButton.countdownTimer = nil
                self.codeButton.remainingSeconds = 0
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                self.hud.hide(animated: true)
        })

    }
    
    /// 校验验证码
    @IBAction func checkCodeClick(_ sender: UIButton) {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(phone: phoneTextField.text)
        if !check.isValid {
            TSToast.showText(view: view, text: check.msg, color: .error)
            phoneTextField.becomeFirstResponder()
            return
        }
        
        guard let authCode = codeTextField.text, authCode.count != 0 else {
            TSToast.showText(view: view, text: "请输入验证码", color: .error)
            codeTextField.becomeFirstResponder()
            return
        }
        
        hud.show(animated: true)
        
        smsHandler.checkCode(
            phone: phoneTextField.text ?? "",
            authCode: authCode,
            smsType: .getPassword,
            success: {
                phone, alreadyRegister, smsType in
                
                self.hud.hide(animated: true)

                self.performSegue(withIdentifier: kUserGetPasswordSegue, sender: self)
                
        },
            failed: {
                error in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                self.hud.hide(animated: true)
        })

    }
}
