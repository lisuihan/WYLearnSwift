//
//  WYScrollTitleView.swift
//  WYLearnSwift
//
//  Created by  lichong on 16/9/2.
//  Copyright © 2016年 carsmart. All rights reserved.
//

import UIKit
import SnapKit

class WYScrollTitleView: UIView {
    
    //数据类型
    var titles = [YMHomeTopTitle]()
    
    var labels = [YMTitleLabel]()
    
    private var labelWidths = [CGFloat]()
    /// 记录当前选中的下标
    private var currentIndex = 0
    /// 记录上一个下标
    private var oldIndex = 0
    
    var addBtnClickClosure:(() ->())?
    //闭包
    var didSelectTitleLabel : ((titleLabel: YMTitleLabel) ->())?
    var titlesClosure: ((titleArray:[YMHomeTopTitle]) ->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        HomeRequestHelper.shareRequestHelper.loadHomeTopTileData { [weak self](topTitles) in
            
            let dict = ["category":"__all__","name": "推荐"]
            let recommend = YMHomeTopTitle(dict:dict)
            self?.titles.append(recommend)
            self?.titles += topTitles;
            self?.setUpUI();
            
        }
    }
    
    private func setUpUI(){
        
        addSubview(scrollView)
        addSubview(addButton)
        
        scrollView.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(addButton.snp_left)
        }
        addButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        //设置titleLabel
        setupTitlesLable()
        //设置label的位置
        setLabelPosition()
        
        titlesClosure?(titleArray:titles)
    }
    func didSelectTitleLabelClosure(closure:(titlLabel: YMTitleLabel) -> ()) {
       didSelectTitleLabel = closure
    }
    
    //暴露给外界
    func titleArrayClosure(closure:(titleArray:[YMHomeTopTitle]) -> ()) {
        titlesClosure = closure
    }
    
    //懒加载button
    private lazy var addButton : UIButton = {
    
        let button = UIButton()
        button.setImage(UIImage(named:"add_channel_titlbar_16x16_"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(addButtonClick), forControlEvents: .TouchUpInside)
        return button;
    }()
    
    //懒加载
    private lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    
    func addButtonClick(){
        addBtnClickClosure?()
       
    }
    
    override var frame: CGRect{
        didSet{
           let newFrame = CGRectMake(0, 0, SCREENW, 44)
            super.frame = newFrame
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
extension WYScrollTitleView : UIScrollViewDelegate{

    
    private func setupTitlesLable(){
        for (index,topic) in titles.enumerate() {
            let label = YMTitleLabel()
            label.text = topic.name
            label.tag = index
            label.textColor = YMColor(235, g: 235, b: 235, a: 1.0)
            label.textAlignment = NSTextAlignment.Center
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelOnClick(_:)))
            label.addGestureRecognizer(tap)
            label.font = UIFont.systemFontOfSize(17)
            label.sizeToFit()
            label.width += kMargin
            labels.append(label)
            labelWidths.append(label.width)
            scrollView.addSubview(label)
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
        
    }
    
    private func setLabelPosition() -> Void {
        var titleX : CGFloat = 0.0
        let titleY : CGFloat = 0.0
        var titleW : CGFloat = 0.0
        let  titleH = self.height
        for (index,label) in labels.enumerate() {
            titleW = labelWidths[index]
            titleX = kMargin
            if index != 0 {
                let lastLabel  = labels[index - 1]
                titleX = CGRectGetMaxX(lastLabel.frame) + kMargin
            }
            label.frame = CGRectMake(titleX, titleY, titleW, titleH);
        }
        if let lastLabel = labels.last {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
        }
        
    }
    
    func titleLabelOnClick(gesture : UITapGestureRecognizer){
        guard let currentLabel = gesture.view as? YMTitleLabel else{
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = YMColor(235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
        adjustTitleOffSetToCurrentIndex(currentIndex, oldIndex: oldIndex)
        didSelectTitleLabel?(titleLabel: currentLabel)
    }
    
    func adjustTitleOffSetToCurrentIndex(currentIndex : Int ,oldIndex : Int) -> Void {
        guard oldIndex != currentIndex else{
            return
        }
        let oldLabel = labels[oldIndex]
        let currentLabel = labels[currentIndex]
        currentLabel.currentScale = 1.1
        currentLabel.textColor = UIColor.whiteColor()
        oldLabel.currentScale = 1.0
        oldLabel.textColor = YMColor(235, g: 235, b: 235, a: 1.0)
        
        var offsetX = currentLabel.centerX - SCREENW * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        var  maxOffsetX = scrollView.contentSize.width - (SCREENW - addButton.width)
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        
        scrollView.setContentOffset(CGPointMake(offsetX, 0), animated: true)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}



class YMTitleLabel: UILabel {
    
    var currentScale : CGFloat = 1.0 {
    
        didSet{
          transform = CGAffineTransformMakeScale(currentScale, currentScale)
        }
    }
    
    
}












