//
//  SLLeagueFilterViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/10.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞技彩 联赛筛选代理
protocol SLLeagueFilterViewControllerDelegate: class {
    
    /// 确定按钮点击
    func leagueFilterViewControllerConfirmButtonClick(_ ctrl: SLLeagueFilterViewController, selectedLeagueList: [SportLotteryLeagueModel])
    /// 取消按钮点击
    func leagueFilterViewControllerCancelButtonClick(_ ctrl: SLLeagueFilterViewController)
}


/// 竞技彩 联赛筛选
class SLLeagueFilterViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    /// 定制按钮 足球可以是5大联赛,篮球可以是nba
    @IBOutlet weak var customBtn: UIButton!
    
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    /// 每行的个数
    private let collectionViewRowItems = 3
    private let collectionCellHeight: CGFloat = 35
    
    var allLeagueList = [SportLotteryLeagueModel]()
    var selectedLeagueList = [SportLotteryLeagueModel]()
    /// 定制的联赛 点击定制按钮后会筛选保留此数组中的联赛
    var customLeagueList = [SportLotteryLeagueModel]()
    
    weak var delegate: SLLeagueFilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let collectionViewHeight = ceil(CGFloat(allLeagueList.count) / CGFloat(collectionViewRowItems)) * collectionCellHeight
        let contentViewMaxHeight: CGFloat = 40 + 60 + collectionViewHeight + 2 * 5 + 15 + 40
        let offset = (view.height - contentViewMaxHeight) / 2
        if offset > contentViewTopConstraint.constant {
            contentViewTopConstraint.constant = offset
            contentViewBottomConstraint.constant = offset
        }
    }


}

extension SLLeagueFilterViewController {
    private func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.slConfirmSerialCollectionCell)
        
        // 都不选为全选
        if selectedLeagueList.count == allLeagueList.count {
            selectedLeagueList = []
        }
    }
}

extension SLLeagueFilterViewController {
    
    @IBAction func selectedAllBtnAction(_ sender: UIButton) {
        selectedLeagueList = allLeagueList
        collectionView.reloadData()
    }
    
    @IBAction func reverseBtnAction(_ sender: UIButton) {
        let reverseList = allLeagueList.filter {
            league in
            return !selectedLeagueList.contains(where: { $0.name == league.name })
        }
        selectedLeagueList = reverseList
        collectionView.reloadData()
    }
    
    @IBAction func customBtnAction(_ sender: UIButton) {
        let leagueList = allLeagueList.filter {
            league in
            return customLeagueList.contains(where: { $0.name == league.name })
        }
        selectedLeagueList = leagueList
        collectionView.reloadData()
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        delegate?.leagueFilterViewControllerCancelButtonClick(self)
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        delegate?.leagueFilterViewControllerConfirmButtonClick(self, selectedLeagueList: selectedLeagueList)
    }
}

extension SLLeagueFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLeagueList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.slConfirmSerialCollectionCell, for: indexPath)!
        let league = allLeagueList[indexPath.row]
        cell.serialBtn.setTitle(league.name, for: .normal)
        cell.isChecked = selectedLeagueList.contains(where: { $0.name == league.name })
        
        cell.serialBtnClickBlock = {
            [weak self] btn, isCheked in
            guard let me = self else {
                return
            }
            if isCheked {
                me.selectedLeagueList.append(league)
            } else {
                if let index = me.selectedLeagueList.index(where: { $0.name == league.name }) {
                    me.selectedLeagueList.remove(at: index)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.width - CGFloat(collectionViewRowItems - 1) * 10) / CGFloat(collectionViewRowItems))
        return CGSize(width: width, height: collectionCellHeight)
    }
}
