//
//  ForecastController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/6.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

enum ForecastJincaiType: String {
    case all = "全部"
    case twoBunch = "竞彩二串一"
    case single = "竞彩单关"
}

enum ForecastSectionType: String {
    case featured = "精选区"
    case newbie = "新手区"
}

/// 请求id
enum ForecastSelectedType: Int {
    /// 全部精选
    case allFeatured = 1
    /// 全部新手
    case allNewbie = 2
    /// 二串一精选
    case twoBunchFeatured = 3
    /// 二串一新手
    case twoBunchNewbie = 4
    /// 单关精选
    case singleFeatured = 5
    /// 单关新手
    case singleNewbie = 6
}

/// 有料预测
class ForecastController: BaseViewController {
    
    @IBOutlet weak var titleBackgroundView: UIView!

    @IBOutlet weak var jincaiTitleLabel: UILabel!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    @IBOutlet weak var jincaiImageView: UIImageView!
    @IBOutlet weak var sectionImageView: UIImageView!
    
    @IBOutlet weak var jingcaiButton: UIButton!
    @IBOutlet weak var sectionButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var hiddenBackgroundButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: Screen.navigationHeight + 40 + 60, width: Screen.currentWidth, height: Screen.currentHeight))
        button.addTarget(self, action: #selector(hiddenContentClick(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0x000000, alpha: 0.3)
        UIApplication.shared.keyWindow?.addSubview(button)
        return button
    }()
    
    private let jingcaiContentView = ForecastTitleTypeSelectView()
    
    private let sectionContentView = ForecastTitleTypeSelectView()
    
    /// 选择的数据类型id
    private var selectedDataIdType: ForecastSelectedType = .allFeatured {
        didSet {
            tableView.mj_header.beginRefreshing()
        }
    }
    
    private var jingcaiSelectedType: ForecastJincaiType = .all {
        didSet {
            selectedDataIdType = selectdIdType()
        }
    }
    
    private var sectionSelectedType: ForecastSectionType = .featured {
        didSet {
            selectedDataIdType = selectdIdType()
        }
    }
    
    private var pageInfo: PageInfoModel!
    
    private var dataSource = [ForecastExpertHistoryListModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
        initTitleBackgroundView()
        initJingcaiContentView()
        initSectionContentView()
        initTableView()
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hiddenBackgroundButton.isHidden = true
    }
    
    override func getData() {
        MBProgressHUD.showProgress(toView: view)
        getForecastData(page: 1, type: selectedDataIdType)
    }
    
    override func refreshData() {
        tableView.mj_header.beginRefreshing()
    }
}

extension ForecastController {

