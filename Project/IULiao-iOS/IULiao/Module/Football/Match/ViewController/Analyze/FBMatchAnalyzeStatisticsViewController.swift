//
//  FBMatchAnalyzeStatisticsViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析页 比赛统计
class FBMatchAnalyzeStatisticsViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let analyzeHandler = FBMatchAnalyzeHandler()
    private var dataSource = FBMatchAnalyzeEventModel(json: JSON.null)
    private var matchInfo = FBMatchModel(json: JSON.null)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }

    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        analyzeHandler.getEvent(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, event in
                self.isRequestFailed = false
                self.isLoadData = true
                self.dataSource = event
                self.matchInfo = match
                self.tableView.reloadData()
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.tableView.reloadData()
                self.hud.hide(animated: true)
        })
    }
    
}

extension FBMatchAnalyzeStatisticsViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func initNetwork() {
        getData()
    }
    
}

extension FBMatchAnalyzeStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoadData || dataSource.homeStatistics.ballTime == 0 {
            return 0
        }
        return 8
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        return 36
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let home = dataSource.homeStatistics
        let away = dataSource.awayStatistics
        var tableCell: UITableViewCell!
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeStatisticsBallTableCell, for: indexPath)!
            cell.configCell(homeCount: home.ballTime, awayCount: away.ballTime)
            tableCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeStatisticsNormalTableCell, for: indexPath)!
            switch row {
            case 1:
                cell.configCell(title: "射门", homeCount: home.shoot, awayCount: away.shoot)
            case 2:
                cell.configCell(title: "射正", homeCount: home.shootTarget, awayCount: away.shootTarget)
            case 3:
                cell.configCell(title: "犯规", homeCount: home.foul, awayCount: away.foul)
            case 4:
                cell.configCell(title: "角球", homeCount: home.corner, awayCount: away.corner)
            case 5:
                cell.configCell(title: "越位", homeCount: home.offside, awayCount: away.offside)
            case 6:
                cell.configCell(title: "黄牌", homeCount: home.yellowCard, awayCount: away.yellowCard)
            case 7:
                cell.configCell(title: "扑救", homeCount: home.save, awayCount: away.save)
            default:
                cell.configCell(title: "射门", homeCount: home.shoot, awayCount: away.shoot)
            }
            tableCell = cell
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if !isLoadData || dataSource.homeStatistics.ballTime == 0 {
            return 0
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !isLoadData || dataSource.homeStatistics.ballTime == 0 {
            return nil
        }
        let v = UIView()
        v.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = "*以上数据仅供参考，开奖结果以实际为准"
        label.textColor = TSColor.gray.gamut999999
        label.font = UIFont.systemFont(ofSize: 12)
        v.addSubview(label)
        label.snp.makeConstraints {
            make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        return v
    }
}


extension FBMatchAnalyzeStatisticsViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData && dataSource.homeStatistics.ballTime == 0
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}

