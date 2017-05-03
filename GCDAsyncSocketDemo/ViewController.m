//
//  ViewController.m
//  GCDAsyncSocketDemo
//
//  Created by Donald on 17/5/3.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "HTTPServer.h"
#import "BLEServerSocket.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[BLEServerSocket new]startServer];
    
    
  
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
