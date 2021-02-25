//
//  UIButton+Extension.swift
//  swiftDemo
//
//  Created by lzx on 2020/5/14.
//  Copyright © 2020 liuzixing. All rights reserved.
//

import Foundation
import UIKit

enum MKButtonEdgeInsetsStyle {
    // image在上，label在下
    case Top
    // image在左，label在右
    case Left
    // image在下，label在上
    case Bottom
    // image在右，label在左
    case Right
}

extension UIButton {
    
    func layoutButtonWithEdgeInsetsStyle(_ style : MKButtonEdgeInsetsStyle,_ space : CGFloat) {
        
        self.contentMode = UIView.ContentMode.top
        
        //1. 得到imageView和titleLabel的宽、高
        let imageWith = self.imageView?.width ?? 0;
        let imageHeight = self.imageView?.height ?? 0;
        
        let labelWidth : CGFloat = self.titleLabel?.width ?? 0;
        let labelHeight : CGFloat = self.titleLabel?.font.lineHeight ?? 0;
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInset = UIEdgeInsets.zero
        var labelEdgeInset = UIEdgeInsets.zero
        
        switch style {
            
        case .Top:
            
            imageEdgeInset = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight-space/2.0, right: 0)
            
            
        case .Left:
            
            imageEdgeInset = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            
            labelEdgeInset = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
            
            
        case .Bottom:
            
            imageEdgeInset = UIEdgeInsets(top:0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInset = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWith, bottom: 0, right: 0)
            
            
            
            
        case .Right:
            
            imageEdgeInset = UIEdgeInsets(top:0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith-space/2.0, bottom: 0, right: imageWith+space/2.0)
            
                        
        }
        
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInset;
        self.imageEdgeInsets = imageEdgeInset;
    }
    
    var normalTitle : String {
        
        set {
            
            self.setTitle(newValue, for: UIControl.State.normal)
        }
        
        get {
            
            return self.title(for: UIControl.State.normal) ?? ""
        }
    }
    
    var highlightedTitle : String {
        
        set {
            
            self.setTitle(newValue, for: UIControl.State.highlighted)
        }
        
        get {
            
            self.title(for: UIControl.State.highlighted) ?? ""
        }
    }
    
    var selectedTitle : String {
        
        set {
            
            self.setTitle(newValue, for: UIControl.State.selected)
        }
        
        get {
            
            self.title(for: UIControl.State.selected) ?? ""
        }
    }
    
    
    var normalTitleColor : UIColor {
        
        set {
            
            self.setTitleColor(newValue, for: UIControl.State.normal)
        }
        
        get {
            
            self.titleColor(for: UIControl.State.normal)!
        }
    }
    
    var highlightedTitleColor : UIColor {
        
        set {
            
            self.setTitleColor(newValue, for: UIControl.State.highlighted)
        }
        
        get {
            
            self.titleColor(for: UIControl.State.highlighted)!
        }
    }
    
    var selectedTitleColor : UIColor {
        
        set {
            
            self.setTitleColor(newValue, for: UIControl.State.selected)
        }
        
        get {
            
            self.titleColor(for: UIControl.State.selected)!
        }
    }
    
    var disableTitleColor : UIColor {
        
        set {
            
            self.setTitleColor(newValue, for: UIControl.State.disabled)
        }
        
        get {
            
            self.titleColor(for: UIControl.State.disabled)!
        }
    }
    
    var titleFont : UIFont {
        
        set {
            
            self.titleLabel?.font = newValue
            
        }
        
        get {
            
            self.titleLabel?.font ?? UIFont.systemFont(ofSize: 12)
        }
    }
    
    var normalImage : String {
        
        set {
            
            self.setImage(UIImage.init(named: newValue), for: UIControl.State.normal)
        }
        
        get {
            
            ""
        }
    }
    
    var highlightedImage : String {
        
        set {
            
            self.setImage(UIImage.init(named: newValue), for: UIControl.State.highlighted)
        }
        
        get {
            
            ""
        }
    }
    
    var selectedImage : String {
        
        
        set {
            
            self.setImage(UIImage.init(named: newValue), for: UIControl.State.selected)
        }
        
        get {
            
            ""
        }
        
    }
    
    var normalBgImage : String {
        
        
        set {
            
            self.setBackgroundImage(UIImage.init(named: newValue), for: UIControl.State.normal)
        }
        
        get {
            
            ""
        }
    }
    
    var highlightedBgImage : String {
        
        set {
            
            self.setBackgroundImage(UIImage.init(named: newValue), for: UIControl.State.highlighted)
        }
        
        get {
            
            ""
        }
    }
    
    var selectedBgImage : String {
        
        set {
            
            self.setBackgroundImage(UIImage.init(named: newValue), for: UIControl.State.selected)
        }
        
        get {
            
            ""
        }
    }
    
    
    
    //通过关联属性给UIButton添加一个timer属性，主要用来取消定时
    var timer: DispatchSourceTimer? {
        // 在调用DispatchSourceTimer时, 无论设置timer.scheduleOneshot, 还是timer.scheduleRepeating代码 不调用cancel(), 系统会自动调用
        // 另外需要设置全局变量引用, 否则不会调用事件
        get {
            return objc_getAssociatedObject(self, &Key.timerKey) as? DispatchSourceTimer
        }
        set {
            objc_setAssociatedObject(self, &Key.timerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 开始button倒计时
    /// - Parameters:
    ///   - duration: 倒计时时间：单位秒
    func startDownSMSWithDuration(duration: Int, reTitle: String? = "重新获取", _ completion: (() -> Void)?) {
        
        var times = duration
        //初始化Timer
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //timer事件处理
        timer?.setEventHandler {
            if times > 0 {
                //倒计时处理
                DispatchQueue.main.async(execute: {
                    self.isEnabled = false
                    self.normalTitle = "\(times)" + " s"
                    times -= 1
                })
            } else {
                //倒计时结束，取消定时，button变为倒计时前样式，可点击
                DispatchQueue.main.async(execute: {[weak self] in
                    self?.isEnabled = true
                    self?.timer?.cancel()
                    self?.timer = nil
                    self?.normalTitle = reTitle ?? ""
                    completion?()
                })
            }
        }
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(0))
        timer?.resume()
    }
    
    /// 开始button计时
    /// - Parameters:
    ///   - duration: 计时时间：单位秒
    func startSMSWithDuration(duration: Int, _ completion: ((_ times: Int, _ finish : Bool) -> Void)?) {
        
        var times = 0
        //初始化Timer
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //timer事件处理
        timer?.setEventHandler {
            if times <= duration {
                //倒计时处理
                DispatchQueue.main.async(execute: {
                    self.isEnabled = false
                    
                    let minute = Int(times / 600)
                    let seconds = times - minute * 60
                    self.normalTitle = String(format: "%02d:%02d",minute,seconds)
                    completion?(times,false)
                    times += 1
                    
                })
            } else {
                //倒计时结束，取消定时，button变为倒计时前样式，可点击
                DispatchQueue.main.async(execute: {
                    self.isEnabled = true
                    self.timer?.cancel()
                    self.timer = nil
                    completion?(duration,true)
                })
            }
        }
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(0))
        timer?.resume()
    }
    
    
    //取消倒计时
    func cancel() {
        DispatchQueue.main.async(execute: {
            self.isEnabled = true
            self.timer?.cancel()
            self.timer = nil
        })
    }
    struct Key {
        static var timerKey = "timerKey"
    }
    //使用说明
    //    button.startSMSWithDuration(duration: 60, disableBackGroudColor: .darkGray, disableTitleColor: .white)
    //    //取消定时
    //    button.cancel(backgroundColor: .white)
    
}
