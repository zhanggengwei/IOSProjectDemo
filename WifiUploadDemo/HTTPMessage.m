//
//  HTTPMessage.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/11.
//  Copyright © 2017年 Susu. All rights reserved.
//
#import "HTTPMessage.h"
#import <CFNetwork/CFNetwork.h>

//#if ! __has_feature(objc_arc)
//#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
//#endif

@interface HTTPMessage ()
{
    CFHTTPMessageRef _message;
}
@end

@implementation HTTPMessage



- (id)initEmptyRequest
{
    if ((self = [super init]))
    {
        _message = CFHTTPMessageCreateEmpty(NULL, YES);
        //创建一个空的请求消息
    }
    return self;
}
- (id)initRequestWithMethod:(NSString *)method URL:(NSURL *)url version:(NSString *)version
{
    if(self = [super init])
    {
        _message = CFHTTPMessageCreateRequest(kCFAllocatorDefault,(__bridge CFStringRef _Nonnull)method,(__bridge CFURLRef _Nonnull)url,(__bridge CFStringRef _Nonnull)(version));
    }
    
    return self;
    
}
- (id)initResponseWithStatusCode:(NSInteger)code description:(NSString *)description version:(NSString *)version
{
    if(self = [super init])
    {
        _message = CFHTTPMessageCreateResponse(kCFAllocatorDefault, (CFIndex)code, (__bridge CFStringRef _Nullable)(description), (__bridge CFStringRef _Nonnull)(version));
        
    }
    return self;
    
}
- (BOOL)appendData:(NSData *)data
{
    return CFHTTPMessageAppendBytes(_message, data.bytes, data.length);
    
}
- (BOOL)isHeaderComplete
{
    return CFHTTPMessageIsHeaderComplete(_message);
}

- (NSString *)version
{
    return (__bridge NSString *)(CFHTTPMessageCopyVersion(_message));
    
}
- (NSString *)method
{
    return (__bridge NSString *)(CFHTTPMessageCopyRequestMethod(_message));
}
- (NSURL *)url
{
    return  (__bridge NSURL *)(CFHTTPMessageCopyRequestURL(_message));
}
- (NSInteger)statusCode
{
    return (NSInteger)CFHTTPMessageGetResponseStatusCode(_message);
}
- (NSDictionary *)allHeaderFields
{
    return  (__bridge NSDictionary *)(CFHTTPMessageCopyAllHeaderFields(_message));
}
- (NSString *)headerField:(NSString *)headerField
{
    return (__bridge NSString *)(CFHTTPMessageCopyHeaderFieldValue(_message, (__bridge CFStringRef _Nonnull)(headerField)));
}
- (void)setHeaderField:(NSString *)headerField value:(NSString *)headerFieldValue
{
    CFHTTPMessageSetHeaderFieldValue(_message, (__bridge CFStringRef _Nonnull)(headerField), (__bridge CFStringRef _Nullable)(headerFieldValue));
}

- (NSData *)messageData
{
   return  (__bridge NSData *)(CFHTTPMessageCopySerializedMessage(_message));
}

- (NSData *)body
{
    return (__bridge NSData *)(CFHTTPMessageCopyBody(_message));
}

- (void)setBody:(NSData *)body
{
    CFHTTPMessageSetBody(_message, body.bytes);
}

- (void)dealloc
{
    if(_message!=NULL)
    {
        CFRelease(_message);
        _message = NULL;
    }
}

@end
