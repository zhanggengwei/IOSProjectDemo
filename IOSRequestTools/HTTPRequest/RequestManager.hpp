//
//  RequestManager.hpp
//  IOSProjectDemo
//
//  Created by Donald on 17/4/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#ifndef RequestManager_hpp
#define RequestManager_hpp
typedef void (*callResulst)(char * str);

#include <stdio.h>


class HTTPRequestManagerTools
{
    public:
    void requestGet(char * url,callResulst result);
    void requestPost(char * url,va_list header,va_list values,callResulst resulst);
    
};

#endif /* RequestManager_hpp */
