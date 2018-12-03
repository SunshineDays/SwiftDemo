//
// Created by tianshui on 2018/5/17.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 排列三 近期开奖
class Pl3RecentResultViewController: NLRecentResultViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        tableView.register(R.nib.pl3RecentTableCell)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.pl3RecentTableCell, for: indexPath)!
        let row = indexPath.row
        cell.configView(isShowBackground: row % 2 == 0)
        return cell
    }
}
