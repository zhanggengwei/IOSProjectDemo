//
//  ViewController.m
//  mongoose.c mongoose.h MongooseDaemon.h MongooseDaemonDemo
//
//  Created by Donald on 17/4/12.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "MongooseDaemon.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MongooseDaemon new]startMongooseDaemon:@"10086"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
