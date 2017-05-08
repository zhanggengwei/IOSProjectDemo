//
//  TriangleView.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/8.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL,self.frame.size.width * 0.5,0);
    CGPathAddLineToPoint(path, NULL, self.frame.size.width, self.frame.size.height);
   
    
    CGPathMoveToPoint(path, NULL,self.frame.size.width,self.frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, self.frame.size.height);
    
    CGPathMoveToPoint(path, NULL, 0, self.frame.size.height);
    CGPathAddLineToPoint(path, NULL, self.frame.size.width * 0.5, 0);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    [[UIColor yellowColor]setFill];
    CGContextFillPath(ctx);
}

@end
