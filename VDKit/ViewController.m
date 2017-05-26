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
    NSArray * arr = [shareManager queryList:[UserInfo class]];
    NSLog(@"arr =%@",arr);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
