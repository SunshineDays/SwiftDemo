//
//  LotteryChooseAllPlayViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol LotteryChooseChangePlayViewControllerDelegate: class {
    /// 玩法改变
    func lotteryChooseChangePlayViewController(_ ctrl: LotteryChooseChangePlayViewController, playTypeChanged play: PlayType)
    
    /// 遮罩被点击
    func lotteryChooseChangePlayViewControllerMaskViewDidTap(_ ctrl: LotteryChooseChangePlayViewController)
}

/// 切换玩法
class LotteryChooseChangePlayViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    /// 每行的个数
    private let collectionViewRowItems = 3
    private let collectionViewHeight: CGFloat = 40
    
    var playTypeList = [PlayType]()
    var selectedPlayType = PlayType.none
    weak var delegate: LotteryChooseChangePlayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        collectionView.register(R.nib.slConfirmSerialCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionViewHeightConstraint.constant = CGFloat(ceil(Double(playTypeList.count) / Double(collectionViewRowItems))) * collectionViewHeight
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap)))
    }
    
    @objc private func viewTap() {
        delegate?.lotteryChooseChangePlayViewControllerMaskViewDidTap(self)
    }
}

extension LotteryChooseChangePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playTypeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.slConfirmSerialCollectionCell, for: indexPath)!
        let play = playTypeList[indexPath.row]
        cell.isChecked = selectedPlayType == play
        cell.serialBtnClickBlock = {
            [weak self]  _, isChecked in
            guard let me = self else {
                return
            }
            me.selectedPlayType = play
            me.delegate?.lotteryChooseChangePlayViewController(me, playTypeChanged: play)
        }
        cell.serialBtn.setTitle(play.name, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: floor(collectionView.width / CGFloat(collectionViewRowItems)), height: collectionViewHeight)
    }
    
}
