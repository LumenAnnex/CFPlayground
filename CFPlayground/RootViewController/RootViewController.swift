//
//  RootViewController.swift
//  CFPlayground
//
//  Created by 晨风 on 2021/3/5.
//

import Foundation
import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbarArray: [[String: String]] = [["rootVCClassString"  :"HomeViewController",
                                                "title"  : "微信",
                                                "imageName"    : "tabbar_mainframe",
                                                "selectedImageName" : "tabbar_mainframeHL"],
                                               ["rootVCClassString"  : "DiscoverViewController",
                                                "title"  : "发现",
                                                "imageName"    : "tabbar_discover",
                                                "selectedImageName" : "tabbar_discoverHL"],
                                               ["rootVCClassString"  : "MineViewController",
                                                "title"  : "我的",
                                                "imageName"    : "tabbar_me",
                                                "selectedImageName" : "tabbar_meHL"]]
        
        for item in tabbarArray {
            guard let className = item["rootVCClassString"], let vcType = swiftClassFromString(className: className) as? UIViewController.Type else {
                return
            }
            let vc: UIViewController = vcType.init()
            vc.title = item["title"]
            
            let nav: CFNavigationController = CFNavigationController(rootViewController: vc)
            let currentBar = nav.tabBarItem
            currentBar?.title = item["title"]
            currentBar?.image = UIImage(named: item["imageName"] ?? "")
            currentBar?.selectedImage = UIImage(named: item["selectedImageName"] ?? "")
            self.addChild(nav)
        }
        
        
    }
    
    /// 在swift中使用NSClassFromString className要加工程名前缀
    ///
    /// - Parameter className: className
    func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            // YourProject.className
            let classStringName = appName + "." + className
            return NSClassFromString(classStringName)
        }
        return nil;
    }
}

