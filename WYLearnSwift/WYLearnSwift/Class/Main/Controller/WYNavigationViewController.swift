//
//  WYNavigationViewController.swift
//  WYLearnSwift
//
//  Created by  lichong on 16/8/31.
//  Copyright © 2016年 carsmart. All rights reserved.
//

import UIKit

class WYNavigationViewController: UINavigationController {

    //初始化类方法
    override class func initialize(){
      super.initialize()
      let navbar = UINavigationBar.appearance()
        navbar.barTintColor = UIColor.whiteColor()
        navbar.tintColor = YMColor(0, g: 0, b: 0, a: 0.7)
        navbar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(17)];
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        if viewControllers.count > 1 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_28x28_"),style: .Plain ,target:self, action:#selector(navigationBack))
        }
        
    }
    
    
    func navigationBack() -> Void {
        popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
