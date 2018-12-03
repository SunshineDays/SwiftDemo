//
//  RecommendCartCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/9/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol RecommendCartCellDelegate: class {
    /// 跳转到推荐详情
    func recommendCartCell(_ cell: RecommendCartCell, selectedRecommendId: Int)
    /// 用户选择购买哪一行
    func recommendCartCell(_ cell: RecommendCartCell, isSelectedToBuy: Bool, selectedIndexPath: IndexPath)
    /// 用户选择删除哪一行
    func recommendCartCell(_ cell: RecommendCartCell, isSelectedToDelete: Bool, selectedIndexPath: IndexPath)
}

class RecommendCartCell: UITableViewCell {
    
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var backgroundContentView: UIView!
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var matchTimeLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    /// 选择了哪一行
    private var showSelectedRow = -1
    
    /// 是否在进行管理/删除操作
    private var isSetting = false
    
    /// 元数据
    private var dataSource = [RecommendDetailModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var selectedSection = Int()
    
    public weak var delegate: RecommendCartCellDelegate?
    
    public func configCell(models: [RecommendDetailModel], isSetting: Bool, selectedSection: Int) {
        if let model = models.first {
            leagueNameLabel.text = model.matchInfo.leagueName
            leagueNameLabel.textColor = model.matchInfo.color
            matchTimeLabel.text = model.matchInfo.matchTime.timestampToString(withFormat: "MM-dd HH:mm", isIntelligent: false)
            homeTeamLabel.text = model.matchInfo.home
            awayTeamLabel.text = model.matchInfo.away
        }
        self.isSetting = isSetting
        self.selectedSection = selectedSection
        dataSource = models
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundContentView.clipsToBounds = false
        backgroundContentView.layer.shadowColor = UIColor(hex: 0x000000).cgColor
        backgroundContentView.layer.shadowOpacity = 0.15
        backgroundContentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundContentView.layer.shadowRadius = 5
        tableView.register(R.nib.recommendCartContentCell)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RecommendCartCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.recommendCartContentCell, for: indexPath)!
        cell.configCell(model: dataSource[indexPath.row].recommend, isSetting: isSetting) { isSelected in
            ///  管理操作中
            if self.isSetting {
                self.delegate?.recommendCartCell(self, isSelectedToDelete: isSelected, selectedIndexPath: IndexPath(row: indexPath.row, section: self.selectedSection))

            } else {
                self.delegate?.recommendCartCell(self, isSelectedToBuy: isSelected, selectedIndexPath: IndexPath(row: indexPath.row, section: self.selectedSection))
            }
        }
        cell.lineView.backgroundColor = indexPath.row < dataSource.count - 1 ? UIColor(hex: 0xE6E6E6) : UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.recommendCartCell(self, selectedRecommendId: dataSource[indexPath.row].recommend.id)
    }
    
}

