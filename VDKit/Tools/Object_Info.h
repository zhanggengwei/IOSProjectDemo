//
//  Object_Info.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/26.
//  Copyright © 2017年 Susu. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@class Object_Item;


typedef NS_ENUM(NSUInteger,VDTypeEncoding)
{
    VDTypeEncodingU_Int8,//C
    VDTypeEncodingU_Int16,//S
    VDTypeEncodingU_Int32,//I
    VDTypeEncodingU_Int64,//Q
    VDTypeEncodingInt,//i
    
    VDTypeEncodingBOOL,//B
    
    VDTypeEncodingInteger,//q
    VDTypeEncodingUInteger,//Q
    
    VDTypeEncodingFloat,//f
    VDTypeEncodingDouble,//d
    VDTypeEncodingLongDouble//D
};


@interface Object_Info : NSObject

@property (nonatomic,strong,readonly) NSArray<Object_Item *> * list;

- (instancetype)initWithClass:(Class)cls;


@end


@interface Object_Item : NSObject

@property (nonatomic,assign,readonly) Ivar var;
@property (nonatomic,assign,readonly) NSString * type;
@property (nonatomic,strong,readonly) NSString * name;

- (instancetype)initWithVar:(Ivar)var;


@end
