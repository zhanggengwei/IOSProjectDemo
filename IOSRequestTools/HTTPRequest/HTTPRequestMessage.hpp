//
//  HTTPRequestMessage.hpp
//  IOSProjectDemo
//
//  Created by Donald on 17/4/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#ifndef HTTPRequestMessage_hpp
#define HTTPRequestMessage_hpp
#include <stdio.h>
#include <string.h>
#include <iostream>
#import <CFNetwork/CFNetwork.h>
using namespace std;

extern string HTTP_VERSION;



class HTTPMessage
{
    
private:
    CFHTTPMessageRef messageRef;
    CFHTTPMessageRef createResponse(CFIndex code,string description,CFAllocatorRef alloc,string httpVersion);
    CFHTTPMessageRef createEmptyRequest(CFAllocatorRef allocref,Boolean isRequest);
    //CFHTTPMessageCreateRequest
    CFHTTPMessageRef createCustomRequest(CFAllocatorRef alloc,string url,string method,string version);
    Boolean CFHTTPMessageIsRequest(CFHTTPMessageRef messageRef);
    string requestCopyVersion(CFHTTPMessageRef messageRef);
    
    
    
public:
    void setHTTPHeaderValue(string header,string value);
    
    
};

#endif /* HTTPRequestMessage_hpp */
