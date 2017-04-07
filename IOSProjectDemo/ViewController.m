//
//  ViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    NSLog(@"%s",__func__);
}
- (void)loadViewIfNeeded
{
    [super loadViewIfNeeded];
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    //NSLog(@"%@",__FUNCTION__);
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}
// Called when the view is about to made visible. Default does nothing
- (void)viewDidAppear:(BOOL)animated

{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}    // Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewWillDisappear:(BOOL)animated

{
    
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
} // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated

{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}
// Called after the view was dismissed, covered or otherwise hidden. Default does nothing

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews NS_AVAILABLE_IOS(5_0)

{
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__func__);
}
// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews NS_AVAILABLE_IOS(5_0)

{
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s",__func__);
    // Dispose of any resources that can be recreated.
}
/*
 2017-04-07 10:15:30.465 IOSProjectDemo[3458:210174] -[ViewController loadView]
 2017-04-07 10:15:30.465 IOSProjectDemo[3458:210174] -[ViewController viewDidLoad]
 2017-04-07 10:15:30.466 IOSProjectDemo[3458:210174] -[ViewController viewWillAppear:]
 2017-04-07 10:15:30.471 IOSProjectDemo[3458:210174] -[ViewController viewWillLayoutSubviews]
 2017-04-07 10:15:30.471 IOSProjectDemo[3458:210174] -[ViewController viewDidLayoutSubviews]
 2017-04-07 10:15:30.474 IOSProjectDemo[3458:210174] -[ViewController viewDidAppear:]
 */

@end
