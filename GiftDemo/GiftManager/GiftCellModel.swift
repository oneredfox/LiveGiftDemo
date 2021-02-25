//
//  GiftCellListModel.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import Foundation
import HandyJSON

class GiftCellModel: HandyJSON{
    required  init() {}
    
    var list: [GiftCellListModel]?
}

class GiftCellListModel: HandyJSON{
    
    required  init() {}
    
    //
    var id: String?
    
    //
    var icon: String?
    
    //
    var icon_gif: String?
    
    //
    var name: String?
    
    //
    var type: String?
    
    //价格
    var value: Float?
    
    //是否选中
    var isSelected: Bool?
    
    //
    var username: String?
    
    //cost_type 0星星 1测测币
    var cost_type: Bool?
}

