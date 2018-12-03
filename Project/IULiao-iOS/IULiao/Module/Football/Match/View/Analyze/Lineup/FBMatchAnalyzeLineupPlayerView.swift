//
//  FBMatchAnalyzeLineupPlayerView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 赛况 阵容 球员
class FBMatchAnalyzeLineupPlayerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var playerBtn: UIButton!
    
    private var player: FBMatchAnalyzeLineupModel.Player?
    var buttonClickBlock: ((_ button: UIButton, _ player: FBMatchAnalyzeLineupModel.Player?) -> Void)?
    
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
        
        contentView = R.nib.fbMatchAnalyzeLineupPlayerView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    func configView(player: FBMatchAnalyzeLineupModel.Player) {
        self.player = player
        playerNameLabel.text = player.name
        numberLabel.text = player.number == nil ? "-" : "\(player.number!)"
        rateLabel.text = player.rate == 0 ? "-" : player.rate.decimal(1)
        rateLabel.backgroundColor = player.grade.color
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        buttonClickBlock?(sender, player)
    }
}
