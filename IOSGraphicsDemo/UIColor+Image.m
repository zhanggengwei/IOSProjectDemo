//
//  UIColor+Image.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "UIColor+Image.h"

@implementation UIColor (Image)
- (UIImage *)imageFromColor
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0f);
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,self.CGColor);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (UIImage *)createGradientImage
{
    
//    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
//    CGFloat value[] = {0,0.3};
//   
//    
////    CGColorRef beginColor = CGColorCreate(space, (CGFloat[]){1, 1, 0, 1});
////    CGColorRef middleColor = CGColorCreate(space, (CGFloat[]){1,0, 0, 1.0f});
////    
////    CGColorRef endColor = CGColorCreate(space, (CGFloat[]){0,1, 1, 1.0f});
////    
////    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor,middleColor, endColor}, 3, nil);
//    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:0.3 green:0.0 blue:0.0 alpha:1].CGColor,
//                       (__bridge id)[UIColor colorWithRed:1 green:0.0 blue:1.0 alpha:1].CGColor];
//
//    CGGradientRef gradient = CGGradientCreateWithColors(space,(__bridge CFArrayRef)colors, value);
//    
//    CGContextDrawLinearGradient(context, gradient,CGPointMake(0,0), CGPointMake(0,1),kCGGradientDrawsBeforeStartLocation);
//    //CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
//    
//    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGFloat locations[] = { 0.0, 1.0 };
//    
//    NSArray *colors = @[(__bridge id) [UIColor yellowColor].CGColor, (__bridge id) [UIColor redColor].CGColor];
//    
//    
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
//    
//   
//    
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(0,0), CGPointMake(1,0), 0);
//    
//    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
//    CGGradientRelease(gradient);
//    
//    CGColorSpaceRelease(colorSpace);
//    return image;
    return [self buttonImageFromColors:@[[UIColor redColor],[UIColor yellowColor]]];
    
    
}
- (UIImage*) buttonImageFromColors:(NSArray*)colors{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
   
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, 100);
     
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


@end
