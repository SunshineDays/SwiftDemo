//
//  UserLiaoController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/12.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit
import StoreKit

/// 我的料豆
class UserLiaoController: BaseViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var priceButtonsView: UIView!
    @IBOutlet weak var priceButtonsViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var agrrentButton: UIButton!
    
    private var model: UserLiaoRechargeModel! {
        didSet {
            selectedPriceModel = model.priceList.first
            configPriceButtonsView()
        }
    }
    
    private var selectedPriceModel: UserLiaoRechargePriceListModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        getData()
    }
    
    override func getData() {
        MBProgressHUD.showProgress(toView: view)
        getUserInfoData()
        requestProductID()
        getLiaoRechargeData()
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
}

extension UserLiaoController {
    private func getUserInfoData() {
        UserInfoHandler().detail(success: { [weak self] (userInfoModel) in
            self?.balanceLabel.text = userInfoModel.account.coin.string + " 料豆"
        }) { (error) in
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
    
    private func getLiaoRechargeData() {
        UserLiaoHandler().getLiaoRechargeData(success: { [weak self] (model) in
            MBProgressHUD.hide(from: self?.view)
            self?.showErrorView(false)
            self?.model = model
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.showErrorView(true)
        }
    }
    
    /// Apple重置成功后，和服务器进行验证
    private func postLiaoRechargeSuccess() {
        
    }
    
    
    func requestProductID(){
        if SKPaymentQueue.canMakePayments() {
            var productArr = [String]()
            productArr.append("com.iuliao.forecast.18")
            let sets:Set<String> = NSSet(array: productArr) as! Set<String>
            let skRequest = SKProductsRequest(productIdentifiers: sets)
            skRequest.delegate = self
            skRequest.start()
        } else {
            MBProgressHUD.show(info: "app不支持Apple Pay")
        }
        
       
    }
    
}

extension UserLiaoController {
    @objc private func selectedLiaoPriceButtonClick(_ sender: UserLiaoPriceButton) {
        for (index, view) in priceButtonsView.subviews.enumerated() {
            let m = model.priceList[index]
            if view is UserLiaoPriceButton {
                (view as! UserLiaoPriceButton).isSelected(price: m.money, liao: m.coin, gift: m.present, isSelected: index == sender.tag)
            }
        }
        selectedPriceModel = model.priceList[sender.tag]
//        showBuySuccessCtrl()
        requestWithAppleProduct()
    }
    
    @IBAction func agrrentButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    /// 请求Apple进行内购买
    private func requestWithAppleProduct() {
        if SKPaymentQueue.canMakePayments() {

            let request = SKProductsRequest(productIdentifiers: [(selectedPriceModel?.id.string)!])
            request.delegate = self
            request.start()
            MBProgressHUD.showProgress(toView: view)
        } else {
            MBProgressHUD.show(info: "app不支持Apple Pay")
        }
    }
    
    private func showBuySuccessCtrl() {
        let vc = R.storyboard.userLiao.userLiaoPaySuccessController()!
        let navi = BaseNavigationController(rootViewController: vc)
        present(navi, animated: true, completion: nil)
    }
}

// MARK：- SKProductsRequestDelegate
extension UserLiaoController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        MBProgressHUD.hide(from: view)
        if response.products.count > 0 {
            for product in response.products {
                if product.productIdentifier == selectedPriceModel?.id.string {
                    let payment = SKMutablePayment(product: product)
                    SKPaymentQueue.default().add(payment)
                    break
                }
            }
        } else {
            MBProgressHUD.show(info: "ProductID无效")
        }
    }
}

extension UserLiaoController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transcation in transactions {
            switch transcation.transactionState {
            case .purchased: //购买成功
                purchased(transcation)
            case .failed: //购买失败
                failed(transcation)
            case .restored: //恢复购买
                restored(transcation)
            case .purchasing: //正在处理
                break
            default:
                break
            }
        }
    }
    
    private func purchased(_ transcation: SKPaymentTransaction) {
        if let url = Bundle.main.appStoreReceiptURL {
            let receiptData = NSData(contentsOf: url)
            let receipt = receiptData?.base64EncodedString(options: .lineLength64Characters) ?? ""
            if !receipt.isEmpty && !transcation.payment.productIdentifier.isEmpty {
                MBProgressHUD.show(success: "支付成功")
                /// 可以将receipt发给服务器进行购买验证
            }
            SKPaymentQueue.default().finishTransaction(transcation)
        }
    }
    
    private func failed(_ transcation: SKPaymentTransaction) {
        if let localizedDescription = transcation.error?.localizedDescription {
            MBProgressHUD.show(info: localizedDescription)
        }
        SKPaymentQueue.default().finishTransaction(transcation)
    }
    
    private func restored(_ transcation: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transcation)
    }
    
}

extension UserLiaoController {
    private func configPriceButtonsView() {
        let buttonWidth = (priceButtonsView.width - 40) / 3
        let buttonHeight: CGFloat = 50
        let space: CGFloat = 10
        
        var priceButtonsViewHeight: CGFloat = 0
        for (index, m) in model.priceList.enumerated() {
            let button = UserLiaoPriceButton(frame: CGRect(x: space + (buttonWidth + space) * CGFloat(index % 3), y: (buttonHeight + space) * CGFloat(index / 3), width: buttonWidth, height: buttonHeight))
            button.isSelected(price: m.money, liao: m.coin, gift: m.present, isSelected: index == 0)
            button.tag = index
            button.addTarget(self, action: #selector(selectedLiaoPriceButtonClick(_:)), for: .touchUpInside)
            priceButtonsView.addSubview(button)
            priceButtonsViewHeight = button.frame.maxY + 10
        }
        priceButtonsViewHeightConstraint.constant = priceButtonsViewHeight
    }
    
}
