//
//  OrderJczqDetailViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/7.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 订单 竞彩篮球
class OrderJclqDetailViewController: OrderSportDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        tableView.register(R.nib.orderJclqTableCell)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.orderJclqTableCell, for: indexPath)!
        let combination = matchList[indexPath.row]
        cell.configCell(
            match: combination.match as! JclqMatchModel,
            betKeyList: combination.betKeyList as! [JclqBetKeyType],
            isMustBet: combination.isMustBet,
            letScore: combination.letBall,
            dxfNum: combination.dxfNum
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = OrderMatchTableHeaderView()
        header.scoreLabelWidthConstraint.constant = 60
        header.leftTeamName.text = "客队"
        header.rightTeamLabel.text = "主队"
        header.scoreLabel.text = "比分/大小"
        return header
    }
    
}
