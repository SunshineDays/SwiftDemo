//
//  OrderBetInfoView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 订单投注详情
class OrderBetInfoView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    
    @IBOutlet weak var sendOrderPersonUIView: UIView!
    static let defaultHeight: CGFloat = 40
    
    @IBOutlet weak var isSecretLabel: UILabel!
    @IBOutlet weak var sendOrderPersonLabel: UILabel!
    @IBOutlet weak var isSecretUiView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentView = R.nib.orderBetInfoView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    func configView(orderDetailModel: OrderDetailModel ) {
        orderNumLabel.text = orderDetailModel.order.orderNum
        createTimeLabel.text = Date(timeIntervalSince1970: orderDetailModel.order.createTime).string()
        sendOrderPersonLabel.text = orderDetailModel.parent?.nickName
        
        
        // 跟单
        if  orderDetailModel.parent != nil {
            isSecretUiView.isHidden = false
            sendOrderPersonUIView.isHidden = false
            
            var content = "公开"
            switch orderDetailModel.parent?.isSecret {
            case 1 :
                content = "截止后公开"
            case 2:
                content = "跟单后可见"
            default:
                content = "公开"
            }
            isSecretLabel.text = content
          
        }else{
            isSecretUiView.isHidden = true
            sendOrderPersonUIView.isHidden = true
        }

    

    }
}
