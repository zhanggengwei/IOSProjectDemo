//
//  NSObject+PrintTools.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/10.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "NSObject+PrintTools.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (PrintTools)

+ (void)load
{
    Method premethod = class_getInstanceMethod(self.class, @selector(description));
    Method curmethod = class_getInstanceMethod(self.class, @selector(print_description));
    method_exchangeImplementations(premethod, curmethod);
    
}

- (NSString *)print_description
{
    unsigned int count = 0;
    objc_property_t * propertyList = class_copyPropertyList(self.class, &count);
    
    
    NSMutableString * printString =[NSMutableString stringWithString:@"{"];
    
    for (int i = 0; i < count; i++)
    {
        
        objc_property_t property = propertyList[i];
        const char * name = property_getName(property);
        [printString appendFormat:@"%s",name];
        
        
    }
    free(propertyList);
    [printString appendString:@"}"];
    return printString;
    
}

@end
