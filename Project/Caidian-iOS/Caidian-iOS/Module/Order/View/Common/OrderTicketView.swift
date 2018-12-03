//
//  OrderTicketView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 订单 出票信息
class OrderTicketView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var statueImageView: UIImageView!
    
    static let defaultHeight: CGFloat = 90
    
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
    
    // 375 * 60
    private func initViewFromNib() {
        contentView = R.nib.orderTicketView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    func configView(order: OrderModel) {
        
        var image = R.image.order.statusWaitTicket()!
        switch order.revokeStatus {
        case .normal:
            switch order.ticketStatus {
            case .none: image = R.image.order.statusWaitTicket()!
            case .inProcess: fallthrough
            case .failed: image = R.image.order.statusTicketIng()!
            case .success:
                switch order.winStatus {
                case .notOpen: image = R.image.order.statusWaitOpen()!
                case .lost: image = R.image.order.statusNotHit()!
                case .win:
                    switch order.sendPrize {
                    case .notSend: image = R.image.order.statusWaitSend()!
                    case .alreadySend: image = R.image.order.statusAlreadySend()!
                    }
                }
            }
        default:
            image = R.image.order.statusRevoke()!
        }
        statueImageView.image = image
    }
    
}
