//
//  OrderJczqViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/7.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

protocol OrderDetailViewControllerProtocol: class {
    
    /// 真实高度
    var realHeight: CGFloat { get }
}

/// 订单 竞技彩 子类可重写部分方法以实现不同的订单
class OrderSportDetailViewController: UIViewController, OrderDetailViewControllerProtocol {
    
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
     let offset: CGFloat = 10
    /// 子类可重写获取真实高度
    var tableViewHeight: CGFloat {
        return matchList.reduce(OrderMatchTableHeaderView.defaultHeight) {
            prev, combination -> CGFloat in
            let height: CGFloat = CGFloat(combination.betKeyList.count) * OrderJczqTableCell.defaultBetLineHeight
            return prev + max(height, OrderJczqTableCell.defaultHeight)
        }
    }
    
    private let collectionViewRowItems = 6
    var collectionViewHeight: CGFloat {
        return OrderSerialCollectionCell.defaultHeight * ceil(CGFloat(serialList.count) / CGFloat(collectionViewRowItems))
    }
    /// 子类可重写获取真实高度
    var realHeight: CGFloat {
        let h1 = tableViewHeight > OrderMatchTableHeaderView.defaultHeight ? tableViewHeight + offset : 0
        let h2 = collectionViewHeight > 0 ? collectionViewHeight + offset : 0

        return h1 + h2 + offset
    }

    var matchList = [OrderDetailModel.MatchCombination]()
    var serialList = [SLSerialType]()
    var isSelectBoolean = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp.updateConstraints {
            make in
            make.height.equalTo(tableViewHeight)
        }
    }

}

extension OrderSportDetailViewController {
    
    private func initView() {
        
        do {
            view.addSubview(tableView)
            view.addSubview(collectionView)
        }
        
        do {
            tableView.isScrollEnabled = false
            tableView.tableFooterView = UIView()
            tableView.allowsSelection = false
            tableView.register(R.nib.orderJczqTableCell)
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.snp.makeConstraints {
                make in
                make.top.equalToSuperview().offset(offset)
                make.left.equalToSuperview().offset(offset)
                make.right.equalToSuperview().offset(-offset)
                make.height.equalTo(100)
            }
            
        }
        
        do {
            collectionView.isScrollEnabled = false
            collectionView.backgroundColor = UIColor.white
            collectionView.register(R.nib.orderSerialCollectionCell)
            collectionView.allowsSelection = false
            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.snp.makeConstraints {
                make in
                make.top.equalTo(tableView.snp.bottom).offset(offset)
                make.left.equalToSuperview().offset(offset)
                make.right.equalToSuperview().offset(-offset)
                make.height.equalTo(80)
            }
        }
    }
}

extension OrderSportDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = CGFloat(matchList[indexPath.row].betKeyList.count) * OrderJczqTableCell.defaultBetLineHeight
        return max(height, OrderJczqTableCell.defaultHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("子类必须实现此方法")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return OrderMatchTableHeaderView.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return OrderMatchTableHeaderView()
    }
}

extension OrderSportDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serialList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.orderSerialCollectionCell, for: indexPath)!
        cell.serialLabel.text = serialList[indexPath.row].displayName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(collectionView.width / CGFloat(collectionViewRowItems)), height: OrderSerialCollectionCell.defaultHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
