//
//  ViewController.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher


class ViewController: UIViewController {

    var model: GiftCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temp = GiftCellModel.deserialize(from: dic["data"] as? [String: Any]) ?? GiftCellModel()
        model = temp
        block()
        self.giftView.dataArray = temp.list ?? []
        self.giftView.updateData()
        view.addTapGesture {
            self.giftView.showGiftView()
        }
        // Do any additional setup after loading the view.
    }
    
    private lazy var giftView = GiftView(frame: .zero).then{
        $0.addSubview(GiftShowManager.shared().giftShowView1)
        $0.addSubview(GiftShowManager.shared().giftShowView2)
    }
    
    func block() {
        giftView.getMoneyBlock = { giftView in
            print("充值")
        }
            
        giftView.giftViewSendGiftBlock = { giftView, obj in
            let giftModel = GiftModel()
            giftModel.userIcon = obj.icon
            giftModel.userName = obj.username
            giftModel.giftName = obj.name
            giftModel.giftImage = obj.icon
            giftModel.giftGifImage = obj.icon_gif
            giftModel.giftId = obj.id
            giftModel.defaultCount = 0
            giftModel.sendCount = 1
            
            if true {
                
                GiftShowManager.shared().showGiftView(backView: self.view,
                                                      giftModel: giftModel) { (finish) in
                    
                } completeShowGifImageBlock: { (obj) in
                    
                    self.gifImageView.kf.setImage(with: URL(string: giftModel.giftImage ?? ""), completionHandler:  { (image, error, cache, url) in
                        guard image != nil else {return}
                        DispatchQueue.main.safeAsync {
                            
                            let window = UIApplication.shared.keyWindow
                            window?.addSubview(self.gifImageView)
                            self.gifImageView.isHidden = false
                        }
                    })
                }
            } else {
                
                GiftShowManager.shared().showGiftView(backView: self.view,
                                                      giftModel:giftModel) { (finish) in
                    print("结束")
                }
            }
        }
    }

    private lazy var gifImageView =  UIImageView().then{
        $0.isHidden = true
    }
    
    let dic = ["data":["score_e1":"1595",
                       "score_x1":"99976",
                       "amount":"52757",
                       "list":[[
                        "id": "gflt00054a13bd67cfe339833a44",
                        "cat": "1",
                        "createdTime": "1519697947",
                        "deleted": "0",
                        "expire": "0",
                        "extra": "1元",
                        "giftOrder": "1",
                        "icon": "http://7d9q8k.com1.z0.glb.clouddn.com/live_yike.png",
                        "influence": "0",
                        "name": "一颗汤圆",
                        "type": "tangyuan",
                        "updatedTime": "1519697947",
                        "value": 0,
                        "cost_type": "1",
                        "icon_gif": "http://7d9q8k.com1.z0.glb.clouddn.com/live_yike.gif",
                        "username": "张三"
                        ],
                       [
                            "id": "gfltfe462d7d8d87569a7f0ee6e5",
                            "cat": "1",
                            "createdTime": "1519715187",
                            "deleted": "0",
                            "expire": "0",
                            "extra": "6元",
                            "giftOrder": "2",
                            "icon": "http://7d9q8k.com1.z0.glb.clouddn.com/live_1wan.png",
                            "influence": "0",
                            "name": "一碗汤圆",
                            "type": "tangyuan",
                            "updatedTime": "1519715187",
                            "value": 0,
                            "cost_type": "1",
                            "icon_gif": "http://7d9q8k.com1.z0.glb.clouddn.com/live_1wan.gif",
                            "username": "李四"
                            ],
                       [ "id": "gflt9d4bb9346313d9cebbf6bb9c",
                                "cat": "1",
                                "createdTime": "1519715187",
                                "deleted": "0",
                                "expire": "0",
                                "extra": "99元",
                                "giftOrder": "3",
                                "icon": "http://7d9q8k.com1.z0.glb.clouddn.com/live_1guo.png",
                                "influence": "0",
                                "name": "一锅汤圆",
                                "type": "tangyuan",
                                "updatedTime": "1519715187",
                                "value": 0,
                                "cost_type": "1",
                                "icon_gif": "http://7d9q8k.com1.z0.glb.clouddn.com/live_1guo.gif",
                                "username": "王五"
                                ],
                       [
                                    "id": "gfltcb62d82c7f4d380c9a6870fa",
                                    "cat": "1",
                                    "createdTime": "1519715188",
                                    "deleted": "0",
                                    "expire": "0",
                                    "extra": "3元",
                                    "giftOrder": "4",
                                    "icon": "http://7d9q8k.com1.z0.glb.clouddn.com/live_touzi.png",
                                    "influence": "0",
                                    "name": "骰子",
                                    "type": "tangyuan",
                                    "updatedTime": "1519715188",
                                    "value": 0,
                                    "cost_type": "1",
                                    "icon_gif": "http://7d9q8k.com1.z0.glb.clouddn.com/live_touzi.gif",
                                    "username": "赵六"
                                    ],
                       [
                                        "id": "gflt3a4dbafe1065f236ff245179",
                                        "cat": "1",
                                        "createdTime": "1519715188",
                                        "deleted": "0",
                                        "expire": "0",
                                        "extra": "66元",
                                        "giftOrder": "5",
                                        "icon": "http://7d9q8k.com1.z0.glb.clouddn.com/live_huanguan.png",
                                        "influence": "0",
                                        "name": "皇冠",
                                        "type": "tangyuan",
                                        "updatedTime": "1519715188",
                                        "value": 0,
                                        "cost_type": "1",
                                        "icon_gif": "http://7d9q8k.com1.z0.glb.clouddn.com/live_huanguan.gif",
                                        "username": "董8"
                                        ],
                       [
                       "id": "gflt05337c04965748b9eeed1996",
                       "cat": "1",
                       "createdTime": "1521093936",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "6",
                       "icon": "https://xxicon.xxwolo.com/live_yanhua_new2.png",
                       "influence": "0",
                       "name": "烟花",
                       "type": "test",
                       "updatedTime": "1521093936",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_yanhua_new2.gif",
                       "username": "赵六这么长"
                       ],
                       [
                       "id": "gflt00054a13bd67cfe339833a38",
                       "cat": "1",
                       "createdTime": "1451369204",
                       "deleted": "0",
                       "expire": "0",
                       "extra": "",
                       "giftOrder": "7",
                       "icon": "http://78rdo4.com2.z0.glb.qiniucdn.com/img_xianshangxiaohua.png",
                       "influence": "0",
                       "name": "献上小花",
                       "type": "ass",
                       "updatedTime": "1451369204",
                       "value": "3",
                       "cost_type": "0",
                       "icon_gif": "http://78rdo4.com2.z0.glb.qiniucdn.com/img_xianshangxiaohua.gif",
                       "username": "赵六是傻逼"
                       ],
                       [
                       "id": "gflt09b17f55a685996ae857fb36",
                       "cat": "1",
                       "createdTime": "1521093937",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "7",
                       "icon": "https://xxicon.xxwolo.com/live_touzi_new2.png",
                       "influence": "0",
                       "name": "骰子",
                       "type": "test",
                       "updatedTime": "1521093937",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_touzi_new2.gif",
                       "username": "李四是逗比"
                       ],
                       [
                       "id": "gfltb7837a7dc50c23e1a93cf3fa",
                       "cat": "1",
                       "createdTime": "1521093957",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "8",
                       "icon": "https://xxicon.xxwolo.com/live_lovebaobao_new2.png",
                       "influence": "0",
                       "name": "爱的抱抱",
                       "type": "test",
                       "updatedTime": "1521093947",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_lovebaobao_new2.gif",
                       "username": "张三是真笨"
                       ],
                       [
                       "id": "gflt204a665cea90b078726950d2",
                       "cat": "1",
                       "createdTime": "1521093957",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "9",
                       "icon": "https://xxicon.xxwolo.com/live_huangguan_new2.png",
                       "influence": "0",
                       "name": "皇冠",
                       "type": "test",
                       "updatedTime": "1521093947",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_huangguan_new2.gif",
                       "username": "王五王武"
                       ],
                       [
                       "id": "gflt07e9e0aecbcc91285ca637d8",
                       "cat": "1",
                       "createdTime": "1521093957",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "10",
                       "icon": "https://xxicon.xxwolo.com/live_666_new2.png",
                       "influence": "0",
                       "name": "666",
                       "type": "test",
                       "updatedTime": "1521093947",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_666_new2.gif",
                       "username": "赵六888"
                       ],
                       [
                       "id": "gflt027993a5e786cb23299961e3",
                       "cat": "1",
                       "createdTime": "1521093957",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "11",
                       "icon": "https://xxicon.xxwolo.com/live_mmd_new2.png",
                       "influence": "0",
                       "name": "么么哒",
                       "type": "test",
                       "updatedTime": "1521093947",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_mmd_new2.gif",
                       "username": "钱多多"
                       ],
                       [
                       "id": "gflt556abf4b1cf7f899911af22a ",
                       "cat": "1",
                       "createdTime": "1521186780",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "12",
                       "icon": "https://xxicon.xxwolo.com/live_liuxing_new2.png",
                       "influence": "0",
                       "name": "流星",
                       "type": "test",
                       "updatedTime": "1521186780",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_liuxing_new2.gif",
                       "username": "你猜我是谁"
                       ],
                       [
                       "id": "gflt72b357328a837450b1975b7f",
                       "cat": "1",
                       "createdTime": "1521186780",
                       "deleted": "1",
                       "expire": "0",
                       "extra": "1",
                       "giftOrder": "13",
                       "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                       "influence": "0",
                       "name": "靠谱",
                       "type": "test",
                       "updatedTime": "1521186780",
                       "value": "100",
                       "cost_type": "1",
                       "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                       "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ],
                       [
                           "id": "gflt72b357328a837450b1975b7f",
                           "cat": "1",
                           "createdTime": "1521186780",
                           "deleted": "1",
                           "expire": "0",
                           "extra": "1",
                           "giftOrder": "13",
                           "icon": "https://xxicon.xxwolo.com/live_kaopu_new2.png",
                           "influence": "0",
                           "name": "靠谱",
                           "type": "test",
                           "updatedTime": "1521186780",
                           "value": "100",
                           "cost_type": "1",
                           "icon_gif": "https://xxicon.xxwolo.com/live_kaopu_new2.gif",
                           "username": "最后一个长吧"
                       ]
                       ]]]
}

