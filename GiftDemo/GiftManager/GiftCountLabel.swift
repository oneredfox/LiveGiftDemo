//
//  GiftCountLabel.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit

class GiftCountLabel: UILabel {

    override func drawText(in rect: CGRect) {
        
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        
        let c = UIGraphicsGetCurrentContext()
        guard c != nil else {
            return
        }
        c!.setLineWidth(5)
        c!.setLineJoin(.round)
        
        c!.setTextDrawingMode(.stroke)
        self.textColor = .orange
        super.drawText(in: rect)
        
        c!.setTextDrawingMode(.fill);
        self.textColor = textColor
        self.shadowOffset = CGSize.zero
        super.drawText(in: rect)
        
        self.shadowOffset = shadowOffset;
    }

}
