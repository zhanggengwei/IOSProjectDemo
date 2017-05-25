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
#import <string.h>

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
        self.delegate = self;
        
        [self dataBaseInit];
        [self checkTables];
        
    }
    return self;
}

- (NSArray *) dataBaseTableClassName
{
    return @[@"UserInfo",@"Interest"];
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
              [self dataBaseTableCheck:[cls new]];
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
}

- (void)openDataBase
{
    if(_open==NO)
    {
      [_db open];
      _open = YES;
    }
  
    
}

- (void)saveObject:(NSObject<Data_ObjectProtrocal> *)object
{
    
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

- (NSArray<NSString *> *)getTableColumnNamesWithClass:(Class)cls
{
    [self openDataBase];
    FMResultSet * result = [_db executeQuery:[NSString stringWithFormat: @"select * from %@",NSStringFromClass(cls)]];
                            
    NSMutableArray * array = [NSMutableArray new];
    int i = 0;
    while (i<result.columnCount)
    {
        [array addObject:[result columnNameForIndex:i++]];
    }
    return array;
}


- (void)createTable:(NSObject<Data_ObjectProtrocal> *)object
{
    [self openDataBase];
   

    if([object respondsToSelector:@selector(saveModelColumns)])
    {
        
        NSArray<NSString *> * columnNames = [object saveModelColumns];
        
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




- (void)dataBaseTableCheck:(NSObject<Data_ObjectProtrocal> *)object
{

    [self openDataBase];
    BOOL tableExists = [_db tableExists:NSStringFromClass(object.class)];
    //表存在
    if(tableExists)
    {
         NSArray<NSString *> * columnNames = [object saveModelColumns];
         NSArray<NSString *> * searchColumnNames = [self getTableColumnNamesWithClass:object.class];
        if([columnNames isEqualToArray:searchColumnNames])
        {
            return;
        }
        else
        {
            NSMutableArray * array = [NSMutableArray arrayWithArray:columnNames];
            [array removeObjectsInArray:searchColumnNames];
            [_db beginTransaction];
            
            for (NSString * names in array)
            {
                NSString * alterSql = [NSString stringWithFormat:@"alter table %@ add column %@ varchar(%d)",object.class,names,char_Length];
                [_db executeUpdate:alterSql];
            }
            [_db commit];
            
            
        }
        
    }else
    {
        [self createTable:object];
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
    if(_open)
    {
        [_db close];
        _open = false;
    }
}
@end
