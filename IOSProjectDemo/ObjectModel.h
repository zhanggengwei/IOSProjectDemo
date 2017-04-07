//
//  ObjectModel.h
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectModel : NSObject

@property (nonatomic,strong) NSString * name;

@property (nonatomic,strong) NSString * passWord;

- (void)printModelAddress;


@end
