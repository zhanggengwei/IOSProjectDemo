//
//  DataBaseManager.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/23.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol DataBaseManagerProtocal <NSObject>

@optional
- (NSString *)dataBaseName;

- (NSString *)dataBaseUrl;


@end

@interface DataBaseManager : NSObject

+ (instancetype)shareManager;

- (void)openDataBase;

- (void)closeDataBase;



@end
