//
//  GiftOperation.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import Foundation
import UIKit

class GiftOperation: Operation {
    
    var myExecuting: Bool = false
    var myFinished: Bool = false

    
    //礼物展示的父view
    var backView: UIView?
    
    var model: GiftModel?
    
    var opFinishedBlock : ((Bool, String) -> Void)?

    var giftShowView: GiftShowView?
    
    override var isAsynchronous: Bool {
        return true
    }
        
    override var isExecuting: Bool {
        return myExecuting
    }
        
    override var isFinished: Bool {
        return myFinished
    }
        
}

extension GiftOperation {
    
    /// 增加一个操作
    /// - Parameters:
    ///   - view: 礼物显示的View
    ///   - backView: 礼物要显示在的父view
    ///   - model: 礼物的数据
    ///   - completeBlock: 回调操作结束
    /// - Returns: 操作
    class func addOperation(view: GiftShowView?,
                      backView: UIView?,
                      model: GiftModel?,
                      completeBlock: ((Bool, String) -> Void)?) -> GiftOperation {
       
        let op = GiftOperation()
        op.giftShowView = view;
        op.model = model
        op.backView = backView
        op.opFinishedBlock = completeBlock
        op.completionBlock = {}
        return op
    }
    
    override func start() {
        if isCancelled {
            setFinishs()
            return
        }

        setExecutings()
        
        print("当前队列-- " + (model?.giftName ?? ""))
        OperationQueue.main.addOperation {[weak self] in
            if let giftShowView = self?.giftShowView {
                self?.backView?.addSubview(giftShowView)
            }
            
            self?.giftShowView?.showGiftShowView(giftModel: self?.model, completeBlock: {[weak self] (finish, giftKey) in
                self?.setFinishs()
                self?.opFinishedBlock?(finish, giftKey)
            })
        }
    }
    
    func setFinishs()  {
        willChangeValue(forKey: "isFinished")
        myFinished = true
        didChangeValue(forKey: "isFinished")
    }
    
    func setExecutings() {
        willChangeValue(forKey: "isExecuting")
        myExecuting = true
        didChangeValue(forKey: "isExecuting")
    }
}

