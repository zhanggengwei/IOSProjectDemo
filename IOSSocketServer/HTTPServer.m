//
//  HTTPServer.m
//  IOSProjectDemo
//
//  Created by VD on 2017/4/17.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "HTTPServer.h"
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <ifaddrs.h>

@interface HTTPServer ()

@property (nonatomic,assign) BOOL severStart;
@property (nonatomic,strong) dispatch_queue_t connectionQueue;
@property (nonatomic,assign) int serverDecriper;

@end

@implementation HTTPServer

- (void)startPort:(NSString *)port
{
    
    if(self.severStart)
    {
        NSLog(@"- (void)stopPort:(NSString *)port 关闭");
        return;
    }
    self.severStart = YES;
    self.serverDecriper = socket(AF_INET,SOCK_STREAM,0);
    if(self.serverDecriper == -1)
    {
        NSLog(@"创建socket 失败");
        return;
    }
    
    struct sockaddr_in serverSocket;
    memset(&serverSocket, 0, sizeof(serverSocket));
    
    serverSocket.sin_family = AF_INET;
    serverSocket.sin_port = htons(9090);
    //serverSocket.sin_addr.s_addr = inet_addr("192.168.1.5");
    int flag = bind(self.serverDecriper,(const struct sockaddr *)&serverSocket, sizeof(serverSocket));
    
    if(flag == -1)
    {
        NSLog(@"ip绑定失败");
        return;
    }
   
    NSInteger isListen = listen(self.serverDecriper, 10);
        
    if(isListen==-1)
    {
        NSLog(@"端口监听失败");
        return;
    }
    
    while (1) {
        // clientSocket
        struct sockaddr_in clientAddress;
        bzero(&clientAddress, sizeof(clientAddress));
        socklen_t len = sizeof(clientAddress);
        
        int clientFileDescriper = accept(self.serverDecriper, (struct sockaddr *)&clientAddress, &len);
         if (clientFileDescriper) {
        struct sockaddr_in sa;
        NSInteger len = sizeof(sa);
        
        if(!getpeername(clientFileDescriper, (struct sockaddr *)&sa, &len))
        {
            printf( "对方IP：%s ", inet_ntoa(sa.sin_addr));
            printf( "对方PORT：%d ", ntohs(sa.sin_port));
        }
        char buff[1024];
        sprintf(buff, "HTTP/1.1 404 \r\nServer: my lhttp server\r\nContent-Type: text/html\r\nContent-Length: %d\r\n\r\n%s", (int)strlen("<html><h1>Not Found</h1></html>"), "<html><h1>Not Found</h1></html>");
        send(clientFileDescriper, buff, strlen(buff), 0);
        send(clientFileDescriper,buff,sizeof(buff), 0);
        
        NSLog(@"接收成功 %d，client IP：%zd", clientFileDescriper, clientAddress);
        //close(self.serverDecriper);
            
         }
    }
    
    
    
    
    
    
}


- (void)stopPort:(NSString *)port
{
    
}

void getCharBuffer(char * buff,int * len)
{
    
}


@end
