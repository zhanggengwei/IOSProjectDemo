//
//  ViewController.m
//  IOSVideoDemo
//
//  Created by VD on 2017/7/24.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "ZGRecoardVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "RCRecoarder.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImagePickerController * controller;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)action:(id)sender
{
//    self.controller = [[UIImagePickerController alloc]init];
//    self.controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//    _controller.mediaTypes = @[(NSString *)kUTTypeMovie];
//    self.controller.delegate = self;
   
//    NSArray *availableMediaTypes = [UIImagePickerController
//                                    availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    self.controller.mediaTypes = availableMediaTypes;
    
//    [self presentViewController:self.controller animated:YES completion:nil];
    NSString * path = [NSHomeDirectory() stringByAppendingString:@"/1.caf"];
    RCRecoarder * recoarder = [[RCRecoarder alloc]initWithRecoardFilePath:path];
    [recoarder startRecoard:^(NSString *filePath) {
        
    }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}
@end
