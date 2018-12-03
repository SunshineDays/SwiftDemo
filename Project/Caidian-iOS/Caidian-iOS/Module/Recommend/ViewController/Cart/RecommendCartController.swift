//
//  RecommendCartController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/9/10.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购物车
class RecommendCartController: BaseViewController {
    
    @IBOutlet weak var settingItem: UIBarButtonItem!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var matchNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectedAllButton: UIButton!
    @IBOutlet weak var selectedAllLabel: UILabel!
    
    @IBOutlet weak var betButton: UIButton!

    @IBOutlet weak var deleteButton: UIButton!
    
    private var cartEmptyView = R.nib.recommendCartEmptyView.firstView(owner: nil)!

    /// 选中要购买的
    private var selectedModels = [RecommendDetailModel]()
    
    private var dataSource = UserToken.shared.userCartInfos {
        didSet {
            if let dataSource = dataSource {
                bottomView.isHidden = dataSource.count == 0
                cartEmptyView.isHidden = dataSource.count != 0
                var number = 0
                /// 把已经选中要购买的选中（在viewWillApear中会清除掉选中状态）
                for (i, models) in dataSource.enumerated() {
                    for (j, model) in models.enumerated() {
                        var isExit = false
                        for selected in selectedModels {
                            if model.recommend.id == selected.recommend.id {
                                isExit = true
                                number += 1
                            }
                        }
                        dataSource[i][j].recommend.isSelectedToBuy = isExit
                    }
                }
                selectedBetNumber = number
            } else {
                bottomView.isHidden = true
                cartEmptyView.isHidden = false
            }
            matchNumber = dataSource?.count ?? 0
            tableView.reloadData()
        }
    }

    /// 是否全选(删除)
    private var isSelectedAll: Bool = false {
        didSet {
            selectedAllButton.isSelected = isSelectedAll
            if let dataSource = dataSource {
                for i in 0 ..< dataSource.count {
                    for j in 0 ..< dataSource[i].count {
                        dataSource[i][j].recommend.isSelectedToDelete = isSelectedAll
                    }
                }
            }
            tableView.reloadData()
        }
    }
    
    /// 比赛场数
    private var matchNumber = 0 {
        didSet {
            matchNumberLabel.text = "共\(matchNumber)场赛事"
        }
    }
    
    /// 选中的要投注的场次
    private var selectedBetNumber = 0 {
        didSet {
            betButton.setTitle("立即投注(\(selectedBetNumber))", for: .normal)
        }
    }
    
