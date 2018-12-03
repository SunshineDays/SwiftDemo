//
//  UserChangePhoneViewController2.swift
//  IULiao-Forecast-iOS
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
            MBProgressHUD.show(info: check.msg)
            phoneTextField.becomeFirstResponder()
            return
        }
        
        MBProgressHUD.showProgress(toView: view)
        codeButton.isCounting = true
        smsHandler.sendCode(
            phone: phoneTextField.text ?? "",
            smsType: .changePhone,
            success: {
                phone, alreadyRegister, authCode in
                MBProgressHUD.hide(from: self.view)
                MBProgressHUD.show(success: "短信发送成功")
                self.codeTextField.text = authCode
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                self.codeButton.countdownTimer?.invalidate()
                self.codeButton.countdownTimer = nil
                self.codeButton.remainingSeconds = 0
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
        
    }
    
    /// 校验验证码
    @IBAction func checkCodeClick(_ sender: UIButton) {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(phone: phoneTextField.text)
        if !check.isValid {
            MBProgressHUD.show(info: check.msg)
            phoneTextField.becomeFirstResponder()
            return
        }
        
        guard let authCode = codeTextField.text, authCode.count != 0 else {
            MBProgressHUD.show(info: "请输入验证码")
            codeTextField.becomeFirstResponder()
            return
        }
        
        MBProgressHUD.showProgress(toView: view)
        secureHandler.changePhone(
            phone: phoneTextField.text ?? "",
            authCode: authCode,
            success: {
                info in
                MBProgressHUD.hide(from: self.view)
                MBProgressHUD.show(success: "手机号修改成功")
                self.navigationController?.popToRootViewController(animated: true)
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })

    }
}
