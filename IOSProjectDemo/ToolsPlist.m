//
//  ToolsPlist.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/10.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ToolsPlist.h"

@implementation ToolsPlist

- (NSDictionary *)loadPlistDict
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

@end
