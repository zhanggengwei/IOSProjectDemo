//
//  RCAudioPlayer.h
//  IOSProjectDemo
//
//  Created by VD on 2017/7/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAudioPlayer : NSObject
+ (instancetype)shareManager;
- (void)startPlayWithUrl:(NSString *)url;
- (void)stopPaly;
@end
