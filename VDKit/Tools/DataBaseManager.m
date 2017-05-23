//
//  DataBaseManager.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/23.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "DataBaseManager.h"
#import <sqlite3.h>

@implementation DataBaseManager
{
    NSString * dataBaseName;
    NSString * dataBasePath;
}

+ (instancetype)shareManager
{
    
    return [DataBaseManager new];
    
}

- (void)dataBaseInit
{
    
    
}

- (void)openDataBase{}

- (void)closeDataBase{}




@end
