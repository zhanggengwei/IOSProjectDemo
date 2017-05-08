//
//  TriangleView.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/8.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "TriangleView.h"
#define PI 3.14159265358979323846
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
    
    [[UIColor whiteColor]setFill];
    UIRectFill(rect);
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor]setStroke];
    [[UIColor yellowColor]setFill];
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(rect.size.width * 0.5,0);//坐标1
    sPoints[1] =CGPointMake(0, rect.size.height);//坐标2
    sPoints[2] =CGPointMake(rect.size.width, rect.size.height);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
 
}

@end
