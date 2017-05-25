//
//  DataBaseManager.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/23.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data_ObjectProtrocal.h"


@protocol DataBaseManagerProtocal <NSObject>

@optional
- (NSString *)dataBaseName;

- (NSString *)dataBaseUrl;

- (NSArray *) dataBaseTableClassName;


@end

@interface DataBaseManager : NSObject<DataBaseManagerProtocal>

@property (nonatomic,weak) id<DataBaseManagerProtocal>delegate;

+ (instancetype)shareManager;

- (void)openDataBase;

- (void)closeDataBase;

- (void)saveObject:(NSObject<Data_ObjectProtrocal> *)object;

- (void)updateObject:(NSObject<Data_ObjectProtrocal> *)object;

- (void)deleteObject:(NSInteger)identify;

- (NSObject<Data_ObjectProtrocal> *)queryModel:(Class)cls withIdenftify:(NSString *)identify;







@end
