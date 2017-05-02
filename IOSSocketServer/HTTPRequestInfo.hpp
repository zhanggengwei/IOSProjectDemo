//
//  HTTPRequestInfo.hpp
//  IOSProjectDemo
//
//  Created by Donald on 17/5/2.
//  Copyright © 2017年 Susu. All rights reserved.
//

#ifndef HTTPRequestInfo_hpp
#define HTTPRequestInfo_hpp

#include <stdio.h>
#include <iostream>
using namespace std;
class HTTPRequestInfo
{
private:
public:
    string url;
    string request_method;//get post
    string query_string;
    string remote_user;
    string remote_ip;
    u_int  remote_port;
    u_int  post_data_len;
    u_int http_version_major;
    u_int http_version_minor;
    u_int status_code;
    u_int num_headers;
    
    struct mg_header {
        char	*name;		/* HTTP header name	*/
        char	*value;		/* HTTP header value	*/
    } http_headers[64];
    
    char * post_data;
    
    
    
};

#endif /* HTTPRequestInfo_hpp */
