//
//  FBRecommendDetailController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/4.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD

/// 推荐 推荐详情
class FBRecommendDetailController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        initView()
        initNetwork()
        initListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func initWith(resourceId: Int) {
        self.resourceId = resourceId
    }
    
    /// Id
    private var resourceId: Int = 0
    
    /// 记录用户对哪一条进行回复
    private var selectSection = 0
    
    /// 判断是否 是 发布父级评论 否 评论父级评论
    private var isCommentParsentMessage: Bool = true
    
    /// 详情
    private let detailHandler = FBRecommendDetailHandler()
    
    /// 关注/收藏
    private let recommendAttentionHandler = CommonAttentionHandler()
    
    /// 用户评论列表 + 发起评论
    private var commonCommentHandler = CommonCommentHandler()
    
    /// 用户评论点赞
    private var userPollHandler = FBRecommendSingleMatchPollHandler()
    
    /// 用户帖子点赞/踩
    private var pollHandler =  FBRecommendSingleMatchPollHandler()
    
    /// 父级id
    private var parentId = 0
    
    /// tableHeaderView的高度
    private var tableHeaderViewHeight: CGFloat = 700
    
    /// ReasonsView frame.minY
    private var reasonsViewMinY: CGFloat = 0
    
    /// 详情模型
    private var detailModel: FBRecommendDetailModel! = nil {
        didSet {
            userInforTitleView.setupConfigView(model: detailModel)
            self.view.addSubview(commentIditorView)
        }
    }
    
    /// 浏览列表
    private var lookDataSource = [FBRecommendDetailLookModel]()
    
    /// 浏览 页模型
    private var lookPageInforModel: FBRecommendDetailPageInforModel! = nil {
        didSet {

        }
    }
    
    /// 评论 页模型
    private var commentPageInforModel: FBRecommendDetailPageInforModel! = nil {
        didSet {
            
        }
    }

    /// 评论列表
    private var commentDataSoucre = [CommonTopicModel]()
    
    /// 顶部用户信息视图
    private lazy var userInforTitleView: FBRecommendDetaiUserInforTitleView = {
        let view = R.nib.fbRecommendDetaiUserInforTitleView.firstView(owner: nil)!
        view.frame = CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: 162 + TSScreen.statusBarHeight)
        view.followButton.addTarget(self, action: #selector(self.follwowAction(_:)), for: .touchUpInside)
        return view
    }()
    
    /// 底部评论视图
    private lazy var commentIditorView : CommonCommentIditorView = {
        let height: CGFloat = TSScreen.statusBarHeight > 20 ? 50 + 12 : 50
        let view = CommonCommentIditorView(frame: CGRect(x: 0, y: TSScreen.currentHeight - height , width: TSScreen.currentWidth, height: height))
        view.paragram = (detailModel.comments, detailModel.isAttention)
        view.delegate = self
        return view
    }()
    
    /// 弹出的评论窗
    private lazy var commentEditorView : CommonPostCommentEditorView = {
        let view = CommonPostCommentEditorView(frame: CGRect(x: 0, y: TSScreen.currentHeight , width: TSScreen.currentWidth, height: 150))
        view.delegate = self
        return view
    }()
    
    /// 背景（点击取消评论弹窗）
    private lazy var backgroundView: UIView = {
        let view =  UIView(frame: self.view.bounds)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewAction)))
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: userInforTitleView.frame.maxY, width: TSScreen.currentWidth, height: TSScreen.currentHeight - userInforTitleView.height - commentIditorView.height), style: .grouped)
        tableView.backgroundColor = UIColor.white
        
        tableView.register(R.nib.fbRecommendDetailAgainstInfoCell)
        tableView.register(R.nib.fbRecommendDetailReason2Cell)
        tableView.register(R.nib.fbRecommendDetailLook2Cell)
        tableView.register(R.nib.fbRecommendDetailRelevantCell)
        tableView.register(R.nib.fbRecommendDetailCommentCell)
        tableView.register(R.nib.fbRecommendDetailCommentContentCell)
        tableView.register(R.nib.fbRecommend2BunchCell)
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        let mjFooter = MJRefreshBackNormalFooter()
        mjFooter.setTitle("正在玩命加载...", for: .refreshing)
        mjFooter.setTitle("", for: .idle)
        mjFooter.setTitle("暂无更多评论", for: .noMoreData)
        mjFooter.setRefreshingTarget(self, refreshingAction: #selector(self.getCommentList))
        tableView.mj_footer = mjFooter
        
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


extension FBRecommendDetailController {
    
    private func initView() {
        self.view.addSubview(userInforTitleView)
    }
    
    private final func initListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func initNetwork() {
        getData()
    }
    
    func getData() {
//        FBProgressHUD.showProgress()
        FBProgressHUD.showProgress(to: view, text: nil)
        let queue = DispatchQueue.init(label: "request")
        let group = DispatchGroup()
        queue.async(group: group) {
            let semaphore = DispatchSemaphore.init(value: 0)
            self.detailHandler.getDetail(recommendId: self.resourceId, success: { (model) in
                self.detailModel = model
                semaphore.signal()
            }, failed: { (error) in
                semaphore.signal()
                TSToast.showNotificationWithTitle(error.localizedDescription)
            })
            semaphore.wait()
        }
        queue.async(group: group) {
            let semaphore = DispatchSemaphore.init(value: 0)
            self.detailHandler.getDetailLook(resourceId: self.resourceId, page: 1, pageSize: 20, module: .recommend, success: { (list, pageInfoModel) in
                self.lookDataSource = list
                self.lookPageInforModel = pageInfoModel
                semaphore.signal()
            }, failed: { (error) in
                semaphore.signal()
                TSToast.showNotificationWithTitle(error.localizedDescription)
            })
            semaphore.wait()
        }
        queue.async(group: group) {
            let semaphore = DispatchSemaphore.init(value: 0)
            self.detailHandler.getDetailComment(resourceId: self.resourceId, module: .recommend, page: 1, pageSize: 20, success: { (commentList, commentPageInfoModel) in
                self.commentPageInforModel = commentPageInfoModel
                self.commentDataSoucre = commentList
                semaphore.signal()
            }) { (error) in
                semaphore.signal()
                TSToast.showNotificationWithTitle(error.localizedDescription)
            }
            semaphore.wait()
        }
        group.notify(queue: DispatchQueue.main) {
//            FBProgressHUD.isHidden()
            FBProgressHUD.isHidden(from: self.view)
            self.tableView.reloadData()
            if self.commentDataSoucre.count == self.commentPageInforModel.dataCount || self.commentDataSoucre.count == 0 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            else {
                self.tableView.mj_footer.endRefreshing()
            }
            self.view.addSubview(self.backgroundView)
            self.view.addSubview(self.commentEditorView)
        }
    }
    
    /// 获取评论列表
    @objc func getCommentList() {
        detailHandler.getDetailComment(resourceId: self.resourceId, module: .recommend, page: commentPageInforModel.page + 1, pageSize: 20, success: { (commentList, commentPageInfoModel) in
            
            self.commentPageInforModel = commentPageInfoModel

            let array = NSMutableArray()
            array.addObjects(from: self.commentDataSoucre)
            array.addObjects(from: commentList)
            self.commentDataSoucre = array as! [CommonTopicModel]
            
            if commentList.count == commentPageInfoModel.dataCount {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            else {
                self.tableView.mj_footer.endRefreshing()
            }
        }) { (error) in
            self.tableView.mj_footer.endRefreshing()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentDataSoucre.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 9 : commentDataSoucre[section - 1].children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: //对阵信息
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailAgainstInfoCell, for: indexPath)!
                if detailModel.oddsType == .jingcai || detailModel.oddsType == .serial || detailModel.oddsType == .single {
                    cell.isHidden = true
                }
                else {
                    cell.setupConfigView(model: detailModel)
                    cell.otherButton.addTarget(self, action: #selector(otherRecommend), for: .touchUpInside)
                }
                return cell
            case 1: //对阵信息（竞彩）
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommend2BunchCell, for: indexPath)!
                if detailModel.oddsType == .jingcai || detailModel.oddsType == .serial || detailModel.oddsType == .single {
                    cell.setupConfigViewWithDetail(model: detailModel)
                }
                else {
                    cell.isHidden = true
                }
                return cell
            case 2: //推荐理由
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailReason2Cell, for: indexPath)!
                cell.setupConfigView(model: detailModel)
                cell.pollUpButton.addTarget(self, action: #selector(recommendPollUpAction(_:)), for: .touchUpInside)
                cell.pollDownButton.addTarget(self, action: #selector(recommendPollDownAction(_:)), for: .touchUpInside)
                return cell
            case 3: //浏览记录
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailLook2Cell, for: indexPath)!
                if lookDataSource.count > 0 {
                    cell.setupConfigView(imageList: lookDataSource, pageInfoModel: lookPageInforModel)
                }
                else {
                    cell.isHidden = true
                }
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailCommentCell, for: indexPath)!
                cell.titleLabel.text = "相关阅读"
                cell.isHidden = detailModel.relatives.count == 0
                return cell
            case 5, 6, 7: //相关阅读
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailRelevantCell, for: indexPath)!
                if detailModel.relatives.count > indexPath.row - 5 {
                    cell.titleLabel.text = detailModel.relatives[indexPath.row - 5].title
                }
                else {
                    cell.isHidden = true
                }
                return cell
            case 8: //所有评论
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailCommentCell, for: indexPath)!
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailCommentContentCell, for: indexPath)!

                return cell
            }
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendDetailCommentContentCell, for: indexPath)!
            cell.model = commentDataSoucre[indexPath.section - 1].children[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: //对阵信息（足球）
                return detailModel.oddsType == .jingcai || detailModel.oddsType == .serial || detailModel.oddsType == .single ? 0 : 211
            case 1: //对阵信息（竞彩）
                let jingcaiHeight: CGFloat = detailModel.oddsType == .single ? 110 : 190
                return detailModel.oddsType == .jingcai || detailModel.oddsType == .serial || detailModel.oddsType == .single ? jingcaiHeight : 0
            case 2: //推荐理由
                return 182
            case 3: //浏览记录
                let rowNumber: Int = Int((TSScreen.currentWidth - 20) / 35)
                if lookDataSource.count == 0 {
                    return 0
                }
                else if lookDataSource.count < rowNumber {
                    return 75
                }
                else {
                    return 110
                }
            case 4: //相关阅读
                return detailModel.relatives.count == 0 ? 0 : 35
            case 5, 6, 7:
                return detailModel.relatives.count > indexPath.row - 5 ? 40 : 0
            case 8: //所有评论
                return 35
            default:
                return 0
            }
        }
        else {
            return tableView.estimatedRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = R.nib.fbRecommendDetailCommentTitleView.firstView(owner: nil)!
        view.frame = CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: 100)
        view.model = commentDataSoucre[section - 1]
        view.commentButton.tag = section - 1
        view.commentButton.addTarget(self, action: #selector(commentAction(_:)), for: .touchUpInside)
        view.inputButton.tag = section - 1
        view.inputButton.addTarget(self, action: #selector(commentAction(_:)), for: .touchUpInside)
        view.pollUpButton.tag = section - 1
        view.pollUpButton.addTarget(self, action: #selector(commonPollUpAction(_:)), for: .touchUpInside)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: 0))
            return view
        }
        else {
            let view = UIView()
            view.backgroundColor = UIColor.white
            let lineView = UIView.init(frame: CGRect.init(x: 0, y: 9.5, width: TSScreen.currentWidth, height: 0.5))
            lineView.backgroundColor = UIColor(hex: 0xe6e6e6)
            view.addSubview(lineView)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0.01 : 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            switch indexPath.row {
            case 5, 6, 7:
                let id = detailModel.relatives[indexPath.row - 5].id
                let vc = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
                vc.title = "比赛"
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
}

// MARK: - CommonCommentIditorViewDelegate(底部评论视图)
extension FBRecommendDetailController: CommonCommentIditorViewDelegate {
    
    // 点击 底部评论 框弹出键盘
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickEditor editorImageView: UIImageView) {
        if  UserToken.shared.isLogin {
            self.commentEditorView.inputTextView.becomeFirstResponder()
            commentEditorView.placeholderLabel.text = "发表你的评论"
            isCommentParsentMessage = true
            backgroundView.isUserInteractionEnabled = true
        }
        else {
            let ctrl = UIStoryboard(name: "UserLogin", bundle: nil).instantiateInitialViewController()
            present(ctrl!, animated: true, completion: nil)
        }
        
    }
    
    // 底部评论
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickComment commentButton: UIButton) {
        
    }
    
    // 收藏
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickcollection collectionButton: UIButton) {
        if !collectionButton.isSelected {
            recommendAttentionHandler.sendAttention(module: .recommend, resourceId: resourceId, success: { (json) in
                FBProgressHUD.showInfor(text: "收藏成功")
                collectionButton.isSelected = true
            }) { (error) in
                TSToast.showNotificationWithTitle(error.localizedDescription)
            }
        }else {
            recommendAttentionHandler.sendUnAttention(module: .recommend, resourceId: resourceId, success: { (json) in
                FBProgressHUD.showInfor(text: "取消收藏")
                collectionButton.isSelected = false
            }) { (error) in
                TSToast.showNotificationWithTitle(error.localizedDescription)
            }
        }
    }
    
    // 分享
    func commonCommentIditorView(_ commonCommentIditorView: CommonCommentIditorView, didClickShare shareButton: UIButton) {
        UMSocialSwiftInterface.showShareMenuWindow { (type) in
            UMSocialSwiftInterface.shareWebpage(platformType: type,
                                                viewController: self,
                                                title: "有料体育 分析师【" + self.detailModel.user.nickname + "】" + self.detailModel.match.lName,
                                                webpageUrl: self.detailModel?.wapUrl ?? kConstantsAppItunesURLString,
                                                description: self.detailModel.match.home + "VS" + self.detailModel.match.away + "的推荐",
                                                thumbImageUrl: nil,
                                                completion: { (response, error) in

            })
        }
        
    }
    
}

