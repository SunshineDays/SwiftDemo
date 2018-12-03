//
//  UserLoginAuthCodeController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/20.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 手机验证码登录
class UserLoginAuthCodeController: UITableViewController {

    typealias DissmissBlock = () -> Void
    public var dissmissBlock: DissmissBlock?
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var authCodeTextField: UITextField!
    
    @IBOutlet weak var authCodeButton: UserCodeMessageButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension UserLoginAuthCodeController {
    private func getAuthCodeData() {
        MBProgressHUD.showProgress(toView: view)
        UserSMSHandler().sendCode(phone: phoneTextField.text!, smsType: .login, success: { [weak self] (phone, alreadyRegister, authCode) in
            MBProgressHUD.hide(from: self?.view)
            MBProgressHUD.show(success: "短信发送成功")
            self?.authCodeTextField.text = authCode
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.authCodeButton.countdownTimer?.invalidate()
            self?.authCodeButton.countdownTimer = nil
            self?.authCodeButton.remainingSeconds = 0
            MBProgressHUD.show(info: error.localizedDescription)
        }
    }
    
    private func postAuthCodeLoginData() {
        MBProgressHUD.showProgress(toView: view)
        UserLoginHandler().login(phone: phoneTextField.text!, authCode: authCodeTextField.text!, success: { [weak self] (infoModel) in
            MBProgressHUD.hide(from: self?.view)
            self?.dismiss(animated: true, completion: nil)
            if let block = self?.dissmissBlock {
                block()
            }
            CRToast.showNotification(with: "登录成功", colorStyle: .success)
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
}

extension UserLoginAuthCodeController {
    @IBAction func dissmissItemClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authCodeButtonClick(_ sender: UIButton) {
        if !(phoneTextField.text ?? "").isPhone() {
            MBProgressHUD.show(info: "请输入正确的手机号码")
            phoneTextField.becomeFirstResponder()
        } else {
            authCodeButton.isCounting = true
            getAuthCodeData()
        }
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        if !(phoneTextField.text ?? "").isPhone() {
            MBProgressHUD.show(info: "请输入正确的手机号码")
        } else if (authCodeTextField.text ?? "").isEmpty {
            MBProgressHUD.show(info: "请输入验证码")
        } else {
            postAuthCodeLoginData()
        }
    }
}
