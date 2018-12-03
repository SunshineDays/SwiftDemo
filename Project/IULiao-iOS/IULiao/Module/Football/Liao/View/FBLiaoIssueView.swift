//
//  FBLiaoIssueView.swift
//  IULiao
//
//  Created by tianshui on 2017/7/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

protocol FBLiaoIssueViewDelegate: class {
    
    func liaoIssueViewDayButtonClick(_ v: FBLiaoIssueView)
}

/// 期号
class FBLiaoIssueView: UIView {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dayBtn: UIButton!
    
    weak var view: UIView!
    weak var delegate: FBLiaoIssueViewDelegate?
    
    /// 期号
    var issue: String = "" {
        didSet {
            issueChange()
        }
    }
    
    var currentIssue: String = "" {
        didSet {
            issueChange()
        }
    }
    
    var selectIssue: String = "" {
        didSet {
            issueChange()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }

    private func initViewFromNib() {
        view = R.nib.fbLiaoIssueView().instantiate(withOwner: self, options: nil).first as! UIView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        view.snp.makeConstraints {
            make in
            make.edges.equalTo(snp.edges)
        }
        dayBtn.addTarget(self, action: #selector(dayButtonClick), for: .touchUpInside)
    }
    
    @objc func dayButtonClick() {
        delegate?.liaoIssueViewDayButtonClick(self)
    }
    
    private func issueChange() {
        let (day, week) = issueToDate(issue: issue)
        
        weekLabel.text = week.cn
        
        if currentIssue == issue {
            dayBtn.setTitle("今", for: .normal)
        } else {
            dayBtn.setTitle("\(day)", for: .normal)
            switch week {
            case .sunday:
                let color = UIColor(hex: 0xff0000)
                weekLabel.textColor = color
                dayBtn.setTitleColor(color, for: .normal)
                dayBtn.layer.borderColor = color.cgColor
            case .saturday:
                let color = UIColor(hex: 0x12b7f5)
                weekLabel.textColor = color
                dayBtn.setTitleColor(color, for: .normal)
                dayBtn.layer.borderColor = color.cgColor
            default:
                break
            }
        }
        
        if selectIssue.count > 0 && selectIssue == issue {
            let color = UIColor(hex: 0xfe9b3a)
            dayBtn.setTitleColor(UIColor.white, for: .normal)
            dayBtn.setBackgroundColor(color, forState: .normal)
            dayBtn.setBackgroundColor(color, forState: .disabled)
            dayBtn.layer.borderColor = color.cgColor
            dayBtn.isEnabled = false
        }
    }
    
    private func issueToDate(issue: String) -> (day: Int, week: Weekday) {
        let date = Date(issue, dateFormat: "yyyy-MM-dd")
        let (_, _, day) = date.getDay()
        let week = date.getWeekday()
        return (day, week)
    }
}
