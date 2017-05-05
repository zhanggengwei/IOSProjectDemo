//
//  ViewController.m
//  IOSGraphicsDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Image.h"
#import "UIImage+Corner.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    UIImage * image = [UIColor yellowColor].createGradientImage;
    imageView.image = [UIImage imageNamed:@"二维码.png"].cornerImage;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
