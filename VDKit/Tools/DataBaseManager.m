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
#import "Object_Info.h"

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
    return @[@"UserInfo",@"Interest",@"Job"];
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
        _open = [_db open];
    }
    
    
}

- (void)saveObject:(NSObject<Data_ObjectProtrocal> *)object
{
    
    if([object respondsToSelector:@selector(saveInnerModels)])
    {
        NSDictionary * dict = [object saveInnerModels];
        
        for (NSString * keys in dict.allKeys)
        {
            id obj =[object valueForKey:dict[keys]];
            if(!obj)
            {
                continue;
            }
            if([obj isKindOfClass:[NSArray class]])
            {
                [self saveObjectList:obj];
                
            }else
            {
                [self saveObject:obj];
            }
            
        }
        
    }
    [self openDataBase];
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
    
    [self closeDataBase];
    
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
            Ivar var = class_getInstanceVariable(object.class,"_list");
            NSLog(@"var ==%s",ivar_getTypeEncoding(var));
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
    [self closeDataBase];
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
            [self closeDataBase];
            
            
        }
        
    }else
    {
        [self createTable:object];
    }
}

- (void)saveObjectList:(NSArray<NSObject<Data_ObjectProtrocal> *> *)objectList
{
    
    [self openDataBase];
    [_db beginTransaction];
    @try
    {
        for (NSObject<Data_ObjectProtrocal> * model in objectList)
        {
            [self saveObject:model];
        }
        [_db commit];
    }
    @catch (NSException *exception)
    {
        [_db rollback];
    }
    @finally
    {
        
        [self closeDataBase];
    }
}
//根据主键查询
- (NSObject<Data_ObjectProtrocal> *)queryModel:(Class)cls withIdenftify:(NSString *)identify
{
    
    NSObject<Data_ObjectProtrocal> * model = [cls new];
    NSString * primaryKey = nil;
    if([model respondsToSelector:@selector(primaryKey)])
    {
        primaryKey = [model primaryKey];
    }else
    {
        NSLog(@"");
        return nil;
    }
    NSString * querySql = [NSString stringWithFormat:@"select * from %@ where %@ = %@",NSStringFromClass(cls),primaryKey,identify];
    FMResultSet * result = [_db executeQuery:querySql];
    while (result.next)
    {
        
    }
    return nil;
}
/*
 NSString
 NSNumber
 Date
 long
 long long
 UInt8
 UInt16
 UInt32
 UInt64
 int
 BOOL
 double
 float
 int8_t
 NSInteger
 
 */


- (NSArray<NSObject<Data_ObjectProtrocal > *>* )queryList:(Class)cls
{
    NSString * querySql = [NSString stringWithFormat:@"select * from %@",NSStringFromClass(cls)];
    NSArray<NSString *> *columns = [[cls new]saveModelColumns];
    FMResultSet *set = [_db executeQuery:querySql];
    Object_Info * info = [[Object_Info alloc]initWithClass:cls];
    NSMutableArray * array = [NSMutableArray new];
    while (set.next)
    {
        NSObject<Data_ObjectProtrocal> * obj = [cls new];
        for (NSString * name in columns)
        {
            Object_Item * item = [info.dict objectForKey:name];
            
            if([item.type isEqualToString:@"date"])
            {
                [obj setValue:[set dateForColumn:name] forKey:name];
            }
            else
            {
                 NSString * value =  [set stringForColumn:name];
                if([item.type isEqualToString:@"numer"])
                {
                    [obj setValue:[NSNumber numberWithInteger:value.integerValue] forKey:name];
                    
                }else{
                 [obj setValue:value forKey:name];
                }
            }
        }
        [array addObject:obj];
    }
    return array;
}

- (void)deleteTables
{
    NSArray * delTables = [self dataBaseTableClassName];
    [self openDataBase];
    [_db beginTransaction];
    @try
    {
        
        for (NSString * name in delTables)
        {
            NSString * delSql = [NSString stringWithFormat:@"delete FROM %@",name];
            [_db executeUpdate:delSql];
            
        }
        [_db commit];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        [self closeDataBase];
    }
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
        //_open = [_db close];
    }
}
@end
