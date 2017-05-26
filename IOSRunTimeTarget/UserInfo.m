//
//  UserInfo.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/22.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "UserInfo.h"
@implementation UserInfo


- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}


- (NSArray *)saveModelColumns
{
    return @[@"use_name",@"passWord",@"userId",@"date",@"phone",@"isFriend"];
}

- (NSDictionary *)saveInnerModels
{
    return @{@"Interest":@"list",@"Job":@"job"};
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
