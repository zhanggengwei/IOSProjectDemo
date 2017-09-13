//
//  ViewController.m
//  TianMaoCATransitaionDemo
//
//  Created by Donald on 17/5/8.
//  Copyright © 2017年 Susu. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIView * topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, WIDTH)];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [UIColor yellowColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, WIDTH + 100, 50, 50);
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)action:(id)sender {
}

- (void)buttonAction
{
    [UIView animateWithDuration:0.4 animations:^{
         [self.topView.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
           [self.topView.layer setTransform:[self secondTransfrom]];
            
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}
- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
//    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
    
}

- (CATransform3D)secondTransfrom
{
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, self.topView.frame.size.height * (-0.08), 0);
    t2 = CATransform3DScale(t2, 0.85, 0.75, 1);
    return t2;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
