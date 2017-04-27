//
//  AnimateViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/27.
//  Copyright © 2017年 Susu. All rights reserved.
//

import UIKit

class AnimateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        
        let imageView:UIImageView = UIImageView.init(frame: self.view.bounds);
        imageView.image = UIImage.init(named:"近期活动");
        self.view.addSubview(imageView);
        
        let animation:CABasicAnimation = CABasicAnimation.init(keyPath:"contents");
        animation.duration = 1;
        animation.timingFunction = CAMediaTimingFunction.init(name:kCAMediaTimingFunctionEaseIn);
        animation.fromValue = UIImage.init(named:"近期活动")?.cgImage;
        animation.toValue = UIImage.init(named:"tinder-2")?.cgImage;
        
        
        animation.isRemovedOnCompletion = true;
        animation.repeatCount = 100;
        imageView.layer.add(animation, forKey: "a");
        
        
        

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
