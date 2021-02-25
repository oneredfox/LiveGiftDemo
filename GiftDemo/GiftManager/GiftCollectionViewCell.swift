//
//  GiftCollectionViewCell.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit

class GiftCollectionViewCell: UICollectionViewCell {

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    
    //MARK: - Data
    
    var model: GiftCellListModel? {
        
        didSet {
            
            if let path = model?.icon {
                giftImageView.kf.setImage(with: URL(string: path))
            }
            
            giftNameLabel.text = model?.name
            
            bgView.isHidden = !(model?.isSelected ?? false)
                        
            let money = Int((model?.value ?? 1) * 0.01)
            moneyLabel.text = "\(money)" + "钻石"
            
        }
    }
    
    //MARK: - UI
    func settingUpUI () {
        
        contentView.addSubview(bgView)
        contentView.addSubview(giftImageView)
        contentView.addSubview(giftNameLabel)
        contentView.addSubview(moneyLabel)
        contentView.layer.masksToBounds = true
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        giftImageView.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(Adap(value: 0))
            make.size.equalTo(CGSize(width: Adap(value: 80), height: Adap(value: 80)))
        }
        
        giftNameLabel.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            make.top.equalTo(giftImageView.snp_bottom).offset(Adap(value: 4))
            make.height.equalTo(Adap(value: 20))
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            make.top.equalTo(giftNameLabel.snp_bottom).offset(Adap(value: 0))
            make.height.equalTo(Adap(value: 17))
        }
      
    }
    
    
    
    //MARK: members
    
    private lazy var bgView = UIView(frame: .zero).then{
        $0.isHidden = true
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = Adap(value: 6)
        $0.layer.borderColor = UIColorFromRGB(color_vaule: 0x8D65FF).cgColor
        $0.layer.borderWidth = 2
    }
    
    private lazy var giftImageView = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var giftNameLabel = UILabel().then{
        
        $0.font = Fonts(fontSize: 14)
        $0.numberOfLines = 1
        $0.textColor = UIColorFromRGB(color_vaule: 0xffffff)
        $0.textAlignment = .center
    }
    
    private lazy var moneyLabel = UILabel().then{
        
        $0.font = Fonts(fontSize: 12)
        $0.numberOfLines = 1
        $0.textColor = UIColorFromRGB(color_vaule: 0xFD8840)
        $0.textAlignment = .center
    }
    
}

//MARK: delegate
extension GiftCollectionViewCell{
    
    
}

//MARK: - action
extension GiftCollectionViewCell {
    
    
}


