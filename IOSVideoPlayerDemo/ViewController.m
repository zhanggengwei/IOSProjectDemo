//
//  ViewController.m
//  IOSVideoPlayerDemo
//
//  Created by VD on 2017/9/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "MoviePlayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//自定义一个视频的播放器x
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
//    VDLoadingVideoView * loadingView = [[VDLoadingVideoView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:loadingView];
//    [loadingView setAnimating:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action:(id)sender
{
    MoviePlayerViewController * controller = [MoviePlayerViewController new];
    controller.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4"];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
