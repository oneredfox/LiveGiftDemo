//
//  GiftShowManager.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import Foundation
import UIKit

class GiftShowManager {
    
    //MARK: - init
   
    init() {}
    
    static var sharedInstance: GiftShowManager?
    
    let giftMaxNum = 10000
    let operationCache: NSCache<NSString, GiftOperation> = NSCache()
    
    //当前礼物的keys
    var curentGiftKeys: [String] = []
    
    var completeShowGifImageBlock : ((_ giftModel: GiftModel) -> Void)?
    var finishedBlock : ((_ finish: Bool) -> Void)?
    
    
    class func shared() -> GiftShowManager {
        guard let instance = sharedInstance else {
            sharedInstance = GiftShowManager()
            sharedInstance?.block()
            sharedInstance?.settingUpUI()
            return sharedInstance!
        }
        return instance
    }
    
    static func destroy(){
        sharedInstance = nil
    }
    
    //MARK: - Data
    
    
    //MARK: - UI
    func settingUpUI () {}
    
    
    //MARK: members
    
    //展示礼物的queue
    private lazy var giftQueue1 :OperationQueue = {
        let qu = OperationQueue()
        qu.maxConcurrentOperationCount = 1
        return qu
    }()
    
    //展示礼物的queue
    private lazy var giftQueue2 :OperationQueue = {
        let qu = OperationQueue()
        qu.maxConcurrentOperationCount = 1
        return qu
    }()
    
    lazy var giftShowView1: GiftShowView = {
        
        let show_y = GiftUIFrameInfo.showGiftView_itemH * 2 + GiftUIFrameInfo.showGiftView_itemEdgeInsets.top + GiftUIFrameInfo.showGiftView_itemEdgeInsets.bottom + GiftUIFrameInfo.showGiftView_lineSpace + Adap(value: 55 + SYS_XTAB_SPACE)
        let obj = GiftShowView(frame: CGRect(x: -kScreenWidth, y: kScreenHeight - show_y, width: kScreenWidth, height: Adap(value: 50)))
        return obj
    }()
    
    lazy var giftShowView2: GiftShowView = {
        
        let show_y = GiftUIFrameInfo.showGiftView_itemH * 2 + GiftUIFrameInfo.showGiftView_itemEdgeInsets.top + GiftUIFrameInfo.showGiftView_itemEdgeInsets.bottom + GiftUIFrameInfo.showGiftView_lineSpace + Adap(value: 55 + SYS_XTAB_SPACE) - Adap(value: 50) - Adap(value: 10)        
        let obj = GiftShowView(frame: CGRect(x: -kScreenWidth, y: kScreenHeight - show_y, width: kScreenWidth, height: Adap(value: 50)))
        return obj
    }()
}

//MARK: delegate
extension GiftShowManager{
    
    
}

//MARK: - action
extension GiftShowManager {
    
    func block() {
        giftShowView1.showViewKeyBlock = {[weak self] model in
            self?.curentGiftKeys.append(model.giftKey)
            self?.completeShowGifImageBlock?(model)
        }
        
        giftShowView2.showViewKeyBlock = {[weak self] model in
            self?.curentGiftKeys.append(model.giftKey)
            self?.completeShowGifImageBlock?(model)
        }
    }
}



