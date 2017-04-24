//
//  ViewController.m
//  WebViewDemo
//
//  Created by VD on 2017/4/24.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSString * htmlPath = [[NSBundle mainBundle]pathForResource:@"index.html" ofType:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]];
    [self.webView loadRequest:request];
    
                    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTML开始加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlstr = request.URL.absoluteString;
    if([urlstr rangeOfString:@"ios://"].location !=NSNotFound){
        NSArray *array = [urlstr componentsSeparatedByString:@"//"];
        NSLog(@"funName:%@",array[1]);
        NSString *selectorName = array[1];//方法名
        //            NSString *selectorParame = @"aaa";    //方法参数
        SEL selector = NSSelectorFromString(selectorName);
        if([self respondsToSelector:selector]){
            
          
            ((void (*) (id, SEL)) (void *)objc_msgSend)(self, selector);
            
            
        }
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}



-(void)openCamera{
    NSLog(@"打开相机");
}
-(void)openPhoto{
    NSLog(@"打开相册");
}
-(void)DetectionNet{
    NSLog(@"检测网络");
}
-(void)reloadHtml{
    NSLog(@"刷新网页");
}
-(void)openAddressBook{
    NSLog(@"获取通讯录");
}
-(void)Log{
    NSLog(@"Hello,Mr.ZhuJX!");
}
@end
