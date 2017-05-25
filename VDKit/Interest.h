//
//  Interest.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data_ObjectProtrocal.h"
@interface Interest : NSObject<Data_ObjectProtrocal>

@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) NSInteger indexId;
@property (nonatomic,assign) BOOL selected;

@end
