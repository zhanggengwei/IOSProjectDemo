//
//  NSObject+NSObject_Serialization.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/22.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "NSObject+NSObject_Serialization.h"
#import <objc/runtime.h>
#import <objc/message.h>

@protocol testProtrocal <NSObject>

- (void)test;

@end

@implementation NSObject (NSObject_Serialization)

+ (void)load
{
    Protocol * protocal = objc_getProtocol("testProtrocal");
    NSLog(@"%d",class_addProtocol(self.class, protocal));
    
    
}

@end
