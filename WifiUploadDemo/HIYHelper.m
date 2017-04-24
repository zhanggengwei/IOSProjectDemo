//
//  HIYHelper.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/11.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "HIYHelper.h"
#import <netdb.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <sys/socket.h>

#import <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation HIYHelper
+ (NSString *)getLocalAddress
{
    struct ifaddrs * interface = NULL;
    int flag = getifaddrs(&interface);
    struct ifaddrs * temp = interface;
    char * addressString = NULL;
    if(flag==0)
    {
        while (temp)
        {
            
            if(temp->ifa_addr->sa_family == AF_INET)
            {
                if ([[NSString stringWithUTF8String:temp->ifa_name] isEqualToString:@"en0"])
                {
                    //char		*inet_ntoa(struct in_addr);
                    struct sockaddr_in * address = (struct sockaddr_in *)temp->ifa_addr;
                    addressString = inet_ntoa(address->sin_addr);
                    
                    NSLog(@"address==%s",addressString);
                }
               
            }
            temp = temp->ifa_next;
        }
        if(interface)
        {
            freeifaddrs(interface);
            interface = NULL;
        }
    }
    return [NSString stringWithFormat:@"%s",addressString];
    
    
}

+ (NSString *)getWifiName
{
    NSString * wifiName = nil;
    CFArrayRef array = CNCopySupportedInterfaces();
    if(array==NULL)
    {
        NSLog(@"error");
        return @"";
    }
    for (int i = 0; i < CFArrayGetCount(array); i++)
    {
        CFDictionaryRef dict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array,i));
        if(dict)
        {
            wifiName = CFDictionaryGetValue(dict, kCNNetworkInfoKeySSID);
            CFRelease(dict);
        }
    }
    CFRelease(array);
    return wifiName;
}
@end
