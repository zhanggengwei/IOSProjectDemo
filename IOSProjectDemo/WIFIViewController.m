//
//  WIFIViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/11.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "WIFIViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
@interface WIFIViewController ()

@end

@implementation WIFIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"wifiName ==%@",[WIFIViewController getWifiName]);
    [self.class currentNetworkType];
    
    __strong NSObject * yourString =  [NSObject new];

    
    __weak NSObject * myString = yourString;
    
    
    
    __unsafe_unretained NSObject *theirString = myString;
    
    yourString = nil;
    
    
    
    
    NSLog(@"yourString:%p --- :%@",yourString,yourString);
    
    NSLog(@"myString:%p --- :%@",myString,myString);
    
    NSLog(@"theirString:%p --- :%@",theirString,theirString);
    // Do any additional setup after loading the view.
}
+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}
+(void)currentNetworkType{
    
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];//可以获得相应的属性 电池，时间，运营商，
    for (id obj in infoArray)
    {
        NSLog(@"obj == %@",obj);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
