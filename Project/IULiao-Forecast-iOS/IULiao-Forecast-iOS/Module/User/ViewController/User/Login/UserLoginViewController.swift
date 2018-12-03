//
//  UserLoginViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户登录
class UserLoginViewController: BaseViewController {
    
    @IBOutlet weak var logoImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var appNameLabelBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let loginHandler = UserLoginHandler()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Screen.currentWidth == Screen.iPhoneWidth.five {
            logoImageViewWidthConstraint.constant = 80
            appNameLabelBottomConstraint.constant = 40
        }
        
        phoneTextField.placeholder(color: UIColor.white, font: 12)
        passwordTextField.placeholder(color: UIColor.white, font: 12)
        passwordTextField.delegate = self
        initListener()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension UserLoginViewController {

    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(close), name: UserNotification.userLoginSuccessful.notification, object: nil)
    }
    
    /// 普通登录
    func postLoginData() {
        MBProgressHUD.showProgress(toView: view)
        loginHandler.login(phone: phoneTextField.text!, password: passwordTextField.text!, success: { [weak self] (userInfoModel) in
            MBProgressHUD.hide(from: self?.view)
            self?.dismiss(animated: true, completion: nil)
            CRToast.showNotification(with: "登录成功", colorStyle: .success)
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
}


extension UserLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginClick(UIButton())
        return true
    }
}

extension UserLoginViewController {
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 登录
    @IBAction func loginClick(_ sender: UIButton) {
        view.endEditing(true)
        if !(phoneTextField.text ?? "").isPhone() {
            MBProgressHUD.show(info: "请输入正确的手机号码")
        } else if (passwordTextField.text ?? "").isEmpty {
            MBProgressHUD.show(info: "请输入密码")
        } else {
            postLoginData()
        }
    }
    
    /// 验证码登录
    @IBAction func authCodeLoginClick(_ sender: UIButton) {
        let vc = R.storyboard.userLogin.userLoginAuthCodeController()!
        vc.dissmissBlock = {
            self.dismiss(animated: true, completion: nil)
        }
        let navi = BaseNavigationController(rootViewController: vc)
        
        present(navi, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonClick(_ sender: UIButton) {
        let vc = R.storyboard.userLogin.userRegisterViewController()!
        vc.dissmissBlock = {
            self.dismiss(animated: true, completion: nil)
        }
        let navi = BaseNavigationController(rootViewController: vc)
        present(navi, animated: true, completion: nil)
    }
    
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

