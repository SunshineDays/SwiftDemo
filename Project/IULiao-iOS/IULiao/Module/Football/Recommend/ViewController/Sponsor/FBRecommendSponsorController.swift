//
//  FBRecommendSponsorController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 推荐方式选择
class FBRecommendSponsorController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        navigationItem.title = "发起推荐"
        initNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private let sponsorHandler = FBRecommendSponsorHandler()
    
    private var activityModel: FBRecommendSponsorActivityModel! = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableHeaderView: FBRecommendSponsorWayTitleView = {
        let view = R.nib.fbRecommendSponsorWayTitleView.firstView(owner: nil)!
        
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight), style: .plain)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.fbRecommendSponsorActivityCell)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        return tableView
    }()

}

// MARK: - Init
extension FBRecommendSponsorController {
    private func initNetwork() {
        hud.show(animated: true)
        getActivityData()
    }
}

// MARK: - Request
extension FBRecommendSponsorController {
    private func getActivityData() {
        sponsorHandler.getActivityData(success: { [weak self] (model) in
            self?.hud.hide(animated: true)
            self?.activityModel = model
        }) { [weak self] (error) in
            self?.hud.hide(animated: true)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendSponsorController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendSponsorActivityCell, for: indexPath)!
        cell.setupConfigView(model: activityModel.newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = activityModel.newsList[indexPath.row].id
        let vc = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
        vc.title = "比赛"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

