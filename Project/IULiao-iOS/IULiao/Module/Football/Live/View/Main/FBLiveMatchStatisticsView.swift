//
//  FBLiveMatchStatisticsView.swift
//  IULiao
//
//  Created by tianshui on 2018/3/12.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 即时比分 列表展开赛事统计信息
class FBLiveMatchStatisticsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var warLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var initEuropeWinLabel: UILabel!
    @IBOutlet weak var initEuropeDrawLabel: UILabel!
    @IBOutlet weak var initEuropeLostLabel: UILabel!
    @IBOutlet weak var lastEuropeWinLabel: UILabel!
    @IBOutlet weak var lastEuropeDrawLabel: UILabel!
    @IBOutlet weak var lastEuropeLostLabel: UILabel!
    
    @IBOutlet weak var initAsiaAboveLabel: UILabel!
    @IBOutlet weak var initAsiaBelowLabel: UILabel!
    @IBOutlet weak var initAsiaHandicapLabel: UILabel!
    @IBOutlet weak var lastAsiaAboveLabel: UILabel!
    @IBOutlet weak var lastAsiaBelowLabel: UILabel!
    @IBOutlet weak var lastAsiaHandicapLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        
        contentView = R.nib.fbLiveMatchStatisticsView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func configView(match: FBLiveMatchModel2, statistics: FBMatchStatisticsModel?) {
        
        guard let statistics = statistics else {
            return
        }
        
        homeLabel.attributedText = getWDL(statistics: statistics.homeStatistics)
        awayLabel.attributedText = getWDL(statistics: statistics.awayStatistics)
        
        configWar(match: match, statistics: statistics.warStatistics)
        configEurope(europe: statistics.europe)
        configAsia(asia: statistics.asia)
    }
    
    /// 欧赔
    private func configEurope(europe: FBOddsEuropeSetModel) {
        let (initOdds, lastOdds) = (europe.initOdds, europe.lastOdds)
        
        initEuropeWinLabel.text = initOdds.win.decimal(2)
        initEuropeDrawLabel.text = initOdds.draw.decimal(2)
        initEuropeLostLabel.text = initOdds.lost.decimal(2)
        
        lastEuropeWinLabel.text = lastOdds.win.decimal(2)
        lastEuropeDrawLabel.text = lastOdds.draw.decimal(2)
        lastEuropeLostLabel.text = lastOdds.lost.decimal(2)
    }
    
    /// 亚盘
    private func configAsia(asia: FBOddsAsiaSetModel) {
        let (initOdds, lastOdds) = (asia.initOdds, asia.lastOdds)
        
        initAsiaAboveLabel.text = initOdds.above.decimal(2)
        initAsiaHandicapLabel.text = initOdds.below.decimal(2)
        initAsiaBelowLabel.text = initOdds.handicap
        
        lastAsiaAboveLabel.text = lastOdds.above.decimal(2)
        lastAsiaHandicapLabel.text = lastOdds.below.decimal(2)
        lastAsiaBelowLabel.text = lastOdds.handicap
        
    }
    
    /// 交锋
    private func configWar(match: FBLiveMatchModel2, statistics: FBMatchStatisticsModel.Statistics) {
        
        
        let str = NSAttributedString(string: "双方近\(statistics.count)次交锋，\(match.home)", attributes: [
            NSAttributedStringKey.foregroundColor: TSColor.gray.gamut666666
        ])
        let wdl = getWDL(statistics: statistics)
        wdl.insert(str, at: 0)
        warLabel.attributedText = wdl
    }
    
    private func getWDL(statistics: FBMatchStatisticsModel.Statistics) -> NSMutableAttributedString{
        let str1 = NSAttributedString(string: "\(statistics.win)胜", attributes: [
            NSAttributedStringKey.foregroundColor: TSColor.matchResult.win
            ])
        let str2 = NSAttributedString(string: "\(statistics.draw)平", attributes: [
            NSAttributedStringKey.foregroundColor: TSColor.matchResult.draw
            ])
        let str3 = NSAttributedString(string: "\(statistics.lost)负", attributes: [
            NSAttributedStringKey.foregroundColor: TSColor.matchResult.lost
            ])
        let result = NSMutableAttributedString()
        result.append(str1)
        result.append(str2)
        result.append(str3)
        return result
    }
}
