//
//  FBRecommendSponsorMatchtHeaderSectionView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias FBHeaderViewExpandBlock = () -> ()

/// 发起推荐 赛事选择 HeaderSectionView
class FBRecommendSponsorMatchtHeaderSectionView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectButton.setImage(R.image.fbRecommend2.rowClose(), for: .normal)
        selectButton.setImage(R.image.fbRecommend2.rowOpen(), for: .selected)
        titleButton.addTarget(self, action: #selector(headerViewAction(_:)), for: .touchUpInside)
    }
    
    var headerViewExpandBlock: FBHeaderViewExpandBlock!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var titleButton: UIButton!
    
    @IBOutlet weak var selectButton: UIButton!
    
    /// 足球推荐
    public func setupConfigView(models: [FBRecommendSponsorMatchModel]) {
        let time = TSUtils.timeMonthDayHourMinute(TimeInterval(models[0].mTime), withFormat: "yyyy-MM-dd")
        dateLabel.text = String(format: "%@ %@", time, weekDay(time: models[0].mTime)) + " (00:00~23:59)"
        numberLabel.text = String(format: "%d场", models.count)
    }
    
    /// 竞彩推荐 
    public func setupConfigViewWithJingcai(models: [FBRecommendSponsorMatchModel]) {
        let h = TSUtils.timeMonthDayHourMinute(TimeInterval(models[0].mTime), withFormat: "HH")
        if Int(h) ?? 0 < 12 {
            let time = TSUtils.timeMonthDayHourMinute(TimeInterval(models[0].mTime - 24 * 60 * 60), withFormat: "yyyy-MM-dd")
            dateLabel.text = String(format: "%@ %@", time, weekDay(time: models[0].mTime - 24 * 60 * 60)) + " (当日12:00～次日11:59)"
        }
        else {
            let time = TSUtils.timeMonthDayHourMinute(TimeInterval(models[0].mTime), withFormat: "yyyy-MM-dd")
            dateLabel.text = String(format: "%@ %@", time, weekDay(time: models[0].mTime)) + " (当日12:00～次日11:59)"
        }
        
        numberLabel.text = String(format: "%d场", models.count)
    }
        
    @objc private func headerViewAction(_ sender: UIButton) {
        selectButton.isSelected = !sender.isSelected
        if let block = headerViewExpandBlock {
            block()
        }
    }
    
    private func weekDay(time: Int) -> String {
        let weekDays = [NSNull.init(), "周日", "周一", "周二", "周三", "周四", "周五", "周六"] as [Any]
        
        let calendar = NSCalendar.init(identifier: .gregorian)
        
        let calendarUnit = NSCalendar.Unit.weekday
        
        let date = Foundation.Date(timeIntervalSince1970: TimeInterval(time))

        
        let components = calendar?.components(calendarUnit, from: date)
        return weekDays[(components?.weekday)!] as! String
    }
    
    
    
}




