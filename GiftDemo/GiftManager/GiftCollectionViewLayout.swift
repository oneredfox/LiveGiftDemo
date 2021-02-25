//
//  GiftCollectionViewLayout.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit

struct GiftUIFrameInfo {
        
    static let showGiftView_lineSpace: CGFloat = Adap(value: 14)
    static let showGiftView_itemSpace: CGFloat = Adap(value: 7)
    static let showGiftView_itemEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: Adap(value: 14), left: Adap(value: 15), bottom: Adap(value: 14), right: Adap(value: 15))
    
    static let showGiftView_itemW: CGFloat = (kScreenWidth - showGiftView_itemEdgeInsets.left - showGiftView_itemEdgeInsets.right - showGiftView_itemSpace * 3) * 0.25
    static let showGiftView_itemH: CGFloat = showGiftView_itemW * 135 / 90
}

class GiftCollectionViewLayout: UICollectionViewFlowLayout {

    var cellAttributesArray: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        
        let cellCount = collectionView?.numberOfItems(inSection: 0)
        for i in 0..<(cellCount ?? 0) {
            
            let indexPath = NSIndexPath(row: i, section: 0)
            let attibute = self.layoutAttributesForItem(at: indexPath as IndexPath)
            let page = Int(i / 8)
            //第几列
            let row = i % 4 + page * 4
            //第几行
            let col = i / 4 - page * 2
            
            var space: CGFloat = 0
            if i >= 8 {
                space = (GiftUIFrameInfo.showGiftView_itemEdgeInsets.left * 2) * CGFloat(page)
            }
            
            attibute?.frame = CGRect(x: GiftUIFrameInfo.showGiftView_itemEdgeInsets.left + CGFloat(row) * (GiftUIFrameInfo.showGiftView_itemW + GiftUIFrameInfo.showGiftView_itemSpace) + space,
                                     y: GiftUIFrameInfo.showGiftView_itemEdgeInsets.top + CGFloat(col) * (GiftUIFrameInfo.showGiftView_itemH + GiftUIFrameInfo.showGiftView_lineSpace),
                                     width: GiftUIFrameInfo.showGiftView_itemW,
                                     height: GiftUIFrameInfo.showGiftView_itemH)
            guard attibute != nil else {
                continue
            }
            cellAttributesArray.append(attibute!)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cellAttributesArray
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            let cellCount = collectionView?.numberOfItems(inSection: 0)
            let page = Int((cellCount ?? 1) / 8) + 1
            return CGSize(width: Int(kScreenWidth) * page, height: 0)
        }
    }
}
