//
//  WYTabBarController.swift
//  WYLearnSwift
//
//  Created by  lichong on 16/8/31.
//  Copyright © 2016年 carsmart. All rights reserved.
//

import UIKit

class WYTabBarController: UITabBarController {

    override  class func initialize(){
         super.initialize()
          let tabBar = UITabBar.appearance()
        tabBar.tintColor = YMColor(111, g: 111, b: 111, a: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
      
        // Do any additional setup after loading the view.
    }

    func addChildViewControllers() -> Void {
        
        addTabBarController(WYHomeViewController(), title: "首页", imgName:  "home_tabbar_22x22_", selectImgName: "home_tabbar_press_22x22_")
    }
    
    
    func addTabBarController(viewController:UIViewController,title:String,imgName:String,selectImgName:String) -> Void {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imgName)
        viewController.tabBarItem.selectedImage = UIImage(named: selectImgName)
        
        let navVC = WYNavigationViewController(rootViewController:viewController)
        addChildViewController(navVC)
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
