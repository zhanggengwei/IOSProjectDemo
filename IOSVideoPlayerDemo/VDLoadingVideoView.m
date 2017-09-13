//
//  VDLoadingVideoView.m
//  IOSProjectDemo
//
//  Created by VD on 2017/9/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "VDLoadingVideoView.h"

static NSString *kMMRingStrokeAnimationKey = @"mmmaterialdesignspinner.stroke";
static NSString *kMMRingRotationAnimationKey = @"mmmaterialdesignspinner.rotation";
@interface VDLoadingVideoView ()

@property (nonatomic,strong) CAShapeLayer * progressLayer;
@property (nonatomic, readwrite) BOOL isAnimating;
@end

@implementation VDLoadingVideoView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [self updatePath];
}


- (void)initialize {
    self.duration = 1.5f;
    self.lineWidth = 1.5;
    self.tintColor = [UIColor whiteColor];
    _timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addSublayer:self.progressLayer];
    // See comment in resetAnimations on why this notification is used.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAnimations) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (CAShapeLayer *)progressLayer
{
    if(_progressLayer==nil)
    {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = self.tintColor.CGColor;
    }
    return _progressLayer;
}

- (void)updatePath
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
    CGFloat startAngle = (CGFloat)(0);
    CGFloat endAngle = (CGFloat)(2*M_PI);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = path.CGPath;
    
    self.progressLayer.strokeStart = 0.f;
    self.progressLayer.strokeEnd = 0.f;
}

- (void)resetAnimations
{
    if (self.isAnimating) {
        [self stopAnimating];
        [self startAnimating];
    }
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    self.progressLayer.strokeColor = self.tintColor.CGColor;
}

- (void)setAnimating:(BOOL)animate
{
    (animate ? [self startAnimating] : [self stopAnimating]);
}

- (void)startAnimating
{
    if (self.isAnimating)
        return;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = self.duration / 0.375f;
    animation.fromValue = @(0.f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    animation.removedOnCompletion = NO;
    [self.progressLayer addAnimation:animation forKey:kMMRingRotationAnimationKey];
    
    CABasicAnimation *headAnimation = [CABasicAnimation animation];
    headAnimation.keyPath = @"strokeStart";
    headAnimation.duration = self.duration / 1.5f;
    headAnimation.fromValue = @(0.f);
    headAnimation.toValue = @(0.25f);
    headAnimation.timingFunction = self.timingFunction;
    
    CABasicAnimation *tailAnimation = [CABasicAnimation animation];
    tailAnimation.keyPath = @"strokeEnd";
    tailAnimation.duration = self.duration / 1.5f;
    tailAnimation.fromValue = @(0.f);
    tailAnimation.toValue = @(1.f);
    tailAnimation.timingFunction = self.timingFunction;
    
    
    CABasicAnimation *endHeadAnimation = [CABasicAnimation animation];
    endHeadAnimation.keyPath = @"strokeStart";
    endHeadAnimation.beginTime = self.duration / 1.5f;
    endHeadAnimation.duration = self.duration / 3.0f;
    endHeadAnimation.fromValue = @(0.25f);
    endHeadAnimation.toValue = @(1.f);
    endHeadAnimation.timingFunction = self.timingFunction;
    
    CABasicAnimation *endTailAnimation = [CABasicAnimation animation];
    endTailAnimation.keyPath = @"strokeEnd";
    endTailAnimation.beginTime = self.duration / 1.5f;
    endTailAnimation.duration = self.duration / 3.0f;
    endTailAnimation.fromValue = @(1.f);
    endTailAnimation.toValue = @(1.f);
    endTailAnimation.timingFunction = self.timingFunction;
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    [animations setDuration:self.duration];
    [animations setAnimations:@[headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]];
    animations.repeatCount = INFINITY;
    animations.removedOnCompletion = NO;
    [self.progressLayer addAnimation:animations forKey:kMMRingStrokeAnimationKey];
    
    
    self.isAnimating = true;
    
    if (self.hidesWhenStopped) {
        self.hidden = NO;
    }
}

- (void)stopAnimating
{
    if (!self.isAnimating)
        return;
    
    [self.progressLayer removeAnimationForKey:kMMRingRotationAnimationKey];
    [self.progressLayer removeAnimationForKey:kMMRingStrokeAnimationKey];
    self.isAnimating = false;
    
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
}


- (BOOL)isAnimating {
    return _isAnimating;
}

- (CGFloat)lineWidth {
    return self.progressLayer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.progressLayer.lineWidth = lineWidth;
    [self updatePath];
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped {
    _hidesWhenStopped = hidesWhenStopped;
    self.hidden = !self.isAnimating && hidesWhenStopped;
}

@end