// MARK: - CommonPostCommentEditorViewDelegate(评论弹窗)
extension FBRecommendDetailController: CommonPostCommentEditorViewDelegate {
    // 发送评论
    func commonPostCommentEditorView(_ commonCommentIditorView: CommonPostCommentEditorView, didClickCommitButton commitButton: UIButton, textContent textStr: String) {
        backgroundView.isUserInteractionEnabled = false
        commitButton.isUserInteractionEnabled = false //防止重复点击
        // 发布父级评论
        if isCommentParsentMessage {
            commonCommentIditorView.placeholderLabel.text = "发表你的评论"
            commonCommentHandler.sendPostComment(content: textStr, module: .recommend, resourceId: resourceId, parentId: parentId, success: { (json) in
                commonCommentIditorView.inputTextView.text = ""
                commonCommentIditorView.inputTextView.resignFirstResponder()
                commonCommentIditorView.inputTextView.endEditing(true)
                commitButton.isUserInteractionEnabled = true

                self.detailModel.comments = self.detailModel.comments + 1
                self.commentIditorView.paragram = (self.detailModel.comments, self.detailModel.isAttention)


                // 记录用户输入的信息，并加入数组
                let topicModel = CommonTopicModel.init(aId: json["id"].intValue, userId: (UserToken.shared.userInfo?.id)!, content: textStr, createTime: Foundation.Date().timeIntervalSince1970, pollUp: 0, parentId: 0, userAvatar: (UserToken.shared.userInfo?.avatar)!, userNickName: (UserToken.shared.userInfo?.nickname)!)
                self.commentDataSoucre.insert(topicModel, at: 0)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath.init(row: 8, section: 0), at: .middle, animated: true)
            }) { (error) in
                commitButton.isUserInteractionEnabled = true
                TSToast.showNotificationWithMessage(error.localizedDescription)
            }
        }
        // 对父级评论 进行回复
        else {
            commonCommentHandler.sendPostComment(content: textStr, module: .recommend, resourceId: self.resourceId, parentId: parentId, success: { (json) in
                commonCommentIditorView.inputTextView.text = ""
                commonCommentIditorView.inputTextView.resignFirstResponder()
                commonCommentIditorView.inputTextView.endEditing(true)
                commitButton.isUserInteractionEnabled = true
                
                self.detailModel.comments = self.detailModel.comments + 1
                self.commentIditorView.paragram = (self.detailModel.comments, self.detailModel.isAttention)
                
                // 记录用户输入的信息，并加入数组
                let topicModel = CommonTopicModel.init(aId: json["id"].intValue, userId: (UserToken.shared.userInfo?.id)!, content: textStr, createTime: Foundation.Date().timeIntervalSince1970, pollUp: 0, parentId: 0, userAvatar: (UserToken.shared.userInfo?.avatar)!, userNickName: (UserToken.shared.userInfo?.nickname)!)
                self.commentDataSoucre[self.selectSection].children.insert(topicModel, at: 0)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath.init(row: self.commentDataSoucre[self.selectSection].children.count - 1, section: self.selectSection + 1), at: .middle, animated: true)
            }) { (error) in
                commitButton.isUserInteractionEnabled = true
                TSToast.showNotificationWithMessage(error.localizedDescription)
            }
        }
    }
    
    // 取消键盘响应
    func commonPostCommentEditorView(_ commonCommentIditorView: CommonPostCommentEditorView, didClickCancleButton cancleButton: UIButton) {
        self.commentEditorView.inputTextView.resignFirstResponder()
        backgroundView.isUserInteractionEnabled = false
    }
    
}


