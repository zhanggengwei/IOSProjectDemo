//
//  RCRecoarder.h
//  IOSProjectDemo
//
//  Created by VD on 2017/7/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^sucessBlock)(NSString * filePath);
@interface RCRecoarder : NSObject

- (instancetype)initWithRecoardFilePath:(NSString *)path;
- (void)startRecoard:(sucessBlock)block;
- (void)stopRecoard;
- (void)cancelRecoard;

@end
