//
//  OrderJczqViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/7.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

protocol OrderViewControllerProtocol: class {
    var realHeight: CGFloat { get }
}

/// 订单 竞彩足球
class OrderDetailJczqViewController: UIViewController, OrderViewControllerProtocol {
    
    private let tableHeaderView = OrderMatchTableHeaderView()
    private let tableView = UITableView()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var tableViewHeight: CGFloat {
        return matchList.reduce(CGFloat(0)) {
            prev, combination -> CGFloat in
            let height: CGFloat = CGFloat(combination.betKeyList.count) * 14
            return prev + max(height, OrderJczqTableCell.defaultHeight)
        }
    }
    var realHeight: CGFloat {
        return tableViewHeight + 100
    }

    var matchList = [OrderDetailModel.MatchCombination]()
    var serialList = [SLSerialType]()
//    weak var delegate: OrderMainViewControllerDelegate?
    
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

extension OrderDetailJczqViewController {
    
    private func initView() {
        
        let offset: CGFloat = 10
        
        do {
            view.addSubview(tableView)
            view.addSubview(collectionView)
        }
        
        do {
            tableView.isScrollEnabled = false
            tableView.tableFooterView = UIView()
            tableView.allowsSelection = false
            tableView.register(R.nib.orderJczqTableCell)
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

extension OrderDetailJczqViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = CGFloat(matchList[indexPath.row].betKeyList.count) * 14
        return max(height, OrderJczqTableCell.defaultHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.orderJczqTableCell, for: indexPath)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return OrderMatchTableHeaderView.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }
}

extension OrderDetailJczqViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serialList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
}
