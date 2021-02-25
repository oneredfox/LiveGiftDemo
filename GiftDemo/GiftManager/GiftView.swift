//
//  GiftView.swift
//  GiftDemo
//
//  Created by LZX on 2021/2/24.
//

import UIKit
import Foundation

@objc class GiftView: UIView {

    //充值
    var getMoneyBlock: ((GiftView) -> Void)?
    //赠送礼物
    var giftViewSendGiftBlock: ((GiftView, GiftCellListModel) -> Void)?
        
    var dataArray: [GiftCellListModel] = []
    //上一次点击的model
    var preModel: GiftCellListModel?
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight)
        settingUpUI()
        block()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Data
   
    
    //MARK: - UI
    func settingUpUI () {
        
        addSubview(collectionView)
        addSubview(bottomView)
        addSubview(lineView)
        addSubview(hidenView)
        
        bottomView.addSubview(ccbImage)
        bottomView.addSubview(getMoneyBtn)
        bottomView.addSubview(moneyLabel)
        bottomView.addSubview(sendBtn)
        bottomView.addSubview(choseCountBgView)
        bottomView.addSubview(pageControl)
        
        choseCountBgView.addSubview(choseCountImageView)
        choseCountBgView.addSubview(choseCountLabel)

        bottomView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(Adap(value: 55) + SYS_XTAB_SPACE)
        }
        
        lineView.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(lineView.snp_top)
            make.height.equalTo(GiftUIFrameInfo.showGiftView_itemH * 2 + GiftUIFrameInfo.showGiftView_itemEdgeInsets.top + GiftUIFrameInfo.showGiftView_itemEdgeInsets.bottom + GiftUIFrameInfo.showGiftView_lineSpace)
        }
        
        hidenView.snp.makeConstraints { (make) in
            
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(collectionView.snp_top)
        }
        
        ccbImage.snp.makeConstraints { (make) in
            
            make.left.equalTo(Adap(value: 15))
            make.centerY.equalToSuperview().offset(-SYS_XTAB_SPACE)
            make.size.equalTo((CGSize(width: Adap(value: 18), height: Adap(value: 18))))
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(ccbImage.snp_right).offset(2)
            make.centerY.equalTo(ccbImage)
            make.height.equalTo(moneyLabel.font.lineHeight)
            make.width.greaterThanOrEqualTo(Adap(value: 10))
            make.width.lessThanOrEqualTo(Adap(value: 60))
        }
        
        getMoneyBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(moneyLabel.snp_right).offset(2)
            make.centerY.equalTo(ccbImage)
            make.size.equalTo((CGSize(width: Adap(value: 33), height: Adap(value: 18))))
        }
        
        sendBtn.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(ccbImage)
            make.right.equalTo(Adap(value: -14))
            make.size.equalTo((CGSize(width: Adap(value: 80), height: Adap(value: 32))))
        }
        
        choseCountBgView.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(ccbImage)
            make.right.equalTo(sendBtn.snp_left).offset(-10)
            make.size.equalTo((CGSize(width: Adap(value: 80), height: Adap(value: 32))))
        }
        
        pageControl.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(ccbImage)
            make.right.equalTo(choseCountBgView.snp_left).offset(-10)
            make.size.equalTo((CGSize(width: Adap(value: 50), height: Adap(value: 32))))
        }
        
        choseCountImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(Adap(value: -8))
            make.centerY.equalToSuperview()
            make.size.equalTo((CGSize(width: Adap(value: 10), height: Adap(value: 10))))
        }
        
        choseCountLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.right.equalTo(choseCountImageView.left).offset(-3)
            make.centerY.equalToSuperview()
            make.height.equalTo(choseCountLabel.font.lineHeight)
        }
    }
    
    
    
    //MARK: members
    private lazy var hidenView = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
    }
    
    private lazy var bottomView = UIView(frame: .zero).then{
        $0.backgroundColor = UIColorFromRGB(color_vaule: 0x222222, alpha: 1)
    }
    
    private lazy var lineView = UIView(frame: .zero).then{
        $0.backgroundColor = UIColorFromRGB(color_vaule: 0xffffff)
    }
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = GiftCollectionViewLayout.init()
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - SYS_XTAB_SPACE - SYS_NAV_HEIGHT), collectionViewLayout: layout)
        collectionView.register(GiftCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColorFromRGB(color_vaule: 0x222222, alpha: 1)
        return collectionView
    }()
   
    private lazy var pageControl = UIPageControl(frame: .zero).then{
        $0.currentPageIndicatorTintColor = UIColorFromRGB(color_vaule: 0x8D65FF)
        $0.pageIndicatorTintColor = UIColorFromRGB(color_vaule: 0xffffff, alpha: 0.5)
        $0.isHidden = true
    }
    
    private lazy var moneyLabel = UILabel().then{
        
        $0.text = "0"
        $0.font = Fonts(fontSize: 13)
        $0.numberOfLines = 1
        $0.sizeToFit()
        $0.textColor = UIColorFromRGB(color_vaule: 0xffffff)
    }
    
    private lazy var getMoneyBtn = UIButton().then{
        
        $0.normalTitle = "充值";
        $0.titleFont = Fonts(fontSize: 12)
        $0.normalTitleColor = UIColorFromRGB(color_vaule: 0xffffff)
        $0.addTarget(self, action: #selector(p_ClickGetMoneyBtn(sender:)), for: .touchUpInside)
        $0.backgroundColor = UIColorFromRGB(color_vaule: 0xFFAB04)
        $0.layer.cornerRadius = Adap(value: 4)
    }
    
    private lazy var sendBtn = UIButton().then{
        
        $0.isUserInteractionEnabled = false
        $0.layer.cornerRadius = Adap(value: 16)
        $0.normalTitle = "赠送"
        $0.titleFont = Fonts(fontSize: 14)
        $0.normalTitleColor = UIColorFromRGB(color_vaule: 0x989898)
        $0.backgroundColor = UIColorFromRGB(color_vaule: 0xD9D9D9)
        $0.addTarget(self, action: #selector(p_ClickSendBtn(sender:)), for: .touchUpInside)
    }
    
    private lazy var choseCountBgView = UIView().then{
        
        $0.backgroundColor = UIColorFromRGB(color_vaule: 0xffffff, alpha: 0.1)
        $0.layer.cornerRadius = Adap(value: 16)
    }
    
    private lazy var choseCountLabel = UILabel().then{
        $0.text = "1"
        $0.font = Fonts(fontSize: 16)
        $0.numberOfLines = 1
        $0.textColor = UIColorFromRGB(color_vaule: 0xffffff)
    }
    
    private lazy var choseCountImageView =  UIImageView().then{
        $0.image = UIImage.init(named: "choseCount")
    }
    
    private lazy var ccbImage =  UIImageView().then{
        $0.image = UIImage.init(named: "diamond_icon")
    }
}

//MARK: delegate
extension GiftView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        dataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GiftCollectionViewCell
        cell.model = dataArray[indexPath.row]
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.item < self.dataArray.count) {
            let model = self.dataArray[indexPath.item]
            model.isSelected = !(model.isSelected ?? false)
            sendBtn.backgroundColor = (model.isSelected ?? false) ? UIColorFromRGB(color_vaule: 0xFF4B95) : UIColorFromRGB(color_vaule: 0xD9D9D9)
            sendBtn.normalTitleColor = (model.isSelected ?? false) ? UIColorFromRGB(color_vaule: 0xffffff) : UIColorFromRGB(color_vaule: 0x989898)
            sendBtn.isUserInteractionEnabled = !(model.isSelected ?? false)
            
            if ((self.preModel?.id ?? "") == model.id) {
                collectionView.reloadData()
            } else {
                self.preModel?.isSelected = false
                UIView.performWithoutAnimation {
                    collectionView.reloadSections(IndexSet(integer: 0))
                }
            }
            self.preModel = model
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        self.pageControl.currentPage = Int(x / kScreenWidth + 0.5)
    }
}


