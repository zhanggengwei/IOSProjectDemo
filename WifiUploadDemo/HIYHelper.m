//
//  HIYHelper.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/11.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "HIYHelper.h"
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <ifaddrs.h>

@implementation HIYHelper
+ (NSString *)getLocalAddress
{
    struct ifaddrs * interface = NULL;
    struct ifaddrs * temp = interface;
    int flag = getifaddrs(&interface);
    if(flag==0)
    {
        while (temp)
        {
            
            if(temp->ifa_addr->sa_family == AF_INET)
            {
                //char		*inet_ntoa(struct in_addr);
                 struct sockaddr_in * address = (struct sockaddr_in *)temp->ifa_addr;
                 char * addressString = inet_ntoa(address->sin_addr);
            }
            temp = temp->ifa_next;
        }
        if(interface)
        {
            freeifaddrs(interface);
            interface = NULL;
        }
    }
    return @"";
    
    
}

+ (NSString *)getWifiName
{
    
}
@end
