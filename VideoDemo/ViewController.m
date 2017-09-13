//
//  ViewController.m
//  VideoDemo
//
//  Created by VD on 2017/9/12.
//  Copyright © 2017年 Susu. All rights reserved.
//
// 视频录制

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "VDImagePickeViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(id)sender
{
    VDImagePickeViewController * controller = [[VDImagePickeViewController alloc]init];
    [self presentViewController:controller animated:YES completion:nil];
    
}


@end
