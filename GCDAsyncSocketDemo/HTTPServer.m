//
//  HTTPServer.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/3.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "HTTPServer.h"

@implementation HTTPServer

- (instancetype)init
{
    if(self = [super init])
    {
        _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
    
}

- (void)startServer:(u_int)port
{
    NSError * error = nil;
    [_socket acceptOnInterface:@"192.168.3.134" port:12345 error:&error];
    
    NSLog(@"error ==%@",error);
    NSLog(@"localHost == %@",_socket.localHost);
    
}
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"newSocket ==%@",newSocket);
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
}
@end
