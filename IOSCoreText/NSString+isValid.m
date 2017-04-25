//
//  NSString+isValid.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "NSString+isValid.h"

@implementation NSString (isValid)

- (BOOL)isValid
{
  
    if(self.length==0||self == nil)
    {
        return NO;
    }
    return YES;
    
}

@end
