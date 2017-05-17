//
//  ViewController.m
//  VideoPlayerDemo
//
//  Created by Donald on 17/5/17.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
//实现自定义的视频播放器
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property (nonatomic,strong) AVPlayer * player;
@property (nonatomic,strong) AVPlayerItem * currentItem;
@property (nonatomic,strong) AVAudioSession * session;
@property (nonatomic,strong) AVPlayerLayer * layer;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"近期活动.png"];
    imageView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view addSubview:imageView];
    
    
    
    
    
    
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)deviceOrientationDidChangeNotification:(NSNotification *)noti
{
    NSLog(@"noti == %@",noti);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return YES;
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
