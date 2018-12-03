//
//  FBRecommendExpertStatisticsView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias FBChangeOddsType = (_ oddstype: RecommendDetailOddsType) -> Void

/// 推荐 专家页 战绩统计
class FBRecommendExpertStatisticsView: UIView {

    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var winView: UIView!
    
    @IBOutlet weak var drawView: UIView!
    
    @IBOutlet weak var lostView: UIView!
    
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var drawLabel: UILabel!
    
    @IBOutlet weak var lostLabel: UILabel!
    
    @IBOutlet weak var allRecommendLabel: UILabel!
    
    @IBOutlet weak var allPercentLabel: UILabel!
    
    @IBOutlet weak var allPayoffPercentLabel: UILabel!
    
    @IBOutlet weak var day7PayoffPercentLabel: UILabel!
    
    @IBOutlet weak var order10PayoffPercentLabel: UILabel!
    
    @IBOutlet weak var ringView: UIView!
    
    @IBOutlet weak var day7PercentLabel: UILabel!
    
    @IBOutlet weak var labelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rankButton: UIButton!
    
    var oddsTypeChange: FBChangeOddsType?
    
    private var oddsType: RecommendDetailOddsType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            labelCenterXConstraint.constant = -25
        }
    }
    
    @IBAction func rankButtonAction(_ sender: UIButton) {
        let vc = FBRecommendRankBaseViewController()
        vc.initWith(title: oddsType == .football ? .football : .jingcai, footballRankType: .keepWin, jingcaiRankType: .payoff)
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func setupConfigView(model: FBRecommendExpertModel, oddsType: RecommendDetailOddsType = .football) {
        self.oddsType = oddsType
        self.model = model
        initSegmentedControl()
        oddsTypeShow()
    }
    
    private var model: FBRecommendExpertModel!
    
    private func initSegmentedControl() {
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0x333333),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0xFF974B),
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segmentedControl.selectionIndicatorColor = UIColor.clear
        segmentedControl.selectionIndicatorHeight = 0
        if oddsType == .football || oddsType == .europe || oddsType == .asianPlate || oddsType == .sizePlate {
            segmentedControl.sectionTitles = ["全部", "欧赔", "亚盘", "大小"]
        }
        else {
            segmentedControl.sectionTitles = ["全部", "2串1", "单关"]
        }
    }
    
    private func oddsTypeShow() {
        switch oddsType! {
        case .football:
            self.typeModel = model.football
            segmentedControl.selectedSegmentIndex = 0
        case .europe:
            self.typeModel = model.europe
            segmentedControl.selectedSegmentIndex = 1
        case .asianPlate:
            self.typeModel = model.asia
            segmentedControl.selectedSegmentIndex = 2
        case .sizePlate:
            self.typeModel = model.daxiao
            segmentedControl.selectedSegmentIndex = 3
            
        case .jingcai:
            self.typeModel = model.jingCai
            segmentedControl.selectedSegmentIndex = 0
        case .serial:
            self.typeModel = model.jingCaiSerial
            segmentedControl.selectedSegmentIndex = 1
        case .single:
            self.typeModel = model.jingCaiSingle
            segmentedControl.selectedSegmentIndex = 2
        
            
        default:
            break
        }
        segmentedControl.indexChangeBlock = { index in
            switch self.oddsType! {
            case .football, .europe, .asianPlate, .sizePlate:
                switch index {
                case 0:
                    self.typeModel = self.model.football
                    self.oddsTypeChange?(.football)
                case 1:
                    self.typeModel = self.model.europe
                    self.oddsTypeChange?(.europe)
                case 2:
                    self.typeModel = self.model.asia
                    self.oddsTypeChange?(.asianPlate)
                case 3:
                    self.typeModel = self.model.daxiao
                    self.oddsTypeChange?(.sizePlate)
                default:
                    break
                }
            default:
                switch index {
                case 0:
                    self.typeModel = self.model.jingCai
                    self.oddsTypeChange?(.jingcai)
                case 1:
                    self.typeModel = self.model.jingCaiSerial
                    self.oddsTypeChange?(.serial)
                case 2:
                    self.typeModel = self.model.jingCaiSingle
                    self.oddsTypeChange?(.single)
                default:
                    break
                }
            }
        }
    }
    
    private var typeModel: FBRecommendExpertOddsTypeModel! = nil {
        didSet {
            if let model = typeModel {
                winLabel.text = String(format: "%d赢", model.order10.win + model.order10.winHalf)
                drawLabel.text = String(format: "%d走", model.order10.draw)
                lostLabel.text = String(format: "%d输", model.order10.lost + model.order10.lostHalf)
                
                allRecommendLabel.attributedText = stringColor(title: "总推荐", titleColor: UIColor(hex: 0x999999), content: String(format: "%d", model.all.orderCount), contentColor: UIColor(hex: 0x666666))
                allPercentLabel.attributedText = stringColor(title: "总命中率", titleColor: UIColor(hex: 0x999999), content: String(format: "%.2f%%", model.all.hitPercent), contentColor: UIColor(hex: 0xFF6666))
                allPayoffPercentLabel.attributedText = stringColor(title: "总盈利率", titleColor: UIColor(hex: 0x999999), content: String(format: "%.2f%%", model.all.payoffPercent), contentColor: UIColor(hex: 0xFF6666))
                day7PayoffPercentLabel.attributedText = stringColor(title: "近7天盈利率", titleColor: UIColor(hex: 0x999999), content: String(format: "%.2f%%", model.day7.payoffPercent), contentColor: UIColor(hex: 0xFF6666))
                order10PayoffPercentLabel.attributedText = stringColor(title: "近10单盈利率", titleColor: UIColor(hex: 0x999999), content: String(format: "%.2f%%", model.order10.payoffPercent), contentColor: UIColor(hex: 0xFF6666))
                
                day7PercentLabel.text = String(format: "%.2f%%", model.day7.hitPercent)
                
                initDotView(results: model.all.results)
                initRingView(percent: model.day7.hitPercent)
            }
        }
    }

    /// 点
    private func initDotView(results: String) {
        for view in winView.subviews {
            view.removeFromSuperview()
        }
        for view in drawView.subviews {
            view.removeFromSuperview()
        }
        for view in lostView.subviews {
            view.removeFromSuperview()
        }
        //线的长度
        let length = TSScreen.currentWidth - 152 - 15
        //点的个数
        let count = results.count
        //点的宽度
        let dotWidth: CGFloat = 7
        //第一个点和最后一个点距离两边的间隔
        let spaceX: CGFloat = 5
        //点的间隔
        let space = (length - dotWidth * CGFloat(count) - CGFloat(spaceX * 2)) / 9
        
        for i in 0 ..< count {
            let num: Int = Int((results as NSString).substring(with: NSRange.init(location: i, length: 1)))!
            let view = UIView()
            view.frame = CGRect.init(x: spaceX + (dotWidth + space) * CGFloat(i), y: -(dotWidth - 1) / 2, width: dotWidth, height: dotWidth)
            view.layer.cornerRadius = dotWidth / 2
            switch num {
            case 4, 5: //赢
                view.backgroundColor = UIColor(hex: 0xFF3333)
                winView.addSubview(view)
            case 3: //走
                view.backgroundColor = UIColor(hex: 0x009933)
                drawView.addSubview(view)
            case 1, 2: //输
                view.backgroundColor = UIColor(hex: 0x3366CC)
                lostView.addSubview(view)
            default:
                break
            }
        }
    
    }
    
    /// 命中率圆环
    private func initRingView(percent: Double) {
    
        let bezierPath = UIBezierPath.init(arcCenter: CGPoint.init(x: 37.5, y: 37.5), radius: 37.5, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi * 2) + CGFloat(Double.pi / 2), clockwise: true)
        
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor(hex: 0x999999).cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.path = bezierPath.cgPath
        ringView.layer.addSublayer(layer)
        
        let layer1 = CAShapeLayer()
        layer1.lineWidth = 5
        layer1.strokeColor = UIColor(hex: 0xFF3333).cgColor
        layer1.fillColor = UIColor.clear.cgColor
        layer1.strokeStart = 0
        layer1.strokeEnd = CGFloat(0 + percent / 100)
        layer1.path = bezierPath.cgPath
        ringView.layer.addSublayer(layer1)
        
    }
    
    /// 彩色字符串
    private func stringColor(title: String, titleColor: UIColor, content: String, contentColor: UIColor) -> NSMutableAttributedString {
        let titleContent = title + "\n" + content
        let str = NSMutableAttributedString.init(string: titleContent)
        str.addAttribute(.foregroundColor, value: titleColor, range: NSRange.init(location: 0, length: title.count))
        str.addAttribute(.foregroundColor, value: contentColor, range: NSRange.init(location: titleContent.count - content.count, length: content.count))
        return str
    }
    
}


