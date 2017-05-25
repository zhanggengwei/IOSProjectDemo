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

@property (nonatomic,strong) NSString * use_name;

@property (nonatomic,strong) NSString * passWord;

@property (nonatomic,strong) NSString * phone;

@property (nonatomic,strong) NSString * identify;

@property (nonatomic,strong) NSString * userId;


@property (nonatomic,strong) Interest * list;

@property (nonatomic,strong) Job * job;




//







@end
