//
//  CFNetWorkViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "CFNetWorkViewController.h"
#import <CFNetwork/CFNetwork.h>

@interface CFNetWorkViewController ()

@end

@implementation CFNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequestTest
{
    //使用cfnetworking 进行网络的请求
    
    CFHTTPMessageRef messageRef = CFHTTPMessageCreateRequest(kCFAllocatorDefault,"GET",(__bridge CFURLRef _Nonnull)([NSURL URLWithString:@""]),kCFHTTPVersion2_0);
    CFReadStreamRef readStreamRef = cfread
    CFStreamCreatePairWithSocket
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
