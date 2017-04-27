//
//  HomeViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/26.
//  Copyright © 2017年 Susu. All rights reserved.
//

import UIKit

class HomeViewController: CustomViewController {

   private var _button:UIButton? = UIButton.init(type: UIButtonType.custom);
    private var _start:CGFloat?;
   private var button:UIButton
    {
    
        get
        {
            return _button!;
        }
        set
        {
            _button = button;
        }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
//        self.edgesForExtendedLayout = UIEdage
        //self.title = "HomeViewController"
        self.view.backgroundColor = UIColor.yellow
        self.button.frame = CGRect.init(x:200, y: 0, width:30, height:30)
        self.navigationItem.titleView = self.button;
        self.button.setImage(UIImage.init(named: "tinder-2"), for: UIControlState.normal);
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "tinder"), style: UIBarButtonItemStyle.plain, target: nil, action: nil);
        self.button.isUserInteractionEnabled = false;
        
        //self.navigationController?.navigationBar.addSubview(self.button);
        //self.view.addSubview(self.button);
        
     
        
        
        
        
        
        
        
        
        
        
        // Do any additional setup(( after load)i)ng the view.
    }
  
    override func distanceChangeChanged(displacement: Float, direction: TinderDirection) {
       
        let WIDTH:Float = Float(UIScreen.main.bounds.size.width);
        print(displacement);
        let percentage:Float = displacement/WIDTH * Float.init(0.55);
        
        self.button.transform = CGAffineTransform(scaleX:1 - CGFloat(percentage), y: 1 - CGFloat(percentage));

         let radio:CGFloat = (0.5 * CGFloat(width) - 30)/CGFloat(width);
        
        
       // self.button.center = CGPoint.init(x:CGFloat(width) * 0.5 - CGFloat(CGFloat(displacement) * radio)-30 * radio, y: self.button.center.y);
       // self.button.transform = CGAffineTransform.init(translationX:10, y: 0);
        
        
        
        print(self.button.center.x);
       
        
    }
    override func distanceEndChanged(){
        //button 返回 卡顿
//        UIView.animate(withDuration: 0.06) {
         //  self.button.center = CGPoint.init(x:CGFloat.init(self.width) * 0.5, y:self.button.center.y);
            self.button.transform = CGAffineTransform.identity;
            
//        };
       
        //self.button.center = CGPoint.init(x:CGFloat.init(width) * 0.5, y:22);
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
