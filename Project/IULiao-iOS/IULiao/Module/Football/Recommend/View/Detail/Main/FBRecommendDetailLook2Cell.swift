//
//  FBRecommendDetailLook2Cell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/20.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 用户浏览记录
class FBRecommendDetailLook2Cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var lookNumberLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setupConfigView(imageList: [FBRecommendDetailLookModel], pageInfoModel: FBRecommendDetailPageInforModel) {
        self.imageList = imageList
        self.pageInfoModel = pageInfoModel
    }
    
    var imageList: [FBRecommendDetailLookModel]! = nil {
        didSet {
            collectionView.register(R.nib.fbRecommendDetailLookCell)
            collectionView.collectionViewLayout = flowLayout
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }
    
    var pageInfoModel: FBRecommendDetailPageInforModel! = nil {
        didSet {
            lookNumberLabel.text = String(format: "共有%d位用户看过", pageInfoModel.dataCount)
        }
    }
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: 35, height: 35)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        //        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
}


extension FBRecommendDetailLook2Cell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbRecommendDetailLookCell, for: indexPath)!
        cell.model = imageList[indexPath.row]
        return cell
    }
}
