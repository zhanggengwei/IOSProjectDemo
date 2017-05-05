//
//  UIImage+Corner.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "UIImage+Corner.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation UIImage (Corner)
- (UIImage *)cornerImage
{
//    UIGraphicsBeginImageContext(self.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect rect = CGRectMake(0,0,self.size.width,self.size.height);
//    
//    CGContextTranslateCTM(context,0,self.size.height);
////    CGContextRotateCTM(context, M_PI);
//    CGContextScaleCTM(context, 1.0, -1.0);
//     CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGContextClipToMask(context, rect, self.CGImage);
//    [[UIColor blueColor] setFill];
//    CGContextFillRect(context, rect);
//    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
    
    return [self imageWithTintColor:[UIColor yellowColor]];
    
}
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    
    [tintColor setFill];
  
    UIRectFill(bounds);

    [self drawInRect:bounds blendMode:kCGBlendModeNormal alpha:1.0f];
    
    //Draw the tinted image in context
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
+(UIImage *)addImageLogo:(UIImage *)logo text:(UIImage *)img
{
    //get image width and height
    int w = WIDTH*2;//img.size.width;
    int h = HEIGHT*2;//img.size.height;
    int logoWidth = logo.size.width*4;
    int logoHeight = logo.size.height*4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(0, h-logoHeight, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    // CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}
@end
