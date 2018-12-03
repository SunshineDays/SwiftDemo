//
//  FBPlayerDetailViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/15.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

protocol FBPlayerDetailViewControllerDelegate: class {

    /// 获取到用户信息
    func playerDetailViewController(_ ctrl: FBPlayerDetailViewController, didFetchPlayerDetail detail: FBPlayerDetailModel)

}

/// 球员 详情
class FBPlayerDetailViewController: TSEmptyViewController, FBPlayerViewControllerProtocol {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var playerDetailTeamView: FBPlayerDetailTeamView!
    @IBOutlet weak var playerDetailInfoView: FBPlayerDetailInfoView!
    @IBOutlet weak var playerDetailSkillView: FBPlayerDetailSkillView!
    @IBOutlet weak var playerDetailTransferView: FBPlayerDetailTransferView!
    @IBOutlet weak var playerDetailTransferTableView: UIView!
    
    @IBOutlet weak var playerDetailTeamViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerDetailTransferTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerDetailTransferViewHeightConstraint: NSLayoutConstraint!
    
    var playerId: Int!
    var contentScrollView: UIScrollView {
        return scrollView
    }
    
    weak var delegate: FBPlayerDetailViewControllerDelegate?
    
    private var transferList = [FBPlayerDetailModel.Transfer]() {
        didSet {
            if transferList.count > 0 {
                playerDetailTransferTableViewHeightConstraint.constant = 34 + CGFloat(transferList.count) * 60
            } else {
                playerDetailTransferTableView.isHidden = true
                playerDetailTransferTableViewHeightConstraint.constant = 0
            }
            tableView.reloadData()
        }
    }
    private let playerHandler = FBPlayerHandler()
    /// 请求是否失败
    override var isRequestFailed: Bool {
        didSet {
            contentView.isHidden = isRequestFailed
            scrollView.reloadEmptyDataSet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initNetwork()
    }

    override func getData() {
        hud.show(animated: true)
        playerHandler.getDetail(
            playerId: playerId,
            success: {
                detail in
                self.setupDetailData(detail: detail)
                self.hud.hide(animated: true)
                self.isRequestFailed = false
        },
            failed: {
                error in
                self.hud.hide(animated: true)
                self.isRequestFailed = true
        })
    }
    
}

extension FBPlayerDetailViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
    }
    
    private func initNetwork() {
        getData()
    }
    
    /// 根据数据配置view 并对view显示隐藏
    private func setupDetailData(detail: FBPlayerDetailModel) {
        delegate?.playerDetailViewController(self, didFetchPlayerDetail: detail)
        
        transferList = detail.transferList

        playerDetailTeamView.configView(club: detail.clubInfo)
        playerDetailTeamViewConstraint.constant = detail.clubInfo.name.isEmpty ? 0 : 56
        
        playerDetailInfoView.configView(detail: detail)
        playerDetailSkillView.configView(skill: detail.skill)
        if detail.transferList.isEmpty {
            playerDetailTransferView.isHidden = true
            playerDetailTransferViewHeightConstraint.constant = 0
        } else {
            playerDetailTransferView.configView(detail: detail)
        }
    }
    
}

extension FBPlayerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transferList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbPlayerDetailTransferTableCell, for: indexPath)!
        let transfer = transferList[indexPath.row]
        cell.configCell(transfer: transfer, isCurretTeam: indexPath.row == transferList.count - 1)
        return cell
    }
}

extension FBPlayerDetailViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -32
    }
}