    private func getForecastData(page: Int = 1, type: ForecastSelectedType) {
        ForecastHandler().getForecastData(type: type.rawValue, page: page, success: { (model) in
            MBProgressHUD.hide(from: self.view)
            self.pageInfo = model.pageInfo
            if page == 1 {
                self.dataSource.removeAll()
            }
            self.dataSource = self.dataSource + model.list
            self.tableView.endRefreshing(dataSource: self.dataSource, pageInfo: model.pageInfo)
            self.tableView(forEmptyDataSet: self.tableView, isRequestSuccess: true)
            self.tableView.reloadData()
        }) { (error) in
            MBProgressHUD.hide(from: self.view)
            self.tableView.endRefreshing()
            self.tableView(forEmptyDataSet: self.tableView, isRequestSuccess: false)
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
}

/// 选中的预测内容类型
extension ForecastController: ForecastTitleTypeSelectViewDelegate {
    func ForecastTitleSelectedContentView(_ view: ForecastTitleTypeSelectView, selectedButtonClick sender: UIButton, selectedTitle: String) {
        switch view {
        case jingcaiContentView:
            jingcaiSelectedType = ForecastJincaiType(rawValue: selectedTitle) ?? .all
            jincaiTitleLabel.text = selectedTitle
        default:
            sectionSelectedType = ForecastSectionType(rawValue: selectedTitle) ?? .featured
            sectionTitleLabel.text = selectedTitle
        }
        hiddenBackgroundButton.isHidden = true
    }
}

extension ForecastController: ForecastCellDelegate {
    func ForecastCell(_ cell: ForecastCell, avatarButtonClick sender: UIButton, userId: Int) {
        let vc = R.storyboard.forecast.forecastExpertController()!
        vc.userId = userId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func ForecastCell(_ cell: ForecastCell, withdrawButtonClick sender: UIButton, alertController: UIAlertController) {
//        present(alertController, animated: true, completion: nil)
    }
}

extension ForecastController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastCell, for: indexPath)!
        cell.delegate = self
        cell.model = dataSource[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = R.storyboard.forecast.forecastDetailController()!
        vc.forecastId = dataSource[indexPath.section].forecast.id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ForecastController {
    @IBAction func leftItemClick(_ sender: UIBarButtonItem) {
        hiddenContentView()
        let message = "\n免费：免费查看预测，不消耗料豆。 \n不中包退：预测未命中返还料豆，2串1红2场算命中。"
        let alertController = UIAlertController(title: "收费类型", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func jincaiSelectedButtonClick(_ sender: UIButton) {
        isSelectedJingcai(true)
        sectionButton.isSelected = false
        sectionContentView.isHidden = true
        jingcaiButton.isSelected = true
        jingcaiContentView.isHidden = !jingcaiContentView.isHidden
        hiddenBackgroundButton.isHidden = jingcaiContentView.isHidden
    }
    
    @IBAction func sectionSelectedButtonClick(_ sender: UIButton) {
       isSelectedJingcai(false)
        jingcaiButton.isSelected = false
        jingcaiContentView.isHidden = true
        sectionButton.isSelected = true
        sectionContentView.isHidden = !sectionContentView.isHidden
        hiddenBackgroundButton.isHidden = sectionContentView.isHidden
    }
    
    @objc private func hiddenContentClick(_ sender: UIButton) {
        hiddenContentView()
    }
    
    private func hiddenContentView() {
        jingcaiContentView.isHidden = true
        sectionContentView.isHidden = true
        hiddenBackgroundButton.isHidden = true
    }
    
    private func isSelectedJingcai(_ isJincai: Bool){
        jincaiTitleLabel.textColor = isJincai ? UIColor.logo : UIColor.colour.gamut333333
        sectionTitleLabel.textColor = !isJincai ? UIColor.logo : UIColor.colour.gamut333333
        jincaiImageView.image = isJincai ? R.image.forecast.down_selected() : R.image.forecast.down_default()
        sectionImageView.image = !isJincai ? R.image.forecast.down_selected() : R.image.forecast.down_default()
    }
    
    /// 网络请求id
    private func selectdIdType() -> ForecastSelectedType {
        switch (jingcaiSelectedType, sectionSelectedType) {
        case (.all, .featured):
            return ForecastSelectedType.allFeatured
        case (.all, .newbie):
            return ForecastSelectedType.allNewbie
        case (.twoBunch, .featured):
            return ForecastSelectedType.twoBunchFeatured
        case (.twoBunch, .newbie):
            return ForecastSelectedType.twoBunchNewbie
        case (.single, .featured):
            return ForecastSelectedType.singleFeatured
        case (.single, .newbie):
            return ForecastSelectedType.singleNewbie
        }
    }
}

extension ForecastController {
    private func initTitleBackgroundView() {
        titleBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        titleBackgroundView.layer.shadowColor = UIColor.colour.gamut040000.cgColor
        titleBackgroundView.layer.shadowRadius = 4
        titleBackgroundView.layer.shadowOpacity = 0.2
        titleBackgroundView.clipsToBounds = false
    }
    
    private func initJingcaiContentView() {
        jingcaiContentView.frame = CGRect(x: 0, y: titleBackgroundView.height + 1, width: view.width, height: 60)
        jingcaiContentView.backgroundColor = UIColor.white
        jingcaiContentView.isHidden = true
        jingcaiContentView.delegate = self
        jingcaiContentView.selectedTitle = ForecastJincaiType.all.rawValue
        jingcaiContentView.titles = [ForecastJincaiType.all.rawValue, ForecastJincaiType.twoBunch.rawValue, ForecastJincaiType.single.rawValue]
        view.addSubview(jingcaiContentView)
    }
    
    private func initSectionContentView() {
        sectionContentView.frame = CGRect(x: 0, y: titleBackgroundView.height + 1, width: view.width, height: 60)
        sectionContentView.backgroundColor = UIColor.white
        sectionContentView.isHidden = true
        sectionContentView.delegate = self
        sectionContentView.selectedTitle = ForecastSectionType.featured.rawValue
        sectionContentView.titles = [ForecastSectionType.featured.rawValue, ForecastSectionType.newbie.rawValue]
        view.addSubview(sectionContentView)
    }
    
    private func initTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.forecastCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_header = BaseRefreshHeader(refreshingBlock: {
            self.getForecastData(page: 1, type: self.selectedDataIdType)
        })
        tableView.mj_footer = BaseRefreshAutoFooter(refreshingBlock: {
            self.getForecastData(page: self.pageInfo.page + 1, type: self.selectedDataIdType)
        })
    }
    
}

