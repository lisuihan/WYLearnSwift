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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        HomeRequestHelper.shareRequestHelper.loadHomeTopTileData { (topTitles) in
            
        }
        setUpUI()
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
            scrollView.addSubview(label)
            label.font = UIFont.systemFontOfSize(17)
            label.sizeToFit()
            labels.append(label)
            labelWidths.append(label.width)
            
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
        
    }
    
    func titleLabelOnClick(gesture : UITapGestureRecognizer){
        
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












