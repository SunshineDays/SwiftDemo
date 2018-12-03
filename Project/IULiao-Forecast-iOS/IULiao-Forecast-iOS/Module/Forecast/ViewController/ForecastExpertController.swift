//
//  ForecastExpertController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/14.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测专家页
class ForecastExpertController: BaseViewController {

    @IBOutlet weak var logoColorView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    
    @IBOutlet weak var keepWinButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var monadNumberLabel: UILabel!
    @IBOutlet weak var lookNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var infoModel: ForecastExpertModel! {
        didSet {
            configUserInfoView()
        }
    }
    
    private var historyModel: ForecastExpertHistoryModel!
    
    private var notOpenModels = [ForecastExpertHistoryListModel]()
    
    private var historyModels = [ForecastExpertHistoryListModel]()
    
    public var userId = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        logoColorView.backgroundColor = UIColor.logo
        initFollowButton()
        initTableView()
        MBProgressHUD.showProgress(toView: self.view)
        getExpertHistoryData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getExpertInfoData()
    }
    
    override func getData() {
        MBProgressHUD.showProgress(toView: self.view)
        getExpertInfoData()
        getExpertHistoryData()
    }
    
    override func refreshData() {
        getExpertInfoData()
    }
    
    /// 界面显示类型
    enum ShowType {
        /// 最新and历史
        case all
        /// 最新
        case new
        /// 历史
        case history
    }
}

extension ForecastExpertController {
    private func getExpertInfoData() {
        ForecastHandler().getExpertInfo(userId: userId, success: { [weak self] (userInfoModel) in
            MBProgressHUD.hide(from: self?.view)
            self?.infoModel = userInfoModel
            self?.showErrorView(false)
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.showErrorView(true)
        }
    }
    
    private func getExpertHistoryData(page: Int = 1) {
        ForecastHandler().getExpertHistory(userId: userId, page: page, success: { [weak self] (historyModel) in
            MBProgressHUD.hide(from: self?.view)
            self?.historyModel = historyModel
            if page == 1 {
                self?.notOpenModels.removeAll()
                self?.historyModels.removeAll()
            }
            self?.notOpenModels = (self?.notOpenModels ?? []) + historyModel.notOpenList
            self?.historyModels = (self?.historyModels ?? []) + historyModel.list

            self?.tableView.reloadData()
            self?.tableView.endRefreshing(dataSource: self?.historyModels, pageInfo: historyModel.pageInfo)
            self?.tableView(forEmptyDataSet: self?.tableView, isRequestSuccess: true)
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.tableView.endRefreshing()
            self?.tableView(forEmptyDataSet: self?.tableView, isRequestSuccess: false)
        }
    }
    
    private func showType() -> ShowType {
        switch (notOpenModels.count > 0, historyModels.count > 0) {
        case (true, true): return .all
        case (true, false): return .new
        case (false, true): return .history
        default: return .all
        }
    }
    
    private func postFollowData() {
        ForecastHandler().postCommentAttentionFollow(userId: userId, success: { [weak self] (json) in
            self?.followButton.isUserInteractionEnabled = true
            self?.followButton.isSelected = true
        }) { [weak self] (error) in
            self?.followButton.isUserInteractionEnabled = true
        }
    }
    
    private func postUnFollowData() {
        ForecastHandler().postCommentAttentionUnFollow(userId: userId, success: { [weak self] (json) in
            self?.followButton.isUserInteractionEnabled = true
            self?.followButton.isSelected = false
        }) { [weak self] (error) in
            self?.followButton.isUserInteractionEnabled = true
        }
    }
}

extension ForecastExpertController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch showType() {
        case .all: return 2
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch showType() {
        case .all:
            return section == 0 ? notOpenModels.count : historyModels.count
        case .new:
            return notOpenModels.count
        case .history:
            return historyModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastExpertCell, for: indexPath)!
        var model: ForecastExpertHistoryListModel?
        switch showType() {
        case .all:
            cell.isNotOpen = indexPath.section == 0
            model = indexPath.section == 0 ? notOpenModels[indexPath.row] : historyModels[indexPath.row]
        case .new:
            cell.isNotOpen = true
            model = notOpenModels[indexPath.row]
        case .history:
            cell.isNotOpen = false
            model = historyModels[indexPath.row]
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ForecastExpertHeaderInSectionView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 40))
        switch showType() {
        case .all:
            view.title = section == 0 ? "最新预测（\(notOpenModels.count)）" : "历史预测"
        case .new:
            view.title = "最新预测（\(notOpenModels.count)）"
        case .history:
            view.title = "历史预测"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.forecast.forecastDetailController()!
        switch showType() {
        case .all:
            vc.forecastId = indexPath.section == 0 ? notOpenModels[indexPath.row].forecast.id : historyModels[indexPath.row].forecast.id
        case .new:
            vc.forecastId = notOpenModels[indexPath.row].forecast.id
        case .history:
            vc.forecastId = historyModels[indexPath.row].forecast.id
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ForecastExpertController {
    @IBAction func followButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected ? postUnFollowData() : postFollowData()
    }
    
    @objc func headerRefresh() {
        getExpertHistoryData()
    }
    
    @objc private func footerRefresh() {
        getExpertHistoryData(page: historyModel.pageInfo.page + 1)
    }

}

extension ForecastExpertController {
    private func initFollowButton() {
        followButton.setTitle("+关注", for: .normal)
        followButton.setTitle("已关注", for: .selected)
        followButton.setTitleColor(UIColor.white, for: .normal)
        followButton.setTitleColor(UIColor.colour.gamutB3B3B3, for: .selected)
        followButton.setBackgroundColor(UIColor.logo, forState: .normal)
        followButton.setBackgroundColor(UIColor.clear, forState: .selected)
    }
    
    private func initTableView() {
        tableView.register(R.nib.forecastExpertCell)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.mj_header = BaseRefreshHeader(refreshingBlock: {
            self.getExpertHistoryData(page: 1)
        })
        tableView.mj_footer = BaseRefreshAutoFooter(refreshingBlock: {
            self.getExpertHistoryData(page: self.historyModel.pageInfo.page + 1)
        })
    }
    
    private func configUserInfoView() {
        avatarImageView.sd_setImage(
            with: URL(string: ImageURLHelper(string: infoModel.user.avatar, w: 100, h: 100).chop().urlString),
            placeholderImage: R.image.empty.avatar_100x100(), completed: nil)
        
        nicknameLabel.text = infoModel.user.nickname
        fansLabel.text = infoModel.user.follow.string
        keepWinButton.setTitle(infoModel.user.keepWin.string + "连红", for: .normal)
        keepWinButton.isHidden = infoModel.user.keepWin == 0
        
        monadNumberLabel.text = infoModel.user.win.string
//        lookNumberLabel.text = infoModel.user.hit.string
         lookNumberLabel.text = "1500"
        followButton.isSelected = infoModel.user.isAttention
        followButton.isHidden = infoModel.user.id == UserToken.shared.userInfo?.id
    }
}
