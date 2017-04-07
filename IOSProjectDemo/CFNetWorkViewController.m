//
//  CFNetWorkViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "CFNetWorkViewController.h"
#import <CFNetwork/CFNetwork.h>
#import <sys/socket.h>

static void myCFReadStreamClientCallBack1(CFReadStreamRef stream, CFStreamEventType type, void *clientCallBackInfo)
{
     CFHTTPMessageRef response = (CFHTTPMessageRef)clientCallBackInfo;
    switch (type)
    {
        case kCFStreamEventEndEncountered:{
            CFIndex statusCode = CFHTTPMessageGetResponseStatusCode(response);
          
                CFDataRef responseData = CFHTTPMessageCopyBody(response);
                CFStringRef responseWebPage = CFStringCreateWithBytes(kCFAllocatorDefault, CFDataGetBytePtr(responseData), CFDataGetLength(responseData), kCFStringEncodingUTF8, YES);
                NSLog(@"方式2:\n%@", responseWebPage);
                CFRelease(responseData);
                CFRelease(responseWebPage);
            break;
        }
        case kCFStreamEventHasBytesAvailable:
        {
            CFTypeRef message =
            CFReadStreamCopyProperty(stream, kCFStreamPropertyHTTPResponseHeader);
            NSDictionary* httpHeaders =
            (__bridge NSDictionary *)CFHTTPMessageCopyAllHeaderFields((CFHTTPMessageRef)message);
            NSLog(@"dic:%@",httpHeaders);
            CFRelease(message);
            UInt8 buffer[2048];
            //回调读取数据时，读取的都是body的内容，response header自动被封装处理好的。
            CFIndex length = CFReadStreamRead(stream, buffer, sizeof(buffer));        CFHTTPMessageAppendBytes(response, buffer, length);
            
            
            
            break;
        }
        case kCFStreamEventErrorOccurred:
            CFReadStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
            CFReadStreamClose(stream);
            CFRelease(stream);
            stream = NULL;
            break;
            
        default:
            break;
    }
}

@interface CFNetWorkViewController ()

@end

@implementation CFNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpRequestTest];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequestTest
{
    //使用cfnetworking 进行网络的请求
 
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault,CFSTR("https://www.baidu.com/"), NULL);// note: release
    CFHTTPMessageRef messageRef = CFHTTPMessageCreateRequest(kCFAllocatorDefault,CFSTR("GET"),myURL,kCFHTTPVersion2_0);
    CFReadStreamRef requestReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, messageRef);// note: release
    CFHTTPMessageRef response = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, false);
    CFStreamClientContext clientContext = {0, response, NULL, NULL, NULL};
    CFOptionFlags flags = kCFStreamEventHasBytesAvailable | kCFStreamEventEndEncountered | kCFStreamEventErrorOccurred;
    Boolean result = CFReadStreamSetClient(requestReadStream, flags, myCFReadStreamClientCallBack1, &clientContext);
    
    
    if (result) {
        CFReadStreamScheduleWithRunLoop(requestReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        if (CFReadStreamOpen(requestReadStream)) {
            CFRunLoopRun();
        } else {
            CFReadStreamUnscheduleFromRunLoop(requestReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        }
    }
    CFRelease(messageRef);
    
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
