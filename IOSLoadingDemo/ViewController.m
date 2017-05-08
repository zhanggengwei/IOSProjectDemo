//
//  ViewController.m
//  IOSLoadingDemo
//
//  Created by Donald on 17/5/8.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "TriangleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TriangleView * view = [[TriangleView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
