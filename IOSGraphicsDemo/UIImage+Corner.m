//
//  UIImage+Corner.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "UIImage+Corner.h"

@implementation UIImage (Corner)
- (UIImage *)cornerImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0,0,self.size.width,self.size.height);
    
    CGContextTranslateCTM(context,0,self.size.height);
//    CGContextRotateCTM(context, M_PI);
    CGContextScaleCTM(context, 1.0, -1.0);
     CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, self.CGImage);
    [[UIColor blueColor] setFill];
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
