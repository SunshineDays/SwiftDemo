//
//  UserRegisterViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户注册 普通
class UserRegisterViewController: BaseTableViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeButton: UserCodeMessageButton!
 
    @IBOutlet weak var agreementButton: UIButton!
    
    typealias DissmissBlock = () -> Void
    
    public var dissmissBlock: DissmissBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        agreementButton.setBackgroundColor(UIColor.gray, forState: .normal)
        agreementButton.setBackgroundColor(UIColor.logo, forState: .selected)
        agreementButton.setImage(nil, for: .normal)
        agreementButton.setImage(R.image.user.agreement(), for: .selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 键盘需要标题
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 键盘不需要标题
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
}


extension UserRegisterViewController {
    private func getAuthCodeData() {
        MBProgressHUD.showProgress(toView: view)
        UserSMSHandler().sendCode(phone: phoneTextField.text!, smsType: .register, success: { [weak self] (phone, alreadyRegister, authCode) in
            MBProgressHUD.hide(from: self?.view)
            MBProgressHUD.show(success: "短信发送成功")
            self?.codeTextField.text = authCode
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.codeButton.countdownTimer?.invalidate()
            self?.codeButton.countdownTimer = nil
            self?.codeButton.remainingSeconds = 0
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
    
    private func postRegisterData() {
        MBProgressHUD.showProgress(toView: view)
        UserRegisterHandler().register(phone: phoneTextField.text!,
                                       authCode: codeTextField.text!,
                                       password: passwordTextField.text!,
                                       nickname: nicknameTextField.text!,
                                       success: { [weak self] (userInfo) in
            self?.postLoginData()
        }) { [weak self](error) in
            MBProgressHUD.hide(from: self?.view)
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
    
    private func postLoginData() {
        UserLoginHandler().login(phone: phoneTextField.text!,
                                 password: passwordTextField.text!,
                                 success: { [weak self] (userInfoModel) in
            MBProgressHUD.hide(from: self?.view)
            if let block = self?.dissmissBlock {
                block()
            }
            self?.dismiss(animated: true, completion: nil)
            CRToast.showNotification(with: "注册成功", colorStyle: .success)
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.dismiss(animated: true, completion: nil)
            MBProgressHUD.show(success: "注册成功，请返回登录")
        }
    }
}

extension UserRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        register(UIButton())
        return true
    }
}

extension UserRegisterViewController {
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 获取验证码
    @IBAction func authCodeClick(_ sender: UIButton) {
        view.endEditing(true)
        if !(phoneTextField.text ?? "").isPhone() {
            MBProgressHUD.show(info: "请输入正确的手机号码")
            phoneTextField.becomeFirstResponder()
        } else {
            codeButton.isCounting = true
            getAuthCodeData()
        }
    }

    @IBAction func register(_ sender: UIButton) {
        view.endEditing(true)
        view.endEditing(true)
        if !(phoneTextField.text ?? "").isPhone() {
            MBProgressHUD.show(info: "请输入正确的手机号码")
            phoneTextField.becomeFirstResponder()
        } else if (codeTextField.text ?? "").isEmpty {
            MBProgressHUD.show(info: "请输入验证码")
            codeTextField.becomeFirstResponder()
        } else if (nicknameTextField.text ?? "").isEmpty {
            MBProgressHUD.show(info: "请输入昵称")
            nicknameTextField.becomeFirstResponder()
        } else if (passwordTextField.text ?? "").count < 6 {
            MBProgressHUD.show(info: "密码不能少于六位")
            passwordTextField.becomeFirstResponder()
        } else if !agreementButton.isSelected {
            MBProgressHUD.show(info: "请阅读并同意《有料预测用户协议》")
        } else {
            postRegisterData()
        }
    }
    
    @IBAction func agreementButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
