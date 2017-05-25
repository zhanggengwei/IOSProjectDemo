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
        for (NSString * className in classArray)
        {
            //表结构的初始化
            Class cls = NSClassFromString(className);
            if(cls)
            {
              [self createTable:[cls new]];
            }
        }
       
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
    
    [self createTable:object];
    NSArray<NSString *> * columnNames = [object saveModelColumns];
    NSMutableString * insertSql = [NSMutableString stringWithFormat:@"insert into %@ (",NSStringFromClass(object.class)];
    NSMutableString * valuesSql = [NSMutableString stringWithString:@"values ("];
    NSMutableArray * valuesArr = [NSMutableArray new];
    for (int i = 0; i < columnNames.count; i++)
    {
        NSString * value = [object valueForKey:columnNames[i]];
        [valuesArr addObject:value==nil?@"NULL":value];
        NSString * suffix = nil;
        if(i==columnNames.count-1)
        {
            suffix = @")";
        }
        else
        {
            suffix = @",";
        }
        [insertSql  appendString:[NSString stringWithFormat:@"%@%@",columnNames[i],suffix]];
        [valuesSql appendString:[NSString stringWithFormat:@"?%@",suffix]];
    }
    [insertSql appendString:valuesSql];
    BOOL sucessed = [_db executeUpdate:insertSql values:valuesArr error:nil];
    if(sucessed)
    {
        NSLog(@"save sucess");
    }else
    {
        NSLog(@"save failed");
    }
}

- (void)createTable:(NSObject<Data_ObjectProtrocal> *)object
{
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
}

- (void)saveObjectList:(NSArray<NSObject<Data_ObjectProtrocal> *> *)objectList
{
    
    [_db open];
    [_db beginTransaction];
    @try
    {
        for (NSObject<Data_ObjectProtrocal> * model in objectList)
        {
            [self saveObject:model];
        }
    }
    @catch (NSException *exception)
    {
        [_db rollback];
    }
    @finally
    {
        [_db commit];
        [self closeDataBase];
    }
}

- (NSObject<Data_ObjectProtrocal> *)queryModel:(Class)cls withIdenftify:(NSString *)identify
{
 
    NSObject<Data_ObjectProtrocal> * model = [cls new];
    NSString * primaryKey = nil;
    if([model respondsToSelector:@selector(primaryKey)])
    {
        primaryKey = [model primaryKey];
    }
    NSString * querySql = [NSString stringWithFormat:@"select * from %@ where %@ = %@",NSStringFromClass(cls),primaryKey,identify];
    FMResultSet * result = [_db executeQuery:querySql];
    
    while (result.next)
    {
        
    }
    
    
    
    
    
    
    
    
    
    
    return nil;
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
    [_db close];
    
}
@end
