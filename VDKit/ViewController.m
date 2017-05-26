//
//  ViewController.m
//  VDKit
//
//  Created by Donald on 17/5/23.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseManager.h"
#import "UserInfo.h"
#import "Object_Info.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    DataBaseManager  * shareManager = [DataBaseManager shareManager];
    [shareManager openDataBase];
    UserInfo * info = [UserInfo new];
    Interest * interest = [Interest new];
    info.list = @[interest];
    
    Job * job = [Job new];
    info.job = job;
    
    [shareManager saveObject:info];
    
    
    
    [[Object_Info alloc]initWithClass:NSClassFromString(@"Model")];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