// MARK: - Action
extension FBRecommendDetailController {
    /// 键盘将要显示
    @objc func keyBoardWillShow(_ notification: Notification) {
        //获取userInfo
        let kbInfo = notification.userInfo
        //获取键盘的size
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //键盘的y偏移量
        let changeY = kbRect.size.height
        //键盘弹出的时间
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.commentEditorView.frame =  CGRect(x: 0, y: TSScreen.currentHeight - (changeY + 150) , width: TSScreen.currentWidth, height: 150)
        }
    }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        let kbInfo = notification.userInfo
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.commentEditorView.frame =  CGRect(x: 0, y: TSScreen.currentHeight, width: TSScreen.currentWidth, height: 150)
        }
    }
    
    /// 背景 点击事件
    @objc private func backgroundViewAction() {
        view.endEditing(true)
        backgroundView.isUserInteractionEnabled = false
    }
    
    /// 点击回复父级评论
    @objc func commentAction(_ button: UIButton) {
        selectSection = button.tag
        parentId = commentDataSoucre[button.tag].id
        self.commentEditorView.inputTextView.becomeFirstResponder()
        commentEditorView.placeholderLabel.text = String(format: "回复%@:", commentDataSoucre[button.tag].user.nickName)
        isCommentParsentMessage = false
        backgroundView.isUserInteractionEnabled = true
    }
    
    /// 评论点赞
    @objc func commonPollUpAction(_ button: UIButton) {
        if commentDataSoucre[button.tag].pollScore == 1 {
            FBProgressHUD.showInfor(text: "您已经赞过了")
        }
        else {
            userPollHandler.sendPoll(module: .comment, resourceId: commentDataSoucre[button.tag].id, score: 1, success: { (json) in
                self.commentDataSoucre[button.tag].pollScore = 1
                self.commentDataSoucre[button.tag].pollUp = self.commentDataSoucre[button.tag].pollUp + 1
                button.setImage(R.image.common.pollupSelect(), for: .normal)
                button.setTitle(String(format: "%d", self.commentDataSoucre[button.tag].pollUp), for: .normal)
            }) { (error) in
                
            }
        }
    }
    
    /// 帖子点赞
    @objc func recommendPollUpAction(_ button: UIButton) {
        if detailModel.pollScore == 1 {
            FBProgressHUD.showInfor(text: "您已经赞过了")
        }
        else {
            pollHandler.sendPoll(module: .recommend, resourceId: resourceId, score: 1, success: { (json) in
                FBProgressHUD.showInfor(text: "赞")
                self.detailModel.pollScore = 1
                self.detailModel.pollUp = self.detailModel.pollUp + 1
                let cell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! FBRecommendDetailReason2Cell
                cell.setupConfigView(model: self.detailModel)
            }) { (error) in
                
            }
        }
    }
    
    /// 帖子踩
    @objc func recommendPollDownAction(_ button: UIButton) {
        if detailModel.pollScore < 0 {
            FBProgressHUD.showInfor(text: "您已经踩过了")
        }
        else {
            pollHandler.sendPoll(module: .recommend, resourceId: resourceId, score: -1, success: { (json) in
                FBProgressHUD.showInfor(text: "踩")
                self.detailModel.pollScore = -1
                self.detailModel.pollDown = self.detailModel.pollDown + 1
                let cell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! FBRecommendDetailReason2Cell
                cell.setupConfigView(model: self.detailModel)
            }) { (error) in
            }
        }
    }
    
    /// 关注
    @objc func follwowAction(_ button: UIButton) {
        if UserToken.shared.userInfo?.id == detailModel.user.id {
            FBProgressHUD.showInfor(text: "不能关注自己哦")
        }
        else {
            if !detailModel.isAttention {
                recommendAttentionHandler.sendAttention(module: .recommend_statistic, resourceId: detailModel.user.id, success: { (json) in
                    self.detailModel.isAttention = true
                    button.setTitle("已关注", for: .normal)
                    button.layer.borderColor = UIColor.clear.cgColor
                }) { (error) in
                    
                }
            }
            else {
                recommendAttentionHandler.sendUnAttention(module: .recommend_statistic, resourceId: detailModel.user.id, success: { (json) in
                    self.detailModel.isAttention = false
                    button.setTitle("+关注", for: .normal)
                    button.layer.borderColor = UIColor.white.cgColor
                }) { (error) in
                    
                }
            }
        }
    }
    
    /// 其他推荐
    @objc func otherRecommend() {
        let vc = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: detailModel.mid, lottery: .all, selectedTab: .recommend)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

