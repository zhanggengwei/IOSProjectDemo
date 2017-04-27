//
//  CustomViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/27.
//  Copyright © 2017年 Susu. All rights reserved.
//所以关于事件的链有两条：事件的 响应链 ；Hit-Testing 时事件的 传递链 。

//事件响应链：由离用户最近的 View 向系统传递：
//
//initial view –> Super View –> …… –> View Controller –> Window –> Application –> AppDelegate
//
//事件传递链：由系统向离用户最近的 View 传递：
//
//UIKit –> active app’s event queue –> Window –> Root View –> …… –> Lowest View

import UIKit

public enum TinderDirection : Int
{
    case TinderTabBarDirectionLeft
    case TinderTabBarDirectionRight
}

class CustomViewController: UIViewController {
    public var width:Int =  Int(UIScreen.main.bounds.size.width);
    public var height:Int = Int(UIScreen.main.bounds.size.height);
    public func distanceChangeChanged(displacement: Float,direction:TinderDirection) {
        
        
    }
    public func distanceEndChanged() {
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
