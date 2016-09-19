//
//  WYHomeViewController.swift
//  WYLearnSwift
//
//  Created by  lichong on 16/8/31.
//  Copyright © 2016年 carsmart. All rights reserved.
//

import UIKit


class WYHomeViewController: WYBaseViewController {

    
    let tableView = UITableView()
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navigationItem.title = "首页"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建子控件
        createSubView()
        
        //请求数据
        requestDataFromNet()
        
        requestDataTitleFromNet()
        // Do any additional setup after loading the view.
    }
    
    private func createSubView(){
     
       view.backgroundColor = YMGlobalColor()
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.barStyle = .Black
        navigationController?.navigationBar.barTintColor = YMColor(210, g: 63, b: 66, a: 1.0)
        navigationItem.titleView = titleView
        
    }

    private lazy var titleView : WYScrollTitleView = {
    
        let topTitleView = WYScrollTitleView()
        return topTitleView;
        
    }()
    
    
    //获取多少条数据
    private func requestDataFromNet(){
       
        HomeRequestHelper.shareRequestHelper.loadArticleRefreshTip {[weak self](count) in
            print(count)
        }
    }
    
    private func requestDataTitleFromNet(){
    
        HomeRequestHelper.shareRequestHelper.loadHomeTopTileData {[weak self] (topTitles) in
            print(topTitles)
        }
    }
    deinit{
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension WYHomeViewController{

}
