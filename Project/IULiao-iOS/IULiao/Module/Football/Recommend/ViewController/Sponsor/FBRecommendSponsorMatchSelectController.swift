//
//  FBRecommendSponsorMatchSelectController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/16.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias FBRecommendSponsorMatchSelectType = (_ selectedModels: [FBRecommendSponsorMatchModel], _ lotteryType: Lottery) -> Void

/// 发起推荐 赛事筛选
class FBRecommendSponsorMatchSelectController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "赛事筛选"
        view.backgroundColor = UIColor(hex: 0xF2F2F2)
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  allArray - 所有数据（筛选后的）
     *  selectedArray - 选择的数据
     *  lotteryType - haderView显示的选中彩种类型（nil = 不显示headerView）
     *  @return - 选中的数据模型和选中的彩种类型
     */
    public func initWithModels(allArray: [FBRecommendSponsorMatchModel], selectedArray: [FBRecommendSponsorMatchModel], lotteryType: Lottery?, selectedType: @escaping FBRecommendSponsorMatchSelectType) {
        self.leagueArray = allArray
        self.selectedArray = selectedArray
        if lotteryType != nil {
            self.lotteryType = lotteryType!
        }
        else {
            headerView.height = 0
            headerView.isHidden = true
        }
        self.selectedType = selectedType
    }
    
    /// 选中数据回调
    private var selectedType: FBRecommendSponsorMatchSelectType!
    /// 彩种选择
    private var lotteryType: Lottery = .all {
        didSet {
            changeSelected()
        }
    }
    /// 上个界面给的数据(所有数据)
    private var leagueArray = [FBRecommendSponsorMatchModel]()
    /// 选择的联队的模型数据
    private var selectedArray = [FBRecommendSponsorMatchModel]()
    /// 刷新界面的数据
    private var dataSource = [FBRecommendSponsorMatchModel]()
    /// 选中状态
    private var flagArray = [Bool]()
    
    private lazy var headerView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: 45))
        view.backgroundColor = UIColor.white
        view.addSubview(segementedControl)
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var segementedControl: UISegmentedControl = {
        let segementedControl = UISegmentedControl.init(items: ["完整", "竞彩", "北单"])
        segementedControl.frame = CGRect.init(x: (TSScreen.currentWidth - 225) / 2, y: 7.5, width: 225, height: 30)
        segementedControl.tintColor = UIColor(hex: 0xF49900)
        segementedControl.selectedSegmentIndex = 0
        segementedControl.addTarget(self, action: #selector(segementedControlAction(_:)), for: .valueChanged)
        return segementedControl
    }()

    private lazy var footerView: FBRecommendSponsorMatchSelectFooterView = {
        let view = R.nib.fbRecommendSponsorMatchSelectFooterView.firstView(owner: nil)!
        let height: CGFloat = TSScreen.statusBarHeight > 20 ? 48 + 12 : 48
        view.frame = CGRect.init(x: 0, y: TSScreen.currentHeight - height, width: TSScreen.currentWidth, height: height)
        view.inverseButton.addTarget(self, action: #selector(inverseButtonAction(_:)), for: .touchUpInside)
        view.clearButton.addTarget(self, action: #selector(clearButtonAction(_:)), for: .touchUpInside)
        view.confirmButton.addTarget(self, action: #selector(confirmButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: (TSScreen.currentWidth - 60) / 3, height: 30)
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 10, 15)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: headerView.height == 0 ? 0 : headerView.frame.maxY + 5, width: TSScreen.currentWidth, height: TSScreen.currentHeight - headerView.height - (headerView.height == 0 ? 0 : 5) - footerView.height - 5 - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight), collectionViewLayout: flowLayout)
        collectionView.register(R.nib.fbRecommendSponsorMatchSelectCell)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        return collectionView
    }()

}

// MARK: - Init
extension FBRecommendSponsorMatchSelectController {
    private func initView() {
//        lotteryType = .all
        changeSelected()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FBRecommendSponsorMatchSelectController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchSelectCell, for: indexPath)!
        cell.setupConfigView(model: dataSource[indexPath.row], flag: flagArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flagArray[indexPath.row] = !flagArray[indexPath.row]
        collectionView.reloadItems(at: [IndexPath.init(row: indexPath.row, section: indexPath.section)])
    }
}

// MARK: - Action
extension FBRecommendSponsorMatchSelectController {
    /// 类型选择
    @objc private func segementedControlAction(_ sender: UISegmentedControl) {
        dataSource.removeAll()
        switch sender.selectedSegmentIndex {
        case 0:
            lotteryType = .all
        case 1:
            lotteryType = .jingcai
        case 2:
            lotteryType = .beidan
        default:
            break
        }
        
        flagArray.removeAll()
        for _ in dataSource {
            flagArray.append(false)
        }
        collectionView.reloadData()
    }
    
    /// 反选
    @objc private func inverseButtonAction(_ button: UIButton) {
        for i in 0 ..< flagArray.count {
            flagArray[i] = !flagArray[i]
        }
        collectionView.reloadData()
    }
    
    /// 清空
    @objc private func clearButtonAction(_ button: UIButton) {
        for i in 0 ..< flagArray.count {
            flagArray[i] = false
        }
        collectionView.reloadData()
    }
    
    /// 确定
    @objc private func confirmButtonAction(_ button: UIButton) {
        var resultArray = [FBRecommendSponsorMatchModel]()
        // 根据选中的状态得到数据模型
        for i in 0 ..< flagArray.count {
            if flagArray[i] {
                for league in leagueArray {
                    // 把所有 是选中联赛名 的数据 加入数组
                    if league.lid == dataSource[i].lid {
                        resultArray.append(league)
                    }
                }
            }
        }
        // 把数据按照时间排序
        resultArray.sort { (model1, model2) -> Bool in
            return model1.mTime < model2.mTime
        }
        // 返回选中的数据
        selectedType(resultArray, lotteryType)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Method
extension FBRecommendSponsorMatchSelectController {
    /// 根据选择类型改变数据
    private func changeSelected() {
        switch lotteryType {
        case .all:
            segementedControl.selectedSegmentIndex = 0
            modelsWithLName(array: leagueArray)
        case .jingcai:
            segementedControl.selectedSegmentIndex = 1
            var array = [FBRecommendSponsorMatchModel]()
            for model in leagueArray {
                if model.isJingCai == 1 {
                    array.append(model)
                }
            }
            modelsWithLName(array: array)
        case .beidan:
            segementedControl.selectedSegmentIndex = 2
            var array = [FBRecommendSponsorMatchModel]()
            for model in leagueArray {
                if model.isBeiDan == 1 {
                    array.append(model)
                }
            }
            modelsWithLName(array: array)
        default:
            break
        }
    }
    
    private func modelsWithLName(array: [FBRecommendSponsorMatchModel]) {
        dataSource.removeAll()
        let dic = NSMutableDictionary()
        for model in array {
            dic.setValue(model, forKey: String(format: "%d", model.lid))
        }
        flagArray.removeAll()
        for d in dic {
            dataSource.append(d.value as! FBRecommendSponsorMatchModel)
            flagArray.append(false)
        }
        for i in 0 ..< dataSource.count {
            for select in selectedArray {
                if select.lid == dataSource[i].lid {
                    flagArray[i] = true
                    break
                }
            }
        }
    }
    
}



