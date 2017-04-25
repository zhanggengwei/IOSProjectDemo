//
//  NSTextAttachment+ImageURL.h
//  IOSProjectDemo
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^downImageblock)(UIImage * image,NSError * error);


@interface NSTextAttachment (ImageURL)

@property (nonatomic,strong) NSString * ImageURL;

- (void)loadImageURl:(NSString *)imageUrl withBlock:(downImageblock)block;


@end
