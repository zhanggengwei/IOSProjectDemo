//
//  HTTPServer.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/3.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
@interface HTTPServer : NSObject<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * _socket;
    
}
- (void)startServer:(u_int)port;



@end
