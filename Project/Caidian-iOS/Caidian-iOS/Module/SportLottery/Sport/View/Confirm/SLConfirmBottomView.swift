//
//  SLConfirmBottomView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol SLConfirmBottomViewDelegate: class {
    
    /// 真实高度改变
//    func confirmBottomViewRealHeightDidChange(_ bottomView: SLConfirmBottomView, realHeight: CGFloat)
    
    /// collectionView展开状态改变
    func confirmBottomViewCollectionExpandDidChange(_ bottomView: SLConfirmBottomView, isExpand: Bool, realHeight: CGFloat)
    
    /// 串关按钮将要被点击
    func confirmBottomViewSerialButtonWillClick(_ bottomView: SLConfirmBottomView) -> Bool
    
    /// 串关选项改变
    func confirmBottomViewSelectedSerialListDidChange(_ bottomView: SLConfirmBottomView, serialList: [SLSerialType])
    
    /// 下一步点击
    func confirmBottomViewNextButtonClick(_ bottomView: SLConfirmBottomView)
 
    /// 倍数改变
    func confirmBottomViewMultipleDidChange(_ bottomView: SLConfirmBottomView, multiple: Int)
}

/// 竞技彩 确认页 底部
class SLConfirmBottomView: UIView {
    
    static let defaultTipLabelHeight: CGFloat = 44
    static let defaultMultipleViewHeight: CGFloat = 36
    static let defaultNextViewHeight: CGFloat = 40
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var multipleStepper: TSInputStepper!
    @IBOutlet weak var serialBtn: UIButton!
    @IBOutlet weak var serialImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var betCountLabel: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var multipleViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionBoxViewHeight: NSLayoutConstraint!
    
    /// collection view真实高度
    private var collectionViewRealHeight: CGFloat {
        return SLConfirmSerialCollectionCell.defaultHeight * CGFloat(ceil(Double(allSerialList.count) / Double(collectionViewRowItems)))
    }
    /// 每行的个数
    private let collectionViewRowItems = 4
    
    /// 真实高度
    var realHeight: CGFloat {
        var total = SLConfirmBottomView.defaultMultipleViewHeight + SLConfirmBottomView.defaultNextViewHeight
        if !isHiddenTipLabel {
            total += SLConfirmBottomView.defaultTipLabelHeight
        }
        if isExpandCollectionView {
            total += 10 * 2 + collectionViewRealHeight
        }
        return total
    }
    
    /// 隐藏提示label
    var isHiddenTipLabel = false {
        didSet {
            tipLabel.isHidden = isHiddenTipLabel
            multipleViewTopConstraint.constant = isHiddenTipLabel ? 0 : SLConfirmBottomView.defaultTipLabelHeight
            delegate?.confirmBottomViewCollectionExpandDidChange(self, isExpand: isExpandCollectionView, realHeight: realHeight)
        }
    }
    
    /// 展开
    var isExpandCollectionView = false {
        didSet {
            serialImageView.isHighlighted = isExpandCollectionView
            delegate?.confirmBottomViewCollectionExpandDidChange(self, isExpand: isExpandCollectionView, realHeight: realHeight)
        }
    }
    
    /// 串关数据
    var allSerialList = [SLSerialType]() {
        didSet {
            collectionBoxViewHeight.constant = 10 * 2 + collectionViewRealHeight
            collectionView.reloadData()
        }
    }
    /// 选中的串关
    var selectedSerialList = [SLSerialType]() {
        didSet {
            collectionView.reloadData()
            var title: String!
            if selectedSerialList.isEmpty {
                title = "过关方式（必选）"
            } else if selectedSerialList.count < 3 {
                title = selectedSerialList.map({ $0.displayName }).joined(separator: " ")
            } else {
                title = selectedSerialList.map({ $0.displayName }).prefix(3).joined(separator: " ") + " ..."
            }
            serialBtn.setTitle(title, for: .normal)
        }
    }
    
    /// 总注数
    var betCount = 0 {
        didSet {
            configView()
        }
    }
    
    /// 总金额
    var totalMoney = 0 {
        didSet {
            configView()
        }
    }
    
    /// 最小金额
    var minBonus: Double = 0 {
        didSet {
            configView()
        }
    }
    
    /// 最大金额
    var maxBonus: Double = 0 {
        didSet {
            configView()
        }
    }
    
    /// 倍数
    var multiple: Int = 1 {
        didSet {
            configView()
        }
    }
    
    weak var delegate: SLConfirmBottomViewDelegate?
    
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
        contentView = R.nib.slConfirmBottomView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
        
        collectionView.register(R.nib.slConfirmSerialCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        multipleStepper.valueChangedBlock = {
            value in
            self.delegate?.confirmBottomViewMultipleDidChange(self, multiple: value)
        }
        configView()
    }
    
    @IBAction func serialBtnAction(_ sender: UIButton) {
        if let allow = delegate?.confirmBottomViewSerialButtonWillClick(self) {
            if allow {
                isExpandCollectionView = !isExpandCollectionView
            }
        }
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        delegate?.confirmBottomViewNextButtonClick(self)
    }
}

extension SLConfirmBottomView {
    
    private func configView() {

        
        multipleStepper.value = multiple
        
        let betCountAttr = NSMutableAttributedString()
        betCountAttr.append(NSAttributedString(string: "\(betCount)", attributes: [.foregroundColor: UIColor.logo]))
        betCountAttr.append(NSAttributedString(string: "注 共"))
        betCountAttr.append(NSAttributedString(string: "\(totalMoney)", attributes: [.foregroundColor: UIColor.logo]))
        betCountAttr.append(NSAttributedString(string: "元"))
        betCountLabel.attributedText = betCountAttr
        
        let bonusAttr = NSMutableAttributedString()
        bonusAttr.append(NSAttributedString(string: "预计奖金:"))
        bonusAttr.append(NSAttributedString(string: "\(minBonus.decimal(2))~\(maxBonus.decimal(2))", attributes: [.foregroundColor: UIColor.logo]))
        bonusAttr.append(NSAttributedString(string: "元"))
        bonusLabel.attributedText = bonusAttr
    }
}

extension SLConfirmBottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSerialList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.slConfirmSerialCollectionCell, for: indexPath)!
        let serial = allSerialList[indexPath.row]
        cell.isChecked = selectedSerialList.contains(serial)
        cell.serialBtnClickBlock = {
            _, isChecked in
            if let index = self.selectedSerialList.index(of: serial) {
                self.selectedSerialList.remove(at: index)
            } else {
                var list = self.selectedSerialList
                list.append(serial)
                list.sort(by: { $0.m < $1.m})
                self.selectedSerialList = list
            }
            self.delegate?.confirmBottomViewSelectedSerialListDidChange(self, serialList: self.selectedSerialList)
        }
        cell.serialBtn.setTitle(serial.displayName, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: floor(collectionView.width / CGFloat(collectionViewRowItems)), height: SLConfirmSerialCollectionCell.defaultHeight)
    }
    
}
