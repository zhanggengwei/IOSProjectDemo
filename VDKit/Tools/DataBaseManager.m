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
    sqlite3 *  dataBase;
}

+ (instancetype)shareManager
{
    
    return [DataBaseManager new];
    
}

- (instancetype)init
{
    if(self = [super init])
    {
      
        dataBasePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES).firstObject stringByAppendingString:@"/table.db"];
        NSLog(@"dataBasePath == %@",dataBasePath);
        dataBaseName = @"table.db";
        [self dataBaseInit];
        
    }
    return self;
}

- (void)dataBaseInit
{
    
    if([self.delegate respondsToSelector:@selector(dataBaseUrl)])
    {
        dataBasePath = [self.delegate dataBaseUrl];
    }
    if ([self.delegate respondsToSelector:@selector(dataBaseName)])
    {
        dataBaseName = [self.delegate dataBaseName];
    }
    
    NSFileManager * defaultManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exists = [defaultManager fileExistsAtPath:dataBasePath isDirectory:&isDir];
    if(isDir)
    {
        NSLog(@"error path");
        return;
    }
    //不存在重新创建
    if(false==exists)
    {
        BOOL sucessed = [defaultManager createFileAtPath:dataBasePath contents:nil attributes:nil];
        if(sucessed)
        {
            NSLog(@"create file sucessed");
        }else
        {
            NSLog(@"create file failed");
        }
    }
    
    
}

- (void)openDataBase
{
    

    if(sqlite3_open(dataBasePath.UTF8String, &dataBase)==SQLITE_OK)
    {
        NSLog(@"打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
}

- (void)saveObject:(NSObject *)object
{
   
}

- (void)updateObject:(NSObject *)object
{
    
}

- (void)deleteObject:(NSInteger)identify
{
    
}

- (void)transitication



@end
