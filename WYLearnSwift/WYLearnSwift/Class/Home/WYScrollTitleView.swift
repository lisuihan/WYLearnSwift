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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        HomeRequestHelper.shareRequestHelper.loadHomeTopTileData { (topTitles) in
            
        }
        setUpUI()
    }
    
    private func setUpUI(){
        
        addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            
        }
    }
    
    //懒加载
    private lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
extension WYScrollTitleView : UIScrollViewDelegate{

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}