//
//  UIView+TappedExtension.swift
//  swiftDemo
//
//  Created by lzx on 2020/5/17.
//  Copyright © 2020 liuzixing. All rights reserved.
//

import UIKit

typealias EWTapGestureHanler = () -> Void

///添加点击事件协议
protocol UIViewTapable {
    ///单击事件
    var tapHandlers: [EWTapGestureHanler] { get }
    ///双击事件
    var doubleTapGestureHandlers: [EWTapGestureHanler] { get }
    ///长点事件
    var longTapGestureHandlers: [EWTapGestureHanler] { get }
    ///上滑事件
    var upSwipeGestureHandlers: [EWTapGestureHanler] { get }
    ///左滑事件
    var leftSwipeGestureHandlers: [EWTapGestureHanler] { get }
    ///右滑事件
    var rightSwipeGestureHandlers: [EWTapGestureHanler] { get }
    ///下滑事件
    var downSwipeGestureHandlers: [EWTapGestureHanler] { get }
    
    func addTapGesture(handler:@escaping() -> Void)
    func addDoubleGesture(handler:@escaping() -> Void)
    func addLongPressed(handler:@escaping() -> Void)
    func addUpSwiped(handler:@escaping() -> Void)
    func addLeftSwiped(handler:@escaping() -> Void)
    func addRightSwiped(handler:@escaping() -> Void)
    func addDownSwiped(handler:@escaping() -> Void)
    
}
///runtime绑定方法时的key
struct EWGestureAssociatedObjectKey {
    ///设置不同手势不同String标识
    //    static let EWTapGestureAssociatedObjectString  = "EWTapGestureAssociatedObjectString"
    ///获取String标识的内存地址作为runtime属性的Key
    static let EWTapGestureKey = UnsafeRawPointer.init(bitPattern: "EWTapGestureAssociatedObjectString".hashValue)
    
    static let EWDoubleTapGestureKey = UnsafeRawPointer.init(bitPattern: "EWDoubleTapGestureAssociatedObjectString".hashValue)
    
    static let EWLongTapGestureKey = UnsafeRawPointer.init(bitPattern: "EWLongTapGestureAssociatedObjectString".hashValue)
    
    static let EWUpSwipeGestureKey = UnsafeRawPointer.init(bitPattern: "EWUpSwipeGestureAssociatedObjectString".hashValue)
    
    static let EWLeftSwipeGestureKey = UnsafeRawPointer.init(bitPattern: "EWLeftSwipeGestureAssociatedObjectString".hashValue)
    
    static let EWRightSwipeGestureKey = UnsafeRawPointer.init(bitPattern: "EWRightSwipeGestureAssociatedObjectString".hashValue)
    
    static let EWDownSwipeGestureKey = UnsafeRawPointer.init(bitPattern: "EWDownSwipeGestureAssociatedObjectString".hashValue)
    
}

extension UIView: UIViewTapable {
    var tapHandlers: [EWTapGestureHanler] {
        return EWOneTapGesture.tappedHandler
    }
    var doubleTapGestureHandlers: [EWTapGestureHanler] {
        return EWDoubleTapGesture.tappedHandler
    }
    var longTapGestureHandlers: [EWTapGestureHanler] {
        return EWLongTapGesture.tappedHandler
    }
    var upSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWUpSwipeGesture.tappedHandler
    }
    var leftSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWLeftSwipeGesture.tappedHandler
    }
    var rightSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWRightSwipeGesture.tappedHandler
    }
    var downSwipeGestureHandlers: [EWTapGestureHanler] {
        return EWDownSwipeGesture.tappedHandler
    }
    ///runtime的方式为View设置手势属性
    var EWOneTapGesture: EWTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWTapGestureKey!) as? EWTapGesture {
                return obj
            }
            let tapGesture = EWTapGesture(view: self)
            //下面这行代码会造成延迟,与双击手势区分
            //            tapGesture.gesture.require(toFail: EWDoubleTapGesture.gesture)
            return tapGesture
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWTapGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWDoubleTapGesture: EWTapGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWDoubleTapGestureKey!) as? EWTapGesture {
                return obj
            }
            return EWTapGesture(view: self,taps: 2)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWDoubleTapGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWLongTapGesture:EWLongPressGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWLongTapGestureKey!) as? EWLongPressGesture {
                return obj
            }
            return EWLongPressGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWLongTapGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWUpSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWUpSwipeGestureKey!) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWUpSwipeGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWLeftSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWLeftSwipeGestureKey!) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self, direction: .left)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWLeftSwipeGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWRightSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWRightSwipeGestureKey!) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self, direction: .right)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWRightSwipeGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var EWDownSwipeGesture: EWSwipeGesture {
        get {
            if let obj = objc_getAssociatedObject(self, EWGestureAssociatedObjectKey.EWDownSwipeGestureKey!) as? EWSwipeGesture {
                return obj
            }
            return EWSwipeGesture(view: self, direction: .down)
        }
        set {
            objc_setAssociatedObject(self, EWGestureAssociatedObjectKey.EWDownSwipeGestureKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTapGesture(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWOneTapGesture.registerHandler(handler)
    }
    
    func addDoubleGesture(handler:@escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWDoubleTapGesture.registerHandler(handler)
    }
    
    func addLongPressed(handler:@escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWLongTapGesture.registerHandler(handler)
    }
    
    func addUpSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWUpSwipeGesture.registerHandler(handler)
    }
    
    func addLeftSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWLeftSwipeGesture.registerHandler(handler)
    }
    
    func addRightSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWRightSwipeGesture.registerHandler(handler)
    }
    
    func addDownSwiped(handler: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.EWDownSwipeGesture.registerHandler(handler)
    }
    
}
///单击双击手势
class EWTapGesture {
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UITapGestureRecognizer
    ///手势储存外界闭包
    fileprivate var tappedHandler = [EWTapGestureHanler]()
    
