//
//  TinderTabBarViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/26.
//  Copyright © 2017年 Susu. All rights reserved.
//

import UIKit

class TinderViewController: UIViewController,UIScrollViewDelegate {
    var start: Float = 0.0
    var scrollView:UIScrollView = UIScrollView();
    var width:Int =  Int(UIScreen.main.bounds.size.width);
    var height:Int = Int(UIScreen.main.bounds.size.height);
    var controllerArray:NSMutableArray = NSMutableArray.init();
    var currentController:CustomViewController?;
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        scrollView.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self;
        
        self.view.addSubview(scrollView)
        scrollView.isPagingEnabled = true;
        
    
        let leftController = NavController(controller: LeftViewController.init());
        
        let homeController = NavController(controller: HomeViewController.init());
        let rightController = NavController(controller: RightViewController.init());
        controllerArray.setArray([leftController,homeController,rightController]);
        self.setChildViewController(array: controllerArray);
        
        
    
//        //let panGesture = UIPanGestureRecognizer.init(target: self, action:#selector(TinderViewController.panDragView(gestures:)));
//       // self.view.addGestureRecognizer(panGesture);
//        self.addChildViewController(leftController);
//        self.addChildViewController(homeController);
//        self.addChildViewController(rightController);
//        
//        leftController.willMove(toParentViewController: self);
//        homeController.willMove(toParentViewController: self);
//        rightController.willMove(toParentViewController: self);
//        
//        leftController.view.frame = CGRect.init(x: 0, y: 0, width: width, height: height);
//        
//        homeController.view.frame = CGRect.init(x:width, y: 0, width: width, height: height);
//        rightController.view.frame = CGRect.init(x:width * 2, y: 0, width: width, height: height);
//        scrollView.addSubview(leftController.view);
//        scrollView.addSubview(homeController.view);
//        scrollView.addSubview(rightController.view);
//        scrollView.contentSize = CGSize.init(width: width * 3, height: height);
        scrollView.setContentOffset(CGPoint.init(x:width, y: 0), animated: false)
        
    
        // Do any additional setup after loading the view.
    }
    private func setChildViewController(array:NSArray) -> Void
    {
        
        var index:Int = 0;
        for controller in array
        {
            self.addChildViewController(controller as! UINavigationController);
            (controller as! UINavigationController).willMove(toParentViewController: self);
            (controller as! UINavigationController).view.frame = CGRect.init(x:index * width, y: 0, width: width, height: height);
            scrollView.addSubview((controller as! UINavigationController).view);
            index += 1;
        }
        
        scrollView.contentSize = CGSize.init(width: width * index, height: height);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func  NavController(controller:UIViewController)->UINavigationController
    {
        return NavTinderController.init(rootViewController:controller);
    }
    
   
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var direction:TinderDirection = TinderDirection.TinderTabBarDirectionRight;
        let distance:Float = Float.init(scrollView.contentOffset.x) - start;
        if(distance > 0)
        {
            direction = TinderDirection.TinderTabBarDirectionRight;
            
        }
        else
        {
            direction = TinderDirection.TinderTabBarDirectionLeft;
        }
        self.currentController?.distanceChangeChanged(displacement: fabs(distance), direction: direction);
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        start =  Float.init(scrollView.contentOffset.x);
        
        let index:Int = Int.init(scrollView.contentOffset.x) / width;
        
        let navController:UINavigationController = (self.controllerArray[index] as! UINavigationController);
        let controller:CustomViewController = navController.topViewController as! CustomViewController;
        
        self.currentController = controller;
  
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentController?.distanceEndChanged();
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDecelerating");
//         print("%d",scrollView.contentOffset.x);
       
    }

}
