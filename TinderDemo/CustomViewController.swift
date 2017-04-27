//
//  CustomViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/27.
//  Copyright © 2017年 Susu. All rights reserved.
//

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
