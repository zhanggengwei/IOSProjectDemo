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

- (void)viewDidLoad {
    [super viewDidLoad];
    [[BLEServerSocket new]startServer];
    

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
