//
//  GiftCellListModel.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import Foundation

class GiftModel {
    
    required init() {}
    
    //
    var userIcon: String?
    
    //
    var userName: String?
    
    //
    var giftName: String?
    
    //
    var giftImage: String?
    
    //
    var giftGifImage: String?
    
    //count
    var defaultCount: Int = 0
    
    //发送的数
    var sendCount: Int = 0
    
    //礼物ID
    var giftId: String?
    
    //礼物操作的唯一Key
    var giftKey: String {
        
        get {
            return giftName ?? "" + (giftId ?? "")
        }
    }
    
}

