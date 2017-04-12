//
//  NSData+DDData.h
//  IOSProjectDemo
//
//  Created by Donald on 17/4/12.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DDData)

- (NSData *)md5Digest;

- (NSData *)sha1Digest;

- (NSString *)hexStringValue;

- (NSString *)base64Encoded;

- (NSData *)base64Decoded;


@end
