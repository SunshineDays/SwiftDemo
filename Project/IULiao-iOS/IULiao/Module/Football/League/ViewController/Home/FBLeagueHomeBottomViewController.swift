//
//  FBLeagueHomeBottomViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 资料库首页下部分
class FBLeagueHomeBottomViewController: UIViewController {

    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var collectionView: BaseCollectionView!
    
    var leagueHomeData: FBLeagueHomeDataModel? {
        didSet {
            segmentedControl.sectionTitles = continents.map { $0.name }
            collectionView.reloadData()
        }
    }
    
    private var viewControllersCaches = [IndexPath: UIViewController]()
    private var continents: [FBLeagueHomeDataModel.Continent] {
        return leagueHomeData?.continents ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

}

extension FBLeagueHomeBottomViewController {
    
    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        
        segmentedControl.borderType = [HMSegmentedControlBorderType.top, HMSegmentedControlBorderType.bottom]
        segmentedControl.layer.borderWidth = 1 / UIScreen.main.scale
        segmentedControl.layer.borderColor = UIColor(hex: 0xcccccc).cgColor
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0x333333),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: baseNavigationBarTintColor,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorLocation = .down
//        segmentedControl.segmentWidthStyle = .fixed
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorHeight = 1
        segmentedControl.selectionStyle = .fullWidthStripe
        
        segmentedControl.indexChangeBlock = {
            [unowned self] index in
            let indexPath = IndexPath(item: index, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension FBLeagueHomeBottomViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return continents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.uiCollectionViewCell.identifier, for: indexPath)
        var ctrl = viewControllersCaches[indexPath]
        let continent = continents[indexPath.row]
        if ctrl == nil {
            switch continent {
            case .worldLeagues(_):
                let vc = R.storyboard.fbLeagueHome.fbLeagueHomeRegionViewController()!
                vc.leagueList = continent.regionLeagues
                ctrl = vc
            default:
                let vc = R.storyboard.fbLeagueHome.fbLeagueHomeContinentViewController()!
                vc.continent = continent
                ctrl = vc
            }
            viewControllersCaches[indexPath] = ctrl!
        }
        
        addChildViewController(ctrl!)
        cell.contentView.addSubview(ctrl!.view)
        ctrl!.view.snp.makeConstraints {
            make in
            make.edges.equalTo(cell.contentView)
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = UInt(scrollView.contentOffset.x / collectionView.frame.size.width)
        segmentedControl.setSelectedSegmentIndex(index, animated: true)
    }
}

extension FBLeagueHomeBottomViewController: UIGestureRecognizerDelegate {
    
    /// 配合BaseNavigationController侧滑返回
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let cls = NSClassFromString("UILayoutContainerView"), let v = otherGestureRecognizer.view, v.isKind(of: cls) {
            if otherGestureRecognizer.state == UIGestureRecognizerState.began && collectionView.contentOffset.x == 0 {
                return true
            }
        }
        return false
    }
}
