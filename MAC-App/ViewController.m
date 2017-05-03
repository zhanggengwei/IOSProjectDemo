//
//  ViewController.m
//  MAC-App
//
//  Created by Donald on 17/5/3.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "BLEServerSocket.h"
@implementation ViewController
{
    BLEServerSocket *serverListen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    serverListen = [[BLEServerSocket alloc]init];
    [serverListen startServer];
//    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
//    NSLog(@"%@",@"dfdfdf");
//    [runloop run];
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
