//
//  ViewController.m
//  CATransFromDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"近期活动"];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CATransform3D transform =CATransform3DIdentity;//获取一个标准默认的CATransform3D仿射变换矩阵
        
        transform.m34=4.5/-2000;//透视效果
        
        transform=CATransform3DRotate(transform,M_PI*2-M_PI * 0.1,0,1,0);//获取旋转angle角度后的rotation矩阵。
        imageView.layer.transform = transform;
    } completion:^(BOOL finished) {
        
    }];
    
    
 
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
