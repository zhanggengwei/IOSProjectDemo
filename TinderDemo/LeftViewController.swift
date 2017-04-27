//
//  LeftViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/26.
//  Copyright © 2017年 Susu. All rights reserved.
//

import UIKit

class LeftViewController: CustomViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LeftViewController"
        self.view.backgroundColor = UIColor.red;
        
        

        // Do any additional setup after loading the view.
    }
    override func distanceChangeChanged(displacement: Float, direction: TinderDirection) {
        
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
