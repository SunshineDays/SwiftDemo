//
//  JczpHistoryInfoView.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/24.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol JczpHistoryInfoViewDelegate {
    func jczpHistoryInfoView(_ view: JczpHistoryInfoView, didTapView gesture: UITapGestureRecognizer, indexPath: IndexPath)
}

/// 足球投注 对阵信息
class JczpHistoryInfoView: UIView {

    @IBOutlet weak var contentView: UIView!
        
    @IBOutlet weak var homeRankLabel: UILabel!
    @IBOutlet weak var awayRankLabel: UILabel!
    
    @IBOutlet weak var homeRecordLabel: UILabel!
    @IBOutlet weak var awayRecordLabel: UILabel!

    @IBOutlet weak var historyLabel: UILabel!

    @IBOutlet weak var frqWinLabel: UILabel!
    @IBOutlet weak var frqDrawLabel: UILabel!
    @IBOutlet weak var frqLostLabel: UILabel!
    
    @IBOutlet weak var rqWinLabel: UILabel!
    @IBOutlet weak var rqDrawLabel: UILabel!
    @IBOutlet weak var rqLostLabel: UILabel!
    
    static let defaultHeight: CGFloat = 153
    
    private var delegate: JczpHistoryInfoViewDelegate?
    
    private var indexPath = IndexPath()
    

    
    public func configView(model: JczqMatchTeamHistoryModel, delegate: JczpHistoryInfoViewDelegate?, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
        

        if  !model.homeRankName.isEmpty {
            homeRankLabel.attributedText = TSPublicTool.attributedString(texts: [model.homeRankName, "[\(model.homeRankNumber)]"], colors: [UIColor.white, UIColor(hex: 0xFFAA00)])
        } else {
            homeRankLabel.text = "-"
        }
        
        if  !model.awayRankName.isEmpty {
            awayRankLabel.attributedText = TSPublicTool.attributedString(texts: [model.awayRankName, "[\(model.awayRankNumber)]"], colors: [UIColor.white, UIColor(hex: 0xFFAA00)])
        } else {
            awayRankLabel.text = "-"
        }
        
        var homeTitles = [String]()
        var homeColors = [UIColor]()
        
        homeTitles.append("主队")
        homeColors.append(UIColor.white)
        for i in model.homeMatchs.info {
            
            homeTitles.append(" \(HistoryWinStatusType(rawValue: i)?.name ?? "")")
            let color = HistoryWinStatusType(rawValue: i)?.color ?? UIColor.white
            homeColors.append(color)
        }

        homeRecordLabel.attributedText = TSPublicTool.attributedString(texts: homeTitles, colors: homeColors)

        var awayTitles = [String]()
        var awayColors = [UIColor]()
        awayTitles.append("客队")
        awayColors.append(UIColor.white)
        for i in model.awayMatchs.info {
            awayTitles.append(" \(HistoryWinStatusType(rawValue: i)?.name ?? "")")
            let color = HistoryWinStatusType(rawValue: i)?.color ?? UIColor.white
            awayColors.append(color)
        }

        awayRecordLabel.attributedText = TSPublicTool.attributedString(texts: awayTitles, colors: awayColors)
        
        var winCount = 0
        var drawCount = 0
        var lostCount = 0
        for i in model.wars.info {
            switch i {
            case HistoryWinStatusType.win.rawValue:
                winCount += 1
            case HistoryWinStatusType.draw.rawValue:
                drawCount += 1
            case HistoryWinStatusType.lost.rawValue:
                lostCount += 1
            default: break
            }
        }
        
        let texts = ["双方近\(model.wars.info.count)次交锋，\(model.home)", " \(winCount)胜", " \(drawCount)平", " \(lostCount)负"]
        let colors = [UIColor.white, HistoryWinStatusType.win.color, HistoryWinStatusType.draw.color, HistoryWinStatusType.lost.color]
        
        historyLabel.attributedText = TSPublicTool.attributedString(texts: texts, colors: colors)
        
        frqWinLabel.text = model.betRatio.spf.win
        frqDrawLabel.text = model.betRatio.spf.draw
        frqLostLabel.text = model.betRatio.spf.lost

        rqWinLabel.text = model.betRatio.rqspf.win
        rqDrawLabel.text = model.betRatio.rqspf.draw
        rqLostLabel.text = model.betRatio.rqspf.lost
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMoreAction(_:))))
    }
    
    @objc private func showMoreAction(_ gesture: UITapGestureRecognizer) {
        delegate?.jczpHistoryInfoView(self, didTapView: gesture, indexPath: indexPath)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentView = R.nib.jczpHistoryInfoView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension JczpHistoryInfoView {
    private func initView() {
        
    }
}

