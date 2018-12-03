//
//  FBMatchOddsEuropeSameStatisticsTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 相同赔率统计cell
class FBMatchOddsEuropeSameStatisticsTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    private var itemViews = [FBMatchOddsEuropeSameStatisticsItemView]()
    
    private var oddsType = OddsType.europe {
        didSet {
            initView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    private func initView() {
        itemViews.forEach {
            v in
            stackView.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
        itemViews = []
        
        var items: [(name: String, outerColor: UIColor, innerClor: UIColor)]
        if oddsType == .asia {
            items = [
                ("赢盘率", UIColor(hex: 0xFFCCCC), UIColor(hex: 0xFF6666)),
                ("输盘率", UIColor(hex: 0xB6CEE3), UIColor(hex: 0x258BE3)),
                ("走水率", UIColor(hex: 0x9FC7AC), UIColor(hex: 0x009933)),
            ]
        } else {
            items = [
                ("胜率", UIColor(hex: 0xFFCCCC), UIColor(hex: 0xFF6666)),
                ("平率", UIColor(hex: 0x9FC7AC), UIColor(hex: 0x009933)),
                ("负率", UIColor(hex: 0xB6CEE3), UIColor(hex: 0x258BE3)),
            ]
        }
        
        for item in items {
            let view = R.nib.fbMatchOddsEuropeSameStatisticsItemView.firstView(owner: nil)!
            view.outerView.backgroundColor = item.outerColor
            view.innerView.backgroundColor = item.innerClor
            view.titleLabel.text = item.name
            view.percent = 0
            stackView.addArrangedSubview(view)
            itemViews.append(view)
        }
    }
    
    func configCell(companyInfo: CompanyModel, statistics:  FBMatchOddsEuropeSameModel.Statistics, leagueName: String? = nil) {
        oddsType = .europe
        let leagueName = leagueName == nil ? "" : "\(leagueName!)联赛 "
        titleLabel.text = "\(companyInfo.name) \(leagueName)历史相同欧赔统计（初赔近\(statistics.count)场）"
        
        let count = Double(statistics.count)
        guard count > 0 else {
            return
        }
        itemViews[0].percent = Double(statistics.win) / count
        itemViews[1].percent = Double(statistics.draw) / count
        itemViews[2].percent = Double(statistics.lost) / count
    }
    
    func configCell(companyInfo: CompanyModel, statistics: FBMatchOddsAsiaSameModel.Statistics, leagueName: String? = nil) {
        oddsType = .asia
        let leagueName = leagueName == nil ? "" : "\(leagueName!)联赛 "
        titleLabel.text = "\(companyInfo.name) \(leagueName)历史相同盘口统计（初盘近\(statistics.count)场）"
        
        let count = Double(statistics.count)
        guard count > 0 else {
            return
        }
        itemViews[0].percent = Double(statistics.above) / count
        itemViews[1].percent = Double(statistics.below) / count
        itemViews[2].percent = Double(statistics.draw) / count
    }

    
}
