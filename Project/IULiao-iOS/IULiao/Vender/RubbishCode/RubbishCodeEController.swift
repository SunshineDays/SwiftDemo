//
//  RubbishCodeEController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeEController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()

    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE1Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
    }
    
}


class RubbishCodeE2Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
    }
    
}


class RubbishCodeE3Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE4Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE5Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE6Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE7Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE8Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE9Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
    }
    
}


class RubbishCodeE10Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = UIColor.white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
    }
    
}


class RubbishCodeE11Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        seed()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seed() {
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var line_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var select_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var total_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 200, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var delete_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 244234 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("删除", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var love_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 4234 - 10 - 65 - 10 - 65, y: 12.5, width: 65, height: 30))
        button.setTitle("移入关注", for: .normal)
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    
    let helloWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setUpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    
    lazy var lineee_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 231213, height: 0.5))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var sele22ct_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 12.5, width: 30, height: 30))
        button.setImage(nil, for: .normal)
        return button
    }()
    
    lazy var t123otal_label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: self.select_button.frame.maxX + 5, y: 0, width: 30, height: 55))
        label.text = "全选"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    func wrewr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let hellowerWorld : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werer(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    let rere : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func werrrrr(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let rrrwerwer : UILabel = {
        
        let helloWorld = UILabel()
        helloWorld.translatesAutoresizingMaskIntoConstraints = false
        helloWorld.text = "Hello World"
        helloWorld.font = UIFont.boldSystemFont(ofSize: 20)
        helloWorld.textColor = .black
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
        return helloWorld
    }()
    
    func setU3rwrwrpViews(){
        view.addSubview(helloWorld)
        view.backgroundColor = .white
        
        helloWorld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorld.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "GRAND CENTRAL DISPATCH"
        title.font = UIFont.systemFont(ofSize: 25)
        title.textColor = .white
        
    }
    
}



