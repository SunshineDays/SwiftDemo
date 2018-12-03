//
//  FBLiveSelectFromTitleView.swift
//  IULiao
//
//  Created by DaiZhengChuan on 2018/5/14.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias FBLiveSelectFromTitleViewType = (_ selectedType: Lottery) -> Void

class FBLiveSelectFromTitleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        self.isUserInteractionEnabled = true
        collectionView.reloadData()
        addSubview(cancelButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initWith(selectedType: Lottery = .jingcai, typeBlock: @escaping FBLiveSelectFromTitleViewType) {
        for i in 0 ..< flagArray.count {
            flagArray[i] = dataSource[i] == selectedType
        }
        self.selectedType = selectedType
        selectedTypeBlock = typeBlock
    }
    
    private var selectedTypeBlock: FBLiveSelectFromTitleViewType!
    private var selectedType: Lottery = .jingcai
    
    private let dataSource: [Lottery] = [.all, .jingcai, .beidan, .sfc]
    private var flagArray = [false, true, false, false]
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: (TSScreen.currentWidth - 60) / 4, height: 30)
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 10, 15)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: 50), collectionViewLayout: flowLayout)
        collectionView.register(R.nib.fbRecommendSponsorMatchSelectCell)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        return collectionView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: collectionView.frame.maxY, width: TSScreen.currentWidth, height: height - 50))
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FBLiveSelectFromTitleView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchSelectCell, for: indexPath)!
        cell.setupConfigView(name: dataSource[indexPath.row].name, flag: flagArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0 ..< flagArray.count {
            flagArray[i] = i == indexPath.row
        }
        collectionView.reloadData()
        selectedType = dataSource[indexPath.row]
        selectedTypeBlock(selectedType)
        dismissView()
    }
}

// MARK: - Action
extension FBLiveSelectFromTitleView {
    @objc private func dismissView() {
        isHidden = true
    }
}
