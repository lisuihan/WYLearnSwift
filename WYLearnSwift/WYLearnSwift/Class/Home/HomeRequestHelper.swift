//
//  HomeRequestHelper.swift
//  WYLearnSwift
//
//  Created by  lichong on 16/9/2.
//  Copyright © 2016年 carsmart. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

typealias successBlock = () -> (NSData)
typealias failureBlock = () -> (NSData)
class HomeRequestHelper: NSObject {

    static let shareRequestHelper = HomeRequestHelper()
    
    //返回多少个数据
    func loadArticleRefreshTip(finished:(count:NSInteger) -> ()) {
        let url = BASE_URL + "2/article/v39/refresh_tip/"
        
        Alamofire.request(.GET, url)
        .responseJSON { (respose) in
            guard respose.result.isSuccess else{
               SVProgressHUD.showErrorWithStatus("加载失败")
                return;
            }
            if let value = respose.result.value{
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                let count = dataDict!["count"]!.int
                finished(count:count!)
            }
        }
        
    }
    
    //获取首页顶部标题内容(和视频内容使用一个接口)
    func loadHomeTopTileData(finished:(topTitles:[YMHomeTopTitle])-> ())  {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let param = ["device_id":device_id,
                     "aid":13,
                     "IID":IID]
        
        Alamofire.request(.POST, url,parameters: param)
        .responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showErrorWithStatus("加载失败")
                return
            }
            
            if let value = response.result.value{
               let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let dataValue = dataDict!["data"]!.arrayObject{
                   var toptics = [YMHomeTopTitle]()
                    for dict in dataValue{
                        let title = YMHomeTopTitle(dict: dict as! [String : AnyObject])
                        toptics.append(title)
                    }
                    finished(topTitles: toptics)
                }
                
            }
        }
        
        
    }
    

}
