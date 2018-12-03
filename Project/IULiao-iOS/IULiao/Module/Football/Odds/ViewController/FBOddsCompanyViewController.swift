//
//  FBOddsCompanyViewController.swift
//  IULiao
//
//  Created by tianshui on 16/8/17.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol FBOddsCompanyViewControllerDelegate: class {
    func oddsCompanyViewController(companyDidChange companys: [CompanyModel], withOddsType oddsType: OddsType)
}

/// 公司筛选
class FBOddsCompanyViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: FBOddsCompanyViewControllerDelegate?
    
    private let europeComapnys = [
        CompanyModel(cid: 30, name: "bet 365"),
        CompanyModel(cid: 116, name: "bwin"),
        CompanyModel(cid: 442, name: "澳门"),
        CompanyModel(cid: 449, name: "立博"),
        CompanyModel(cid: 451, name: "威廉"),
        CompanyModel(cid: 454, name: "易胜博"),
        CompanyModel(cid: 893, name: "韦德")
    ]
    
    private let asiaComapnys = [
        CompanyModel(cid: 30, name: "bet 365"),
        CompanyModel(cid: 442, name: "澳门"),
        CompanyModel(cid: 449, name: "立博"),
        CompanyModel(cid: 454, name: "易胜博"),
        CompanyModel(cid: 893, name: "韦德")
    ]
    
    var dataSource = [CompanyModel]() {
        didSet {
            doneButton.isEnabled = dataSource.filter({ $0.isSelected }).count > 0
        }
    }
    
    var selectCompanys = [CompanyModel]()
    var oddsType = OddsType.europe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (UIScreen.main.bounds.width - 20) / 3
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: width, height: 44)

        if oddsType == .europe {
            segmentedControl.selectedSegmentIndex = 0
            dataSource = europeComapnys
        } else {
            segmentedControl.selectedSegmentIndex = 1
            dataSource = asiaComapnys
        }
        
        selectCompanys.forEach { (company) in
            if let index = dataSource.index(where: { $0 == company }) {
                dataSource[index].isSelected = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    static func instanceOddsCompanyViewController() -> FBOddsCompanyViewController {
        return UIViewController.viewControllerWithStoryboardName("FBOdds", viewControllerIdentifier: "FBOddsCompanyViewController") as! FBOddsCompanyViewController
    }
}

extension FBOddsCompanyViewController {
    
    @IBAction func oddsTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dataSource = europeComapnys
            oddsType = .europe
        } else {
            dataSource = asiaComapnys
            oddsType = .asia
        }
        collectionView.reloadData()
    }
    @IBAction func onClickDoneButton(_ sender: UIBarButtonItem) {
        let changeCompanys = dataSource.filter({ $0.isSelected })
        delegate?.oddsCompanyViewController(companyDidChange: changeCompanys, withOddsType: oddsType)
        TSCompanyHelper.setLastOddsType(oddsType)
        TSCompanyHelper.setLastCompanys(changeCompanys)
        let _ = navigationController?.popViewController(animated: true)
    }
}

extension FBOddsCompanyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FBOddsCompanyCollectionCell.reuseCollectionViewCellIdentifier, for: indexPath) as! FBOddsCompanyCollectionCell
        let company = dataSource[(indexPath as NSIndexPath).item]
        cell.configCell(company: company)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let company = dataSource[(indexPath as NSIndexPath).item]
        dataSource[(indexPath as NSIndexPath).item].isSelected = !company.isSelected
        collectionView.reloadItems(at: [indexPath])
    }
}
