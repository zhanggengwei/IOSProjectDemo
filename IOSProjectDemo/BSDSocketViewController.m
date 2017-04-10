//
//  BSDSocketViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "BSDSocketViewController.h"
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <ifaddrs.h>


@interface BSDSocketViewController ()

@end

@implementation BSDSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self BSDSocketClientTCPServices];
    
//    getpeername
   // [self BSDSocketSevertTCPServices];
    // Do any additional setup after loading the view.
}

- (void)TCPSocketStart
{
    
    int socketFileDescriper = socket(AF_INET,SOCK_STREAM, 0);
    if(socketFileDescriper==-1)
    {
        NSLog(@"网络创建失败");
        return;
    }
    NSString * hostName = @"127.0.0.1";
    struct hostent * remoteHostEnt = gethostbyname([hostName UTF8String]);
    if(remoteHostEnt==NULL)
    {
        NSLog(@"");
        //关闭
        close(socketFileDescriper);
        return;
    }
}

- (void)BSDSocketClientTCPServices
{
    int socketFileDescriper = socket(AF_INET,SOCK_STREAM, 0);
    
    
    
    if(socketFileDescriper==-1)
    {
        NSLog(@"socket创建失败");
        return;
    }
    struct sockaddr_in sa;
    int len = sizeof(sa);
 
    struct sockaddr_in serverAddress;
    bzero(&serverAddress, sizeof(serverAddress));
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(9191);
    serverAddress.sin_addr.s_addr = inet_addr("192.168.88.100");
    
    int isConnected = connect(socketFileDescriper, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
    if(isConnected==0)
    {
        NSLog(@"connected 链接 成功");
    }else
    {
        NSLog(@"connected 链接 失败");
    }
    
    
    //getpeername
    /*
      获取对方的IP地址
     
     struct sockaddr_in sa;
     int len = sizeof(sa);
     if(!getpeername(sockfd, (struct sockaddr *)&sa, &len))
     {
     printf( "对方IP：%s ", inet_ntoa(sa.sin_addr));
     printf( "对方PORT：%d ", ntohs(sa.sin_port));
     }
     */
//    功能：置字节字符串s的前n个字节为零。
}

- (void)BSDSocketSevertTCPServices
{
    int socketFileDescriper = socket(AF_INET,SOCK_STREAM, 0);
    if(socketFileDescriper==-1)
    {
        NSLog(@"socket创建失败");
        return;
    }
    struct sockaddr_in serverAddress;
    bzero(&serverAddress, sizeof(serverAddress));
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(9090);
    serverAddress.sin_addr.s_addr = inet_addr("192.168.3.134");
    int isBind = bind(socketFileDescriper, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
    
    if (isBind) {
        NSLog(@"绑定失败 %d", isBind);
        return;
    } else {
        NSLog(@"绑定成功");
    }
    int isListen = listen(socketFileDescriper, 10);
    
    if (isListen) {
        NSLog(@"监听失败 %d", isListen);
        return;
    } else {
        NSLog(@"监听成功");
    }
    
    // clientSocket
    struct sockaddr_in clientAddress;
    bzero(&clientAddress, sizeof(clientAddress));
    socklen_t len = sizeof(clientAddress);
    
    int clientFileDescriper = accept(socketFileDescriper, (struct sockaddr *)&clientAddress, &len);
    
    if (clientFileDescriper) {
    
        struct sockaddr_in sa;
        int len = sizeof(sa);
        if(!getpeername(clientFileDescriper, (struct sockaddr *)&sa, &len))
        {
            printf( "对方IP：%s ", inet_ntoa(sa.sin_addr));
            printf( "对方PORT：%d ", ntohs(sa.sin_port));
        }
        
     
        NSLog(@"接收成功 %d，client IP：%zd", clientFileDescriper, clientAddress);
    } else {
        NSLog(@"接收失败");
    }
    
    
}

+ (void)getLocalAddress
{
    struct ifaddrs * address = NULL;
    struct ifaddrs * tempAddress = NULL;
    int flag = getifaddrs(&address);
    if(flag==-1)
    {
        NSLog(@"print _error %s",__func__);
        return;
    }
    tempAddress = address;
    
    while (tempAddress)
    {
        if(tempAddress->ifa_addr->sa_family == AF_INET)
        {
            
            if ([[NSString stringWithUTF8String:tempAddress->ifa_name] isEqualToString:@"en0"])
            {
                
            NSString * address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)tempAddress->ifa_addr)->sin_addr)];
            NSLog(@"%@",address);
            }
            
            
        }
        tempAddress = tempAddress->ifa_next;
    }
    free(address);
    
    
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
