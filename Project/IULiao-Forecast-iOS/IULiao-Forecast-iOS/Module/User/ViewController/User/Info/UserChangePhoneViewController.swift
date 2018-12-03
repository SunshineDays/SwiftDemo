//
//  UserChangePhoneViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/7/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

private let kUserChangePhoneSegue = "UserChangePhoneSegue"

/// 用户修改手机 第一步
class UserChangePhoneViewController: BaseTableViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var codeButton: UserCodeMessageButton!
    let smsHandler = UserSMSHandler()
    
    var phone: String? {
        return UserToken.shared.userInfo?.phone
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
        phoneTextField.text = UserToken.shared.userInfo?.secretPhone
    }
   
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == kUserChangePhoneSegue {
            return false
        }
        return true
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // 获取验证码
    @IBAction func authCodeClick(_ sender: UIButton) {
        view.endEditing(true)
        
        MBProgressHUD.showProgress(toView: view)
        codeButton.isCounting = true
        smsHandler.sendCode(
            phone: phone ?? "",
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
        
        guard let authCode = codeTextField.text, authCode.count != 0 else {
            MBProgressHUD.show(info: "请输入验证码")
            codeTextField.becomeFirstResponder()
            return
        }
        
        MBProgressHUD.showProgress(toView: view)
        
        smsHandler.checkCode(
            phone: phone ?? "",
            authCode: authCode,
            smsType: .changePhone,
            success: {
                phone, alreadyRegister, smsType in
                MBProgressHUD.hide(from: self.view)
                self.performSegue(withIdentifier: kUserChangePhoneSegue, sender: self)
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
        
    }
}
