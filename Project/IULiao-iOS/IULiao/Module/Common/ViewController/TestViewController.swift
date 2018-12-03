//
//  TestViewController.swift
//  IULiao
//
//  Created by tianshui on 16/7/7.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var text: String = "none"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textLabel = UILabel()
        textLabel.text = self.text
        self.view.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
