//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析页 未来赛事
class FBMatchWarFutureViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    private var tableView = UITableView()
    private var homeToolbarView: FBMatchWarFutureToolbarView?
    private var awayToolbarView: FBMatchWarFutureToolbarView?
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let warHandler = FBMatchWarHandler()
    private var homeMatchList = [FBMatchWarModel]()
    private var awayMatchList = [FBMatchWarModel]()
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
        
        warHandler.getFutureMatch(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, home, away in
                self.isRequestFailed = false
                self.isLoadData = true
                self.homeMatchList = home
                self.awayMatchList = away
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

extension FBMatchWarFutureViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(R.nib.fbMatchWarFutureTableCell)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    private func initNetwork() {
        getData()
    }

}

extension FBMatchWarFutureViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoadData {
            return 0
        }
        return section == 0 ? homeMatchList.count : awayMatchList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchWarFutureTableCell, for: indexPath)!
        var match: FBMatchWarModel!
        var teamId: Int!
        if section == 0 {
            match = homeMatchList[row]
            teamId = matchInfo.homeTid
        } else {
            match = awayMatchList[row]
            teamId = matchInfo.awayTid
        }
        cell.configCell(match: match, teamId: teamId, needBackgroundColor: row % 2 == 0, matchTime: matchInfo.matchTime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        var match: FBMatchWarModel!
        if indexPath.section == 0 {
            match = homeMatchList[row]
        } else {
            match = awayMatchList[row]
        }
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: lottery, selectedTab: .war(.recent))
        navigationController?.pushViewController(ctrl, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return 0
        }
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return nil
        }
        
        var toolbarView: FBMatchWarFutureToolbarView!
        
        if section == 0 {
            if homeToolbarView == nil {
                homeToolbarView = R.nib.fbMatchWarFutureToolbarView.firstView(owner: nil)!
                homeToolbarView?.titleLabel.text = matchInfo.home
            }
            toolbarView = homeToolbarView
        } else {
            if awayToolbarView == nil {
                awayToolbarView = R.nib.fbMatchWarFutureToolbarView.firstView(owner: nil)!
                awayToolbarView?.titleLabel.text = matchInfo.away
            }
            toolbarView = awayToolbarView
        }
        return toolbarView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return 0
        }
        if section == 0 {
            return homeMatchList.count % 2 == 0 ? 10 : 20
        } else {
            return awayMatchList.count % 2 == 0 ? 10 : 20
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return nil
        }
        let v = UIView()
        let grayView = UIView()
        grayView.backgroundColor = UIColor(hex: 0xEDEDED)
        v.addSubview(grayView)
        grayView.snp.makeConstraints {
            make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        return v
    }
}

extension FBMatchWarFutureViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
