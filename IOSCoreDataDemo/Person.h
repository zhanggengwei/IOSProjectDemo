//
//  Person.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/3.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Person : NSManagedObject

@property (nonatomic,assign) NSInteger identify;
@property (nonatomic,strong) NSString * password;
@property (nonatomic,strong) NSString * userName;

@end
