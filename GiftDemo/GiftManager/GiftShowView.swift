//
//  GiftShowView.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit


class GiftShowView: UIView {

    let animationTime: Int = 3
    var finishModel: GiftModel?
    //当前礼物总数
    var currentGiftCount: Int = 0
    //礼物数
    var giftCount: Int = 0
    
    var showViewKeyBlock: ((GiftModel) -> Void)?
    var showViewFinishBlock : ((Bool, String) -> Void)?
        
    /** 返回当前礼物的唯一key */
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isHidden = true
        settingUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Data
    
    //MARK: - UI
    func settingUpUI () {
        
        addSubview(bgView)
        bgView.addSubview(userIconView)
        bgView.addSubview(userNameLabel)
        bgView.addSubview(giftNameLabel)
        bgView.addSubview(giftImageView)
        addSubview(countLabel)
        
        
        bgView.snp.makeConstraints { (make) in
            
            make.left.equalTo(Adap(value: 10))
            make.top.bottom.equalToSuperview()
            make.right.equalTo(Adap(value: 55))
        }
        
        userIconView.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.left.equalTo(Adap(value: 3))
            make.size.equalTo((CGSize(width: Adap(value: 44), height: Adap(value: 44))))
        }
        
        giftImageView.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.right.equalTo(Adap(value: -5))
            make.size.equalTo((CGSize(width: Adap(value: 50), height: Adap(value: 50))))
        }
        
        
        userNameLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(Adap(value: 10))
            make.left.equalTo(userIconView.snp_right).offset(Adap(value: 3))
            make.right.equalTo(giftImageView.snp_right).offset(Adap(value: -5))
            make.height.equalTo(userNameLabel.font.lineHeight)
        }
        
        giftNameLabel.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(Adap(value: -10))
            make.left.equalTo(userIconView)
            make.right.equalTo(userIconView)
            make.height.equalTo(giftNameLabel.font.lineHeight)
        }
        
        countLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(bgView.snp_right).offset(Adap(value: 5))
            make.top.bottom.equalToSuperview()
            make.right.equalTo(Adap(value: -10))
        }
        
    }
    
    
    
    //MARK: members
    private lazy var bgView = UIView(frame: .zero).then{
        $0.backgroundColor = .black
        $0.layer.cornerRadius = self.height * 0.5
    }
    
    private lazy var userIconView = UIImageView().then{
        $0.layer.cornerRadius = Adap(value: 22)
        $0.layer.masksToBounds = true
    }
    
    private lazy var userNameLabel = UILabel().then{
        
        $0.font = Fonts(fontSize: 11)
        $0.numberOfLines = 1
        $0.textColor = UIColorFromRGB(color_vaule: 0xffffff)
    }
    
    private lazy var giftNameLabel = UILabel().then{
        
        $0.font = Fonts(fontSize: 12)
        $0.numberOfLines = 1
        $0.textColor = .red
    }
    
    private lazy var giftImageView = UIImageView().then{
        $0.backgroundColor = .clear
    }
    
    private lazy var countLabel = UILabel().then{
        
        $0.textAlignment = .center
        $0.font = BoldFonts(fontSize: 20)
        $0.numberOfLines = 1
        $0.textColor = .orange
    }
    
}

//MARK: delegate
extension GiftShowView {}

//MARK: - action
extension GiftShowView {
    
    
    /// 展示礼物动效
    /// - Parameters:
    ///   - giftModel: 礼物的数据
    ///   - completeBlock: 展示完毕回调
    func showGiftShowView(giftModel: GiftModel?,
                          completeBlock: ((_ finished: Bool, _ giftKey: String) -> Void)?) {
        
        self.finishModel = giftModel
        userIconView.kf.setImage(with: URL(string: giftModel?.userIcon ?? ""), placeholder: nil)
        userNameLabel.text = giftModel?.userName
        giftNameLabel.text = "送 %" + (giftModel?.giftName ?? "")
        giftImageView.kf.setImage(with: URL(string: giftModel?.giftImage ?? ""), placeholder: nil)
        self.isHidden = false
        self.showViewFinishBlock = completeBlock
        print("当前展示的礼物-" + (giftModel?.giftName ?? ""))
        if (self.currentGiftCount == 0 && giftModel != nil) {
            self.showViewKeyBlock?(giftModel!)
        }
        UIView.animate(withDuration: 0.3) {
            self.x = 0
        } completion: {[weak self] (finish) in
            self?.currentGiftCount = 0
            self?.giftCount = giftModel?.defaultCount ?? 1
            self?.updateGiftCount()
        }

    }
    
    @objc func hiddenGiftShowView() {
        
        UIView.animate(withDuration: 0.3) {
            self.x = -self.width
        } completion: {[weak self] (finish) in
            
            if self?.showViewFinishBlock != nil {
                self?.showViewFinishBlock?(true, self?.finishModel?.giftKey ?? "")
                self?.finishModel = nil
            }
            
            self?.x = -(self?.width ?? kScreenWidth)
            self?.isHidden = true
            self?.currentGiftCount = 0
            self?.countLabel.text = ""
        }
    }
    
    func updateGiftCount() {
        self.currentGiftCount += giftCount
        self.countLabel.text = "x" + "\(self.currentGiftCount)"

        if (self.currentGiftCount > 1) {
            p_SetAnimation(view: countLabel)
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hiddenGiftShowView), object: nil)
            self.perform(#selector(hiddenGiftShowView), with: nil, afterDelay: TimeInterval(animationTime))
            
        } else {
            self.perform(#selector(hiddenGiftShowView), with: nil, afterDelay: TimeInterval(animationTime))
        }
    }
    
    func p_SetAnimation(view: UIView) {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulse.duration = 0.08
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = 1.0
        pulse.toValue = 1.5
        view.layer.add(pulse, forKey: "leftRotation")
    }
}


