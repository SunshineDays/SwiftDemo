//
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析页 指数 欧赔列表
class FBMatchOddsEuropeListViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    private var headerView: FBMatchOddsEuropeListHeaderView?
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let oddsHandler = FBMatchOddsHandler()
    private var oddsData = FBMatchOddsEuropeDataModel()
    private var oddsList: [FBOddsEuropeSetModel] {
        return oddsData.oddsList
    }
    private var matchInfo = FBMatchModel(json: JSON.null)
    private var selectedCellType = CellType.probability {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }

    enum CellType {
        case initOdds, probability, kelly, jingcai
    }
    
    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        oddsHandler.getEuropeList(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, oddsData in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
                self.oddsData = oddsData
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

extension FBMatchOddsEuropeListViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    private func initNetwork() {
        getData()
    }

}

extension FBMatchOddsEuropeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData || oddsList.isEmpty {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoadData  || oddsList.isEmpty {
            return 0
        }
        if section == 0 {
            return 3
        }
        return oddsList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 36
        }
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (row, section) = (indexPath.row, indexPath.section)
        let tableCell: UITableViewCell!
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchOddsEuropeListMostTableCell, for: indexPath)!
            var europe: FBOddsEuropeModel!
            var title = ""
            if row == 0 {
                europe = oddsData.maxOdds
                title = "最大值"
            } else if row == 1 {
                europe = oddsData.minOdds
                title = "最小值"
            } else {
                europe = oddsData.europe99Odds
                title = "平均值"
            }
            cell.configCell(title: title, europe: europe, index: row)
            tableCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchOddsEuropeListNormalTableCell, for: indexPath)!
            let europe = oddsList[row]
            cell.configCell(europe: europe, cellType: selectedCellType, europe99Odds: oddsData.europe99Odds, jingcaiOdds: oddsData.jingcaiOdds, needBackgroundColor: row % 2 == 0)
            tableCell = cell
        }
        return tableCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || oddsList.isEmpty {
            return 0
        }
        return 72
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || oddsList.isEmpty {
            return nil
        }
        
        if headerView == nil {
            let header = R.nib.fbMatchOddsEuropeListHeaderView.firstView(owner: nil)!
            header.btnClickBlock = {
                [weak self] btn, cellType in
                self?.selectedCellType = cellType
            }
            headerView = header
        }
        headerView?.configView(cellType: selectedCellType)
        return headerView
    }

    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            return
        }
        let europe = oddsList[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbMatchOddsEuropeCompanyViewController(matchId: matchId, companyId: europe.company.id, lottery: lottery)
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
}

extension FBMatchOddsEuropeListViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData && oddsList.isEmpty
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
