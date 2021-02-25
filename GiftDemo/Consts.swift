//
//  Consts.swift
//  QL
//
//  Created by LZX on 2021/2/21.
//

import Foundation
import UIKit

let kAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

// MARK: - 布局

public var kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public var kScreenHeight: CGFloat = UIScreen.main.bounds.size.height


public let kScale : CGFloat = UIScreen.main.scale

public let kStatusBarAndNavigationHeight : CGFloat = isIphoneX ? 88 : 64
public let SYS_NAV_HEIGHT : CGFloat = isIphoneX ? (44 + kSYSStatusBarHeight) : 64
public let kSYSStatusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height

public let kStatusBarHeight : CGFloat = isIphoneX ? 44 : 20
public let kScreenBounds: CGRect = UIScreen.main.bounds
public let kIphoneXBottomMargin: CGFloat = isIphoneX ? 34 : 0

// tab高度
public let SYS_TAB_HEIGHT = CGFloat((isIphoneX ? 83 : 49))

public let isIphoneX = kScreenHeight >= 812 ? true : false

public let IS_IPHONE           = UIDevice.current.model == "iPhone"
public let IS_IPAD             = UIDevice.current.model == "iPad"


// X和普通机型tabbar的高度差
public let SYS_XTAB_SPACE  = CGFloat(isIphoneX ? 34 : 0)

// X和普通机型navbar的高度差
public let SYS_XNAV_SPACE = (SYS_NAV_HEIGHT - 64.0)



//Cache目录
let directoryCachePath = NSHomeDirectory() + "/Library/Caches/"

//Library目录
let directoryLibraryPath = NSHomeDirectory() + "/Library/"

//方法2
let directoryDucumentPath = NSHomeDirectory() + "/Documents/"

let  placeHolderImage_rectangle =  UIImage.init(named: "placeholerImage")
let  placeHolderImage_square = UIImage.init(named: "placeholerImage")

//宽适配
func Adap(value: CGFloat) -> CGFloat{
    
    return (value) / 375.0 * ((kScreenWidth > 414.0) ? 414.0 : kScreenWidth)
    
}

//宽适配
func ZAdap(value: CGFloat) -> CGFloat{
    
    return (value) / 375.0 * ((kScreenWidth > 414.0) ? 414.0 : kScreenWidth)
    
}


//高适配
func HeightRate(value:CGFloat) -> CGFloat{
   
    return (value / 667.0 * ((kScreenHeight > 667.0) ? 667.0 : kScreenHeight))
}

// 取出某个对象的地址
func sg_getAnyObjectMemoryAddress(object: AnyObject) -> String {
    let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
    return String(describing: str)
}

// 对比两个对象的地址是否相同
func sg_equateableAnyObject(object1: AnyObject, object2: AnyObject) -> Bool {
    let str1 = sg_getAnyObjectMemoryAddress(object: object1)
    let str2 = sg_getAnyObjectMemoryAddress(object: object2)
    
    if str1 == str2 {
        return true
    } else {
        return false
    }
}

/// PingFang-SC-Medium 粗体
/// PingFang-SC-Regular 正常
/// PingFang-SC-Light 细体
func Font(fontName: String, fontSize: CGFloat) -> UIFont{
    guard let font = UIFont.init(name: fontName, size: Adap(value: fontSize)) else {
        return UIFont.systemFont(ofSize: Adap(value: fontSize));
    }
    return font
}

func Fonts(fontSize: CGFloat) -> UIFont{
 
    return UIFont.systemFont(ofSize: Adap(value: fontSize))
}

func BoldFonts(fontSize: CGFloat) -> UIFont{

    return UIFont.boldSystemFont(ofSize: Adap(value: fontSize))
}


/// 样式  0x5B5B5B
///
/// - Parameters:
///   - color_vaule: 传入0x5B5B5B格式的色值
///   - alpha: 传入透明度
/// - Returns: 颜色
public func UIColorFromRGB(color_vaule : UInt64 , alpha : CGFloat = 1) -> UIColor {
    let redValue = CGFloat((color_vaule & 0xFF0000) >> 16)/255.0
    let greenValue = CGFloat((color_vaule & 0xFF00) >> 8)/255.0
    let blueValue = CGFloat(color_vaule & 0xFF)/255.0
    return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
}


func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
   return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
}

func RGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}


func saveImage(currentImage: UIImage, persent : CGFloat = 0.7, scavePath: String, imageName: String){
    
        if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
        imageData.write(toFile: scavePath, atomically: true)
    }
}


//获取当前的时间戳
func getCurrentTimeInterval() -> Int {
    
    let date = NSDate.init(timeIntervalSinceNow: 0)

    let a = date.timeIntervalSince1970;

    let b = Int(a)

//    let str = "\(b)"

    return b
}


//获取一个随机整数，范围在[from,to]，包括from，包括to
func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}

//拼接阿里云图片地址(一般用于前段展示图片,可以自定义大小)
public func StringWithOssImageName(baseUrl base: String = "https://othello.oss-cn-beijing.aliyuncs.com/",
                                   imageWidth width: CGFloat,
                                   imageUrl url: String) -> String {
   
    if url.hasPrefix("http://") || url.hasPrefix("https://") {
        if width == 0 {return url}
        return url + "?x-oss-process=image/resize,m_lfit," + "w_" + "\(Int(width))"
    }
    if width == 0 {return base + url}
    return base  + url + "?x-oss-process=image/resize,m_lfit," + "w_" + "\(Int(width))"

//    return base  + url + "?x-oss-process=image/resize,m_lfit," + "h_" + "\(Int(width * UIScreen.main.scale))" + ",w_" + "\(Int(width * UIScreen.main.scale))"
    
}


public func getCurrentVersion() -> String {
    let infoDictionary = Bundle.main.infoDictionary!
    let shortVersion = infoDictionary["CFBundleShortVersionString"]//版本号（内部标示）
    let appVersion = shortVersion as! String
    return appVersion
}

public func stringEncoding(_ str: String) -> String? {
    if str.isEmpty || str.count <= 0 {
        return str
    }
    let charSet = CharacterSet.urlQueryAllowed as NSCharacterSet
    let mutSet = charSet.mutableCopy() as! NSMutableCharacterSet
    mutSet.addCharacters(in: "#")
    let encodingStr = str.addingPercentEncoding(withAllowedCharacters: mutSet as CharacterSet)
    return encodingStr!
}

public func stringDecode(_ str: String?) -> String {
    return str?.removingPercentEncoding ?? ""
}
