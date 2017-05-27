//
//  CustomButton.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/27.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "CustomButton.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation CustomButton


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.delegate = self;
    
    
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[self rac_signalForSelector:@selector(printMessage:)]subscribeNext:^(id x) {
            
            NSLog(@"test");
        }];
        
        NSLog(@"%@ signale",[self rac_signalForSelector:@selector(printMessage:)]);
        
        
        
    }];
    
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.delegate = self;
    }
    return self;
}

- (void)printMessage:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}


@end
