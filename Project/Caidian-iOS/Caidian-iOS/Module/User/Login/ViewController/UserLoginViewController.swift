//
//  UserLoginViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

private let kUserRegisterThirdSegue = "UserRegisterThirdSegue"

/// 用户登录
class UserLoginViewController: BaseViewController {

    @IBOutlet weak var phoneTextField1: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var phoneTextField2: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeButton: UserCodeMessageButton!

    @IBOutlet weak var agreementBtn: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneCodeImageView: UIImageView!
    @IBOutlet weak var codeImageView: UIImageView!

    var loginMode = LoginMode.password
    let smsHandler = UserSMSHandler()
    let loginHandler = UserLoginHandler()

    enum LoginMode {
        case password, code

        var showText: String {
            switch self {
            case .password: return "手机验证码登录"
            case .code: return "密码登录"
            }
        }

        mutating func nextMode() {
            switch self {
            case .password: self = .code
            case .code: self = .password
            }
        }
    }


//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initListener()
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func agreementClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        loginBtn.isEnabled = sender.isSelected
    }

    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    /// 登录方式切换
    @IBAction func loginModeChange(_ sender: UIButton) {
        view.endEditing(true)

        switch loginMode {
        case .password:
            phoneTextField2.text = phoneTextField1.text
        case .code:
            phoneTextField1.text = phoneTextField2.text
        }

        loginMode.nextMode()
        sender.setTitle(loginMode.showText, for: .normal)

        let width = TSScreen.currentWidth + 20

        UIView.animate(withDuration: 0.3, animations: {

            switch self.loginMode {
            case .password:
                self.passwordConstraint.constant = 0
                self.codeConstraint.constant = width
            case .code:
                self.passwordConstraint.constant = -width
                self.codeConstraint.constant = 0
            }
            self.loginView.layoutIfNeeded()
        })

    }

    // 获取验证码
    @IBAction func authCodeClick(_ sender: UIButton) {
        view.endEditing(true)

        let check = UserRegisterHandler.check(phone: phoneTextField2.text)
        if !check.isValid {
            TSToast.showText(view: view, text: check.msg, color: .error)
            phoneTextField2.becomeFirstResponder()
            return
        }
        codeButton.isCounting = true
        hud.show(animated: true)
        smsHandler.sendCode(
                phone: phoneTextField2.text ?? "",
                smsType: .login,
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

    // 登录
    @IBAction func loginClick(_ sender: UIButton) {
        login()
    }

    // qq 登录
    @IBAction func loginQQClick(_ sender: UIButton) {
        login(thirdType: .qq)
    }

    // 微信 登录
    @IBAction func loginWechatClick(_ sender: UIButton) {
        login(thirdType: .wechat)
    }

    // 微博 登录
    @IBAction func loginWeiboClick(_ sender: UIButton) {
        login(thirdType: .weibo)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == kUserRegisterThirdSegue {
            return false
        }
        return true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension UserLoginViewController {

    func initView() {
        phoneImageView.tintColor = UIColor.grayGamut.gamut666666
        passwordImageView.tintColor = UIColor.grayGamut.gamut666666
        phoneCodeImageView.tintColor = UIColor.grayGamut.gamut666666
        codeImageView.tintColor = UIColor.grayGamut.gamut666666
        let color = UIColor(hex: 0x999999)
        phoneTextField1.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSAttributedStringKey.foregroundColor: color])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "请输入登录密码", attributes: [NSAttributedStringKey.foregroundColor: color])
        phoneTextField2.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSAttributedStringKey.foregroundColor: color])
        codeTextField.attributedPlaceholder = NSAttributedString(string: "请输入验证码", attributes: [NSAttributedStringKey.foregroundColor: color])

        passwordTextField.delegate = self
        codeTextField.delegate = self

    }

    private func initListener() {
        NotificationCenter.default.removeObserver(self)

        NotificationCenter.default.addObserver(self, selector: #selector(close), name: TSNotification.userLoginSuccessful.notification, object: nil)

    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    /// 三方登录
    func login(thirdType: UserThirdLoginType) {
        /*
        let platformType = thirdType.umSocialPlatformType
        UMSocialSwiftInterface.getUserInfo(plattype: platformType, viewController: self) {
            (response, error) in
            
            if let error = error {
                
                // 用户取消操作 不做提示
                if error.code != UMSocialPlatformErrorType.cancel.rawValue {
                    let message = (error.userInfo["message"] as? String) ?? error.localizedDescription
                    TSToast.showNotificationWithMessage(message, colorStyle: .error)
                }
            
                return
            }
            guard let response = response else {
                TSToast.showNotificationWithMessage("第三方登录失败", colorStyle: .error)
                return
            }
            
            let userOpenInfo = UserOpenModel(userInfo: response)
            UserLoginHandler.userOpenInfo = userOpenInfo
            
            self.loginHandler.loginThird(
                openInfo: userOpenInfo,
                success: self.loginSuccess,
                failed: self.loginFailed
            )
        }
 */
    }

    /// 普通登录
    func login() {
        view.endEditing(true)

        switch loginMode {
        case .password:
            let check = UserRegisterHandler.check(phone: phoneTextField1.text)
            if !check.isValid {
                TSToast.showText(view: view, text: check.msg, color: .error)
                phoneTextField1.becomeFirstResponder()
                return
            }
            guard let password = passwordTextField.text, password.count != 0 else {
                TSToast.showText(view: view, text: "请输入密码", color: .error)
                passwordTextField.becomeFirstResponder()
                return
            }


            hud.show(animated: true)
            loginHandler.login(
                    phone: phoneTextField1.text ?? "",
                    password: password,
                    success: loginSuccess,
                    failed: loginFailed
            )
        case .code:

            let check = UserRegisterHandler.check(phone: phoneTextField2.text)
            if !check.isValid {
                TSToast.showText(view: view, text: check.msg, color: .error)
                phoneTextField2.becomeFirstResponder()
                return
            }

            guard let authCode = codeTextField.text, authCode.count != 0 else {
                TSToast.showText(view: view, text: "请输入验证码", color: .error)
                codeTextField.becomeFirstResponder()
                return
            }

            hud.show(animated: true)

            loginHandler.login(
                    phone: phoneTextField2.text ?? "",
                    authCode: authCode,
                    success: loginSuccess,
                    failed: loginFailed
            )
        }

    }

    /// 登录成功
    func loginSuccess(userInfo: UserInfoModel) {
        //
        hud.hide(animated: true)
        dismiss(animated: true, completion: nil)
        TSToast.showText(view: view, text: "登录成功", color: .success)

    }

    /// 登录失败
    func loginFailed(error: NSError) {
        hud.hide(animated: true)

        if error.code == kTSRequestManagerUserThirdNeedRegisterCode {
            performSegue(withIdentifier: kUserRegisterThirdSegue, sender: self)
            return
        }
        TSToast.showText(view: view, text: error.localizedDescription, color: .error)
    }
}


extension UserLoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField, codeTextField:
            login()
        default:
            break
        }
        return true
    }

}

