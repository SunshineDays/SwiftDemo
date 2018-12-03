//
// Created by tianshui on 2017/11/30.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析 爆料
class FBMatchNewsViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let matchHandler = FBMatchNewsHandler()
    private var matchNews = FBMatchNewsModel(briefList: [], normalList: [])
    private var matchInfo = FBMatchModel(json: JSON.null)

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }
    
    private enum BriefType: Int, CustomStringConvertible {
        case brief = 0, news
        
        var description: String {
            switch self {
            case .brief:
                return "赛前简讯"
            case .news:
                return "相关新闻"
            }
        }
    }
    
    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        matchHandler.getNews(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, matchNews in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
                self.matchNews = matchNews
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

extension FBMatchNewsViewController {
    
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

extension FBMatchNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let type = BriefType(rawValue: section) ?? .brief
        switch type {
        case .brief:
            return matchNews.briefList.count
        case .news:
            return matchNews.normalList.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = BriefType(rawValue: indexPath.section) ?? .brief
        switch type {
        case .brief:
            return 150
        case .news:
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = BriefType(rawValue: indexPath.section) ?? .brief
        var tableCell: UITableViewCell?
        switch type {
        case .brief:
            let brief = matchNews.briefList[indexPath.row]
            if brief.teamId == matchInfo.homeTid {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchBriefHomeTableCell, for: indexPath)
                cell?.configCell(news: brief, teamLogo: matchInfo.homeLogo)
                tableCell = cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchBriefAwayTableCell, for: indexPath)
                cell?.configCell(news: brief, teamLogo: matchInfo.awayLogo)
                tableCell = cell
            }
        case .news:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchNewsTableCell, for: indexPath)
            cell?.configView(news: matchNews.normalList[indexPath.row])
            tableCell = cell
        }
        return tableCell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if matchNews.briefList.isEmpty {
                return 0
            }
        } else {
            if matchNews.normalList.isEmpty {
                return 0
            }
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if matchNews.briefList.isEmpty {
                return nil
            }
        } else {
            if matchNews.normalList.isEmpty {
                return nil
            }
        }
        let v = UIView()
        v.backgroundColor = UIColor.white
        let label = UILabel()
        let type = BriefType(rawValue: section) ?? .brief
        label.text = type.description
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = TSColor.gray.gamut333333
        v.addSubview(label)
        label.snp.makeConstraints {
            make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let type = BriefType(rawValue: section) ?? .brief
        if type == .brief && matchNews.briefList.count > 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let type = BriefType(rawValue: section) ?? .brief
        if type == .brief && matchNews.briefList.count > 0 {
            let v = UIView()
            v.backgroundColor = UIColor(hex: 0xeeeeee)
            return v
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let type = BriefType(rawValue: indexPath.section) ?? .brief
        if case .brief = type {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = BriefType(rawValue: indexPath.section) ?? .brief
        if case .news = type {
            let news = matchNews.normalList[indexPath.row]
            let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: news.id)
            navigationController?.pushViewController(ctrl, animated: true)
        }
        
    }
}

extension FBMatchNewsViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
