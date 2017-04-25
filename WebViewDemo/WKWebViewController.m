//
//  WKWebViewController.m
//  IOSProjectDemo
//
//  Created by VD on 2017/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView * webView;

@end

@implementation WKWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * htmlPath = [[NSBundle mainBundle]pathForResource:@"index.html" ofType:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]];
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
      NSLog(@"%s",__FUNCTION__);
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
      NSLog(@"%s",__FUNCTION__);
    return nil;
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
      NSLog(@"%s",__FUNCTION__);
}
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo
{
      NSLog(@"%s",__FUNCTION__);
    return YES;
}

- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions
{
      NSLog(@"%s",__FUNCTION__);
    return nil;
    
}
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController
{
      NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
      decisionHandler(WKNavigationActionPolicyAllow);
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
      decisionHandler(WKNavigationResponsePolicyAllow);
      NSLog(@"%s",__FUNCTION__);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
      NSLog(@"%s",__FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
      NSLog(@"%s",__FUNCTION__);
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
      NSLog(@"%s",__FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
      NSLog(@"%s",__FUNCTION__);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    NSLog(@"%s",__FUNCTION__);
}

@end
