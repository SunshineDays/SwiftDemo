//
//  SLCofirmTopView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//
import UIKit

protocol SLConfirmTopViewDelegate: class {
    
    /// 添加比赛btn点击
    func confirmTopViewAddMatchButtonClick(_ confirmView: SLConfirmTopView)
    
    /// 删除列表btn点击
    func confirmTopViewDeleteMatchListButtonClick(_ confirmView: SLConfirmTopView)
}

/// 竞技彩 确认页 头部
class SLConfirmTopView: UIView {

    static let defaultHeight: CGFloat = 50

    @IBOutlet var contentView: UIView!
    
    weak var delegate: SLConfirmTopViewDelegate?
    
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
        contentView = R.nib.slConfirmTopView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    @IBAction func addMatchBtnAction(_ sender: UIButton) {
        delegate?.confirmTopViewAddMatchButtonClick(self)
    }
    
    @IBAction func deleteMatchListBtnAction(_ sender: UIButton) {
        delegate?.confirmTopViewDeleteMatchListButtonClick(self)
    }
    
}
