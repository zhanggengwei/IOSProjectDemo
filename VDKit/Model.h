//
//  Model.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/26.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Model : NSObject

@property (nonatomic,assign) UInt8 u_test8;

@property (nonatomic,assign) UInt16 u_test16;

@property (nonatomic,assign) UInt32 u_test32;

@property (nonatomic,assign) UInt64 u_test64;

@property (nonatomic,assign) NSUInteger u_integer;
@property (nonatomic,assign) NSInteger integer;

@property (nonatomic,assign) int int1;

@property (nonatomic,assign) int8_t int_8;
@property (nonatomic,assign) float float1;

@property (nonatomic,assign) CGFloat float12;

@property (nonatomic,assign) BOOL isFriend;



@property (nonatomic,assign) double double1;

@property (nonatomic,assign) long double ldouble2;
@property (nonatomic,assign) unsigned long  test;



@property (nonatomic,assign) SEL selector;











@end
