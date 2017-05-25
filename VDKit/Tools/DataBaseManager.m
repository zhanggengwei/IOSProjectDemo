//
//  DataBaseManager.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/23.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "DataBaseManager.h"
#import <FMDB.h>
#import "Data_ObjectProtrocal.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define char_Length 100



@implementation DataBaseManager
{
    NSString * dataBaseName;
    NSString * dataBasePath;
    FMDatabase * _db;
    FMDatabasePool * _dbPool;
    BOOL _open;
    
    
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
        _db = [[FMDatabase alloc]initWithPath:dataBasePath];
        /*
            进行表的结构的检查，表结构变化更改结构
         
         
         
         
         
         */
        
        [self dataBaseInit];
        [self checkTables];
        
    }
    return self;
}

- (void)checkTables
{
    
    if([self.delegate respondsToSelector:@selector(dataBaseTableClassName)])
    {
        NSArray * classArray = [self.delegate dataBaseTableClassName];
        
        
        
    }

    
    
    
    
    
    
    
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
    
    _open = [_db open];
    
    
    
}

- (void)openDataBase
{
    
}

- (void)saveObject:(NSObject<Data_ObjectProtrocal> *)object
{

    
    NSLock * lock = [NSLock new];
    [lock lock];
    
    FMResultSet * result = [_db executeQuery:@"select * from UserInfo"];
    
    NSMutableArray * array = [NSMutableArray new];
    int i = 0;
    while (i<result.columnCount)
    {
        [array addObject:[result columnNameForIndex:i++]];
    }
    
    if([object respondsToSelector:@selector(saveModelColumns)])
    {
        NSArray<NSString *> * columnNames = [object saveModelColumns];
        if([array isEqualToArray:columnNames])
        {
            NSLog(@"表的结构没有发生变化");
        }
        NSMutableString * createTableSql = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"create table if not exists %@ (",object.class]];
        for (NSString * obj in columnNames)
        {
            
            NSString * lastPrefixx = [obj isEqualToString:columnNames.lastObject]?@")":@",";
            [createTableSql appendString:[NSString stringWithFormat:@"%@ varchar(%d) %@",obj,char_Length,lastPrefixx]];
        }
        BOOL createTable = [_db executeUpdate:createTableSql];
        if(createTable)
        {
            NSLog(@"create table sucessed ");
        }else
        {
            NSLog(@"%@",[_db lastErrorMessage]);
        }
        
    }
    
    [lock unlock];
    
    
    
    
}



- (void)updateObject:(NSObject *)object
{
    
}

- (void)deleteObject:(NSInteger)identify
{
    
}


- (void)logErrorMessage
{
    
}


- (void)closeDataBase
{
    
}




@end
