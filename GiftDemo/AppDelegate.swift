//
//  AppDelegate.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 清理URL缓存
        URLCache.shared.removeAllCachedResponses()
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let nav = UINavigationController.init(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
    


}

