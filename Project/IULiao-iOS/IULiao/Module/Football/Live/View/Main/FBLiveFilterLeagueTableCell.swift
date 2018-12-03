//
//  FBLiveFilterLeagueCell.swift
//  IULiao
//
//  Created by tianshui on 16/8/1.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBLiveFilterLeagueTableCell: UITableViewCell {
    
    static let reuseTableCellIdentifier = "FBLiveFilterLeagueTableCell"
    
    @IBOutlet weak var collectionView: FBLiveFilterLeagueCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let sectionIndexWidth: CGFloat = 15
        let width = floor(UIScreen.main.bounds.width - sectionIndexWidth) / 3
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: width, height: 44)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = collectionView.bounds
        collectionView.frame = frame
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: UICollectionViewDelegate & UICollectionViewDataSource, index: Int) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = index
        collectionView.reloadData()
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: UICollectionViewDelegate & UICollectionViewDataSource, indexPath: IndexPath) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.indexPath = indexPath
        collectionView.tag = (indexPath as NSIndexPath).section
        collectionView.reloadData()
    }
}