    /// 是否是在管理中（删除中）
    private var isSetting = false {
        didSet {
            settingItem.title = isSetting ? "完成" : "管理"
            betButton.isHidden = isSetting
            selectedAllButton.isHidden = !isSetting
            selectedAllLabel.isHidden = !isSetting
            deleteButton.isHidden = !isSetting
            isSelectedAll = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        wr_setNavBarShadowImageHidden(true)
        if #available(iOS 11.0, *) {
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        headerView.backgroundColor = UIColor.logo
        initTableView()
        initSelectedAllButton()
        initCartEmptyView()
        isSetting = false
        dataSource = UserToken.shared.userCartInfos
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = UserToken.shared.userCartInfos
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RecommendCartController {
    private func initTableView() {
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(R.nib.recommendCartCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    private func initSelectedAllButton() {
        selectedAllButton.setImage(R.image.cartSelectedDefault(), for: .normal)
        selectedAllButton.setImage(R.image.cartSelectedSelected(), for: .selected)
    }
    
    private func initCartEmptyView() {
        view.addSubview(cartEmptyView)
        cartEmptyView.snp.makeConstraints { (maker) in
            maker.top.left.bottom.right.equalToSuperview()
        }
        cartEmptyView.goToRecommendBlock = {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension RecommendCartController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.recommendCartCell, for: indexPath)!
        if let dataSource = dataSource {
            cell.tag = indexPath.section
            cell.delegate = self
            cell.logoView.backgroundColor = indexPath.section == 0 ? UIColor.logo : UIColor.clear
            cell.configCell(models: dataSource[indexPath.section], isSetting: isSetting, selectedSection: indexPath.section)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let dataSource = dataSource {
            var height: CGFloat = 32.5
            let models = dataSource[indexPath.section]
            for model in models {
                let text = TSPublicTool.footballCodeString(betKeyTypes: model.recommend.code, letBall: model.recommend.odds.letBall)
                let textHeight = TSPublicTool.textHeight(text: text, width: TSScreen.currentWidth - 40 - 60, font: UIFont.systemFont(ofSize: 12))
                let viewHeight = 45 + textHeight + 15
                height = height + viewHeight
                height += 1.pixel
            }
            return height - 1.pixel
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}

extension RecommendCartController: RecommendCartCellDelegate {
    /// 选中要跳转的
    func recommendCartCell(_ cell: RecommendCartCell, selectedRecommendId: Int) {
        if !isSetting {
            let vc = R.storyboard.recommend.recommendDetailController()!
            vc.recommendId = selectedRecommendId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /// 选中要购买的
    func recommendCartCell(_ cell: RecommendCartCell, isSelectedToBuy: Bool, selectedIndexPath: IndexPath) {
        /// 一个比赛只能选择一个推荐
        for i in 0 ..< dataSource![selectedIndexPath.section].count {
            dataSource![selectedIndexPath.section][i].recommend.isSelectedToBuy = false
        }
        dataSource![selectedIndexPath.section][selectedIndexPath.row].recommend.isSelectedToBuy = isSelectedToBuy
        for i in 0 ..< dataSource![selectedIndexPath.section].count {
            print(dataSource![selectedIndexPath.section][i].recommend.isSelectedToBuy)
        }
        if let dataSource = dataSource {
            var number = 0
            for models in dataSource {
                for model in models {
                    if model.recommend.isSelectedToBuy {
                        number += 1
                    }
                }
            }
            selectedBetNumber = number
        }
        tableView.reloadData()
    }
    
    /// 选中要删除的
    func recommendCartCell(_ cell: RecommendCartCell, isSelectedToDelete: Bool, selectedIndexPath: IndexPath) {
        dataSource![selectedIndexPath.section][selectedIndexPath.row].recommend.isSelectedToDelete = isSelectedToDelete
        tableView.reloadData()
    }
}

extension RecommendCartController {
    /// 立即投注
    @IBAction func betAction(_ sender: UIButton) {
        var buyModels = [RecommendDetailModel]()
        if let dataSource = dataSource {
            for models in dataSource {
                for model in models {
                    if model.recommend.isSelectedToBuy {
                        buyModels.append(model)
                    }
                }
            }
        }
        selectedModels = buyModels
        
        if selectedModels.count > 0 {
            let vc = TSEntryViewControllerHelper.lotteryViewController(lottery: .jczq, playType: .hh, recommendModels: selectedModels)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            MBProgressHUD.show(info: "请至少选择一场比赛")
        }
    }
    
    /// 管理
    @IBAction func settingAction(_ sender: UIBarButtonItem) {
        isSetting = !isSetting
    }
    
    /// 全选
    @IBAction func selectedAllAction(_ sender: UIButton) {
        selectedAllButton.isSelected = !selectedAllButton.isSelected
        isSelectedAll = selectedAllButton.isSelected
    }
    
    /// 删除
    @IBAction func deleteAction(_ sender: UIButton) {
        var selectedDeleteModels = [RecommendDetailModel]()
        if let dataSource = dataSource {
            for models in dataSource {
                for model in models {
                    if model.recommend.isSelectedToDelete {
                        selectedDeleteModels.append(model)
                    }
                }
            }
        }
        UserToken.shared.deleteFromCart(models: selectedDeleteModels)
        dataSource = UserToken.shared.userCartInfos
        isSelectedAll = false
    }
}


