//
//  UserInfo.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/22.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "UserInfo.h"
@implementation UserInfo


- (NSArray *)saveModelColumns
{
    return @[@"use_name",@"passWord",@"identify",@"phone",@"userId"];
}

- (NSDictionary *)saveInnerModels
{
    return @{@"NSArray":@"list"};
}

- (NSString *)tableName
{
    return @"UserInfo";
}

- (NSString *)primaryKey
{
    return @"identify";
    
}

@end