//MARK: - action
extension GiftView {
    
    func block() {
        hidenView.addTapGesture {[weak self] in
            self?.hiddenGiftView()
        }
    }
    
    func updateData() {
        pageControl.numberOfPages = (dataArray.count - 1) / 8 + 1
        pageControl.currentPage = 0
        pageControl.isHidden = !(dataArray.count > 1)
        collectionView.reloadData()
    }
    
    func showGiftView() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {[weak self] in
            self?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        }
    }
    
    func hiddenGiftView() {
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: 0, y: 0, width: kScreenHeight, height: kScreenHeight)
        } completion: {[weak self] (finish) in
            self?.removeFromSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {[weak self] in
            self?.frame = CGRect(x: 0, y: 0, width: kScreenHeight, height: kScreenHeight)
            self?.removeFromSuperview()
        }
    }
    
    @objc private func p_ClickGetMoneyBtn(sender: UIButton) {
        //找到已选中的礼物
        getMoneyBlock?(self)
    }
    
    @objc private func p_ClickSendBtn(sender: UIButton) {
        var isBack = false
        for value in dataArray {
            if value.isSelected ?? false {
                isBack = true
                giftViewSendGiftBlock?(self, value)
                break
            }
            
        }
        if (!isBack) {
            //提示选择礼物
            print("没有选择礼物")
        }
    }
    
}
