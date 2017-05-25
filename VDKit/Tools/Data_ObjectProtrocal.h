//
//  SaveObject.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Data_ObjectProtrocal <NSObject>

- (NSArray *)saveModelColumns;

- (NSString *)primaryKey;



@end