    init(view: UIView,taps: Int = 1) {
        myView = view
        ///手势
        gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = taps
        gesture.addTarget(self, action: #selector(EWTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        if taps == 1 {
            myView.EWOneTapGesture = self
        } else if taps == 2 {
            myView.EWDoubleTapGesture = self
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///将外界传入的block传入手势方法
    fileprivate func registerHandler(_ handler:@escaping EWTapGestureHanler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            handler()
        }
    }
}
///长按手势
class EWLongPressGesture {
    typealias EWLongPressGestureHandler = () -> Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UILongPressGestureRecognizer
    fileprivate var tappedHandler = [EWLongPressGestureHandler]()
    
    init(view:UIView,taps:Int = 1) {
        myView = view
        gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = TimeInterval(taps)
        gesture.addTarget(self, action: #selector(EWTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        myView.EWLongTapGesture = self
    }
    ///将外界传入的block传入手势方法
    fileprivate func registerHandler(_ handler:@escaping EWLongPressGestureHandler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            guard gesture.state == .began else { return }
            handler()
        }
    }
}
///滑动手势
class EWSwipeGesture {
    typealias EWSwipeGestureHandler = () -> Void
    fileprivate weak var myView:UIView!
    fileprivate let gesture : UISwipeGestureRecognizer
    fileprivate var tappedHandler = [EWSwipeGestureHandler]()
    
    init(view:UIView,direction: UISwipeGestureRecognizer.Direction = .up) {
        myView = view
        gesture = UISwipeGestureRecognizer()
        gesture.direction = direction
        gesture.addTarget(self, action: #selector(EWTapGesture.tapped(_:)))
        myView.addGestureRecognizer(gesture)
        switch direction {
        case .up:
            myView.EWUpSwipeGesture = self
        case .left:
            myView.EWLeftSwipeGesture = self
        case .right:
            myView.EWRightSwipeGesture = self
        case .down:
            myView.EWDownSwipeGesture = self
        default:
            return
        }
    }
    fileprivate func registerHandler(_ handler:@escaping EWSwipeGestureHandler) {
        self.tappedHandler.append(handler)
    }
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        for handler in self.tappedHandler {
            handler()
        }
    }
}
//struct RuntimeKey {
//    static let tapGestureHandle = UnsafeRawPointer.init(bitPattern: "tapGestureBlock".hashValue)
//    /// ...其他Key声明
//}
//
//extension UIView {
//
//    func addTapGesture(handler: @escaping () -> Void) {
//        self.isUserInteractionEnabled = true
//
//        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(zxtapAction(_:)))
//        tapGes.numberOfTapsRequired = 1;
//        tapGes.numberOfTouchesRequired = 1;
//        self.addGestureRecognizer(tapGes)
//        objc_setAssociatedObject(self, RuntimeKey.tapGestureHandle!, handler as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//    }
//
////    func addDoubleGesture(handler:@escaping () -> Void) {
////        self.isUserInteractionEnabled = true
////        self.EWDoubleTapGesture.registerHandler(handler)
////    }
//
//
//    @objc func zxtapAction(_ tapGesture : UITapGestureRecognizer) {
//
//        if tapGesture.numberOfTouchesRequired == 1 {
//            //单击
//
//            let time = 0.0
//            let currentTime = NSDate().timeIntervalSince1970
//            if currentTime - time > 1 {
//                //处理逻辑
//                var handle : (() -> Void) = objc_getAssociatedObject(self, RuntimeKey.tapGestureHandle!) as! (() -> Void)
//                handle()
//            }
//        }
//    }
//}
