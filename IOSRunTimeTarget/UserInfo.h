//
//  UserInfo.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/22.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data_ObjectProtrocal.h"
#import "Interest.h"
#import "Job.h"


//tables

@interface UserInfo : NSObject<Data_ObjectProtrocal>

@property (nonatomic,copy) NSString * use_name;

@property (nonatomic,copy) NSString * passWord;

@property (nonatomic,strong) NSDate * date;

@property (nonatomic,strong) NSNumber * phone;

@property (nonatomic,assign) BOOL  isFriend;

@property (nonatomic,strong) Interest * list;

@property (nonatomic,strong) Job * job;

@property (nonatomic,assign) NSInteger userId;




@end
