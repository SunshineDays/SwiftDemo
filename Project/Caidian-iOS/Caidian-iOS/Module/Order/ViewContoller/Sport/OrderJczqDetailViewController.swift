//
//  OrderJczqDetailViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/7.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 订单 竞彩足球
class OrderJczqDetailViewController: OrderSportDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        
        tableView.register(R.nib.orderJczqTableCell)

        if !isSelectBoolean {

            matchList.removeAll()

            collectionView.snp.makeConstraints {
                make in
                make.top.equalToSuperview().offset(offset)
                make.height.equalTo(collectionViewHeight)
            }
        }

    }
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.orderJczqTableCell, for: indexPath)!
        let combination = matchList[indexPath.row]
        cell.configCell(
            match: combination.match as! JczqMatchModel,
            betKeyList: combination.betKeyList as! [JczqBetKeyType],
            isMustBet: combination.isMustBet,
            letBall: Int(combination.letBall)
        )
        return cell
    }
    

}
