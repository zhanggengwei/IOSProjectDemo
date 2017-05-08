//
//  ViewController.m
//  IOSLoadingDemo
//
//  Created by Donald on 17/5/8.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "TriangleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.bounds = CGRectMake(0, 0, 120, 120);
    layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(60, 60) radius:65 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor yellowColor].CGColor;
    
    layer.position = CGPointMake(130, 130);
    [self.view.layer addSublayer:layer];
    
    TriangleView * view = [[TriangleView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:view];
    
    CABasicAnimation * animation = [CABasicAnimation new];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 3;
    animation.repeatCount = 10000;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@""];
    
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