//MARK: - action
extension GiftShowManager {
    
    
    /// 送礼物(不处理第一次展示当前礼物逻辑)
    /// - Parameters:
    ///   - backView: 礼物动效展示父view
    ///   - giftModel: 礼物的数据
    ///   - completeBlock: 展示完毕回调
    func showGiftView(backView: UIView?,
                      giftModel: GiftModel?,
                      completeBlock: ((Bool) -> Void)?) {
        showGiftView(backView: backView,
                     giftModel: giftModel,
                     completeBlock: nil,
                     completeShowGifImageBlock: nil)
    }
    
    
    /// 送礼物(回调第一次展示当前礼物的逻辑)
    /// - Parameters:
    ///   - backView: 礼物动效展示父view
    ///   - giftModel: 礼物的数据
    ///   - completeBlock: 展示完毕回调
    ///   - completeShowGifImageBlock: 第一次展示当前礼物的回调(为了显示gif)
    func showGiftView(backView: UIView?,
                      giftModel: GiftModel?,
                      completeBlock: ((Bool) -> Void)?,
                      completeShowGifImageBlock: ((GiftModel) -> Void)?) {
        self.completeShowGifImageBlock = completeShowGifImageBlock
        guard let giftKey = giftModel?.giftKey else {
            return
        }

        if curentGiftKeys.contains(giftKey) {
            //有当前的礼物信息
            if let op = operationCache.object(forKey: giftKey as NSString) {
                //当前存在操作
                //限制一次礼物的连击最大值
                if op.giftShowView?.currentGiftCount ?? 0 >= giftMaxNum {
                    //移除操作
                    operationCache.removeObject(forKey: giftKey as NSString)
                    //清空唯一key
                    if let index = curentGiftKeys.firstIndex(of: giftKey) {
                        curentGiftKeys.remove(at: index)
                    }
                    
                } else {
                    //赋值当前礼物数
                    op.giftShowView?.giftCount = giftModel?.sendCount ?? 1
                    op.giftShowView?.updateGiftCount()
                }
            } else {
                
                var queue = self.giftQueue2
                var showView = self.giftShowView2
                
                if self.giftQueue1.operations.count <= self.giftQueue2.operations.count {
                    queue = self.giftQueue1
                    showView = self.giftShowView1
                }
                
                //当前操作已结束 重新创建
                let operation = GiftOperation.addOperation(view: showView,
                                                           backView: backView,
                                                           model: giftModel) {[weak self] (finsh, giftKey) in
                    self?.finishedBlock?(finsh)
                    //移除操作
                    self?.operationCache.removeObject(forKey: giftKey as NSString)
                    //清空唯一key
                    //清空唯一key
                    if let index = self?.curentGiftKeys.firstIndex(of: giftKey) {
                        self?.curentGiftKeys.remove(at: index)
                    }
                }
                operation.model?.defaultCount += giftModel?.sendCount ?? 0
                //存储操作信息
                self.operationCache.setObject(operation, forKey: giftKey as NSString)
                //操作加入队列
                queue.addOperation(operation)
            }
        } else {
            //没有礼物的信息
            if let op = operationCache.object(forKey: giftKey as NSString) {
                //当前存在操作
                //限制一次礼物的连击最大值
                if op.giftShowView?.currentGiftCount ?? 0 >= giftMaxNum {
                    //移除操作
                    operationCache.removeObject(forKey: giftKey as NSString)
                    //清空唯一key
                    if let index = curentGiftKeys.firstIndex(of: giftKey) {
                        curentGiftKeys.remove(at: index)
                    }
                    
                } else {
                    //赋值当前礼物数
                    op.giftShowView?.giftCount = giftModel?.sendCount ?? 1
                }
            } else {
                
                var queue = self.giftQueue2
                var showView = self.giftShowView2
                
                if self.giftQueue1.operations.count <= self.giftQueue2.operations.count {
                    queue = self.giftQueue1
                    showView = self.giftShowView1
                }
                
                //当前操作已结束 重新创建
                let operation = GiftOperation.addOperation(view: showView,
                                                           backView: backView,
                                                           model: giftModel) {[weak self] (finsh, giftKey) in
                    self?.finishedBlock?(finsh)
                    if ((self?.giftShowView1.finishModel?.giftKey ?? "") == (self?.giftShowView2.finishModel?.giftKey ?? "")) {
                        return
                    }
                    //移除操作
                    self?.operationCache.removeObject(forKey: giftKey as NSString)
                    //清空唯一key
                    //清空唯一key
                    if let index = self?.curentGiftKeys.firstIndex(of: giftKey) {
                        self?.curentGiftKeys.remove(at: index)
                    }
                }
                operation.model?.defaultCount += giftModel?.sendCount ?? 0
                //存储操作信息
                self.operationCache.setObject(operation, forKey: giftKey as NSString)
                //操作加入队列
                queue.addOperation(operation)
            }
        }
    }
}


