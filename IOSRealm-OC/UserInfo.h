//
//  UserInfo.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/31.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface UserInfo : RLMObject

@property (nonatomic,strong)NSString * name;

@property (nonatomic,strong)NSString * passWord;

@property (nonatomic,strong)NSString * phone;


@end
