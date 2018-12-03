//
//  FBLeagueScheduleStageViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/24.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol FBLeagueScheduleStageViewControllerDelegate: class {
    /// 阶段选中
    func leagueScheduleStage(_ ctrl: FBLeagueScheduleStageViewController, selectStage stage: FBLeagueStageModel)
}

/// 联赛 赛事 阶段选择
class FBLeagueScheduleStageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FBLeagueScheduleStageViewControllerDelegate?
    
    var stageList = [FBLeagueStageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

}

extension FBLeagueScheduleStageViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}

extension FBLeagueScheduleStageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueScheduleStageTableCell, for: indexPath)!
        let stage = stageList[indexPath.row]
        cell.configCell(stage: stage)
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stage = stageList[indexPath.row]
        delegate?.leagueScheduleStage(self, selectStage: stage)
        navigationController?.popViewController(animated: true)
    }
    
}
