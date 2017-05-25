//
//  UserInfo.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/22.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data_ObjectProtrocal.h"
@interface UserInfo : NSObject<Data_ObjectProtrocal>

@property (nonatomic,strong) NSString * use_name;

@property (nonatomic,strong) NSString * passWord;

@property (nonatomic,strong) NSString * phone;



@end
