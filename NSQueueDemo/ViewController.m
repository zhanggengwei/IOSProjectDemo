//
//  ViewController.m
//  NSQueueDemo
//
//  Created by Donald on 17/5/18.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "TestOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TestOperation * operation = [TestOperation new];
//    NSOperationQueue * queue = [NSOperationQueue new];
//    [operation start];
//     NSLog(@"test==%@",queue.name);
//    //[queue addOperation:operation];
    
    
    NSOperationQueue * queue = [NSOperationQueue new];
    
    NSBlockOperation * blockoperation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i =0; i <=10; i++)
        {
            sleep(1);
            NSLog(@"blockoperation thread == %@",[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation * blockoperation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i =0; i <=10; i++)
        {
            sleep(1);
            NSLog(@"blockoperation2 thread == %@",[NSThread currentThread]);
        }
    }];
    [blockoperation2 addDependency:blockoperation];
    [queue addOperations:@[blockoperation] waitUntilFinished:NO];
    [queue addOperations:@[blockoperation2] waitUntilFinished:NO];
    
    NSLog(@"fdsdfsdfsdfsd");
    
    
    
   
    

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
