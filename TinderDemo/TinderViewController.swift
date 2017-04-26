//
//  TinderTabBarViewController.swift
//  IOSProjectDemo
//
//  Created by Donald on 17/4/26.
//  Copyright © 2017年 Susu. All rights reserved.
//

import UIKit

public enum TinderDirectionLeft : Int
{
    case TinderTabBarDirectionLeft
    case TinderTabBarDirectionRight
}

class TinderViewController: UIViewController,UIScrollViewDelegate {
    var start: CGFloat = 0.0
    var scrollView:UIScrollView = UIScrollView()
    var width:Double = Double(UIScreen.main.bounds.size.width);
    var height:Double = Double(UIScreen.main.bounds.size.height);
    
  
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
    
        //let panGesture = UIPanGestureRecognizer.init(target: self, action:#selector(TinderViewController.panDragView(gestures:)));
       // self.view.addGestureRecognizer(panGesture);
        self.addChildViewController(leftController);
        self.addChildViewController(homeController);
        self.addChildViewController(rightController);
        
        leftController.willMove(toParentViewController: self);
        homeController.willMove(toParentViewController: self);
        rightController.willMove(toParentViewController: self);
        
        leftController.view.frame = CGRect.init(x: 0, y: 0, width: width, height: height);
        
        homeController.view.frame = CGRect.init(x:width, y: 0, width: width, height: height);
        rightController.view.frame = CGRect.init(x:width * 2, y: 0, width: width, height: height);
        scrollView.addSubview(leftController.view);
        scrollView.addSubview(homeController.view);
        scrollView.addSubview(rightController.view);
        scrollView.contentSize = CGSize.init(width: width * 3, height: height);
        scrollView.setContentOffset(CGPoint.init(x:width, y: 0), animated: false)
    
        // Do any additional setup after loading the view.
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
        print("%d",scrollView.contentOffset.x - start);
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        start =  scrollView.contentOffset.x;
        
//        print("scrollViewWillBeginDragging");
//         print("%d",scrollView.contentOffset.x);
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndScrollingAnimation");
//         print("%d",scrollView.contentOffset.x);
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating");
//         print("%d",scrollView.contentOffset.x);
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDecelerating");
//         print("%d",scrollView.contentOffset.x);
        
    }

}
