//
//  FBMatchAnalyzeEventViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析 赛况 比赛事件
class FBMatchAnalyzeEventViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

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
                self.matchInfo = match
                self.dataSource = event
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

extension FBMatchAnalyzeEventViewController {
    
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

extension FBMatchAnalyzeEventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.eventList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let event = dataSource.eventList[indexPath.row]
        switch event.type {
        case .stage:
            return 46
        case .substitute:
            return 85
        default:
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = dataSource.eventList[indexPath.row]
        var tableCell: UITableViewCell!
        
        switch event.type {
        case .stage:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeEventStageTableCell, for: indexPath)!
            tableCell = cell
        case .substitute:
            if event.team == .home {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeEventHomeSubstituteTableCell, for: indexPath)!
                cell.configCell(event: event)
                tableCell = cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeEventAwaySubstituteTableCell, for: indexPath)!
                cell.configCell(event: event)
                tableCell = cell
            }
        default:
            if event.team == .home {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeEventHomeNormalTableCell, for: indexPath)!
                cell.configCell(event: event)
                tableCell = cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeEventAwayNormalTableCell, for: indexPath)!
                cell.configCell(event: event)
                tableCell = cell
            }
        }
        
        return tableCell
    }
    
}

extension FBMatchAnalyzeEventViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2) - 5
    }
}
