//
//  LotteryHomeViewController.swift
//  Caidian-iOS
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//


/// 购彩大厅
import Foundation

class LotteryHomeViewController: BaseViewController {
    
    var homeMainModel: HomeMainModel! {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var  headerViewHeight : CGFloat = 40
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        let spacing:CGFloat = 1
    
        layout.itemSize = CGSize.init(width: TSScreen.currentWidth / 4 , height: 80)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.headerReferenceSize = CGSize(width: TSScreen.currentWidth, height: headerViewHeight)
      
        /// 列数
        let columnsNum = 4
        let leftGap = (self.view.bounds.width - spacing * CGFloat( columnsNum - 1 ) - CGFloat(columnsNum) * layout.itemSize.width) / 2
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: leftGap, bottom: 0, right: leftGap)

        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        if #available(iOS 10.0, *) {
            collectionView.frame = view.frame
        } else {
            collectionView.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.tabBarHeight(ctrl: self) - TSScreen.statusBarHeight)
        
        }
      
        collectionView.register(UICollectionReusableView.self,forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(R.nib.lotteryHomeCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor  = UIColor.cellEachBackground
        collectionView.delaysContentTouches = false
        collectionView.borderWidth = 0.5
        return collectionView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
 
    
    func initView()  {
        
        self.title = "彩种大厅"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        /// 初始化适配器
        requestMain()
 
        
    }
    
    func requestMain()  {
        
        /// 获取头部信息
        HomeHandler().getMainHome(
            success: {
                data in
                self.homeMainModel = data
        },
            failed: {
                error in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
    }


}


extension LotteryHomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        var count = 8
        switch section {
           case 0:
            count = homeMainModel.lotterySale?.sport.count ?? 0
           case 1:
               count = homeMainModel.lotterySale?.numeric.count ?? 0
           default:
              count = homeMainModel.lotterySale?.quick.count ?? 0
        }
    
       return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.lotteryHomeCell, for: indexPath)! as LotteryHomeCell
        cell.configCell(lotterySaleModel: getLotteryHomeModel(indexPath: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
        for view in headerView.subviews {view.removeFromSuperview()}
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: headerViewHeight))
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = UIColor.grayGamut.gamut333333
    
        switch indexPath.section {
          case 0:
            view.text = "竞技彩"
          case 1:
            view.text = "数字彩"
          default:
             view.text = "快频彩"
        }
        
        
        headerView.addSubview(view)
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        let homeLotteryModel =  getLotteryHomeModel(indexPath: indexPath)
        if isHaveLotteryList.contains(homeLotteryModel.lotteryType){
            let ctrl = TSEntryViewControllerHelper.lotteryViewController(lottery:homeLotteryModel.lotteryType, playType : .hh)
            ctrl.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(ctrl, animated: true)
        }else{
            TSToast.showText(view: self.view, text: "暂未支持该彩种")
        }
        


      
    }
    
    
    /// 获取 当前的lotteryModel
    func getLotteryHomeModel(indexPath: IndexPath) -> HomeLotteryModel {
        var lotterySaleModel : HomeLotteryModel
        switch indexPath.section {
        case 0:
            lotterySaleModel = homeMainModel.lotterySale!.sport[indexPath.row]
        case 1:
            lotterySaleModel = homeMainModel.lotterySale!.numeric[indexPath.row]
        default:
            lotterySaleModel = homeMainModel.lotterySale!.quick[indexPath.row]
        }
        return lotterySaleModel
    }

   
}
