//
//  Object_Info.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/26.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "Object_Info.h"
#import <string.h>

@implementation Object_Info
- (instancetype)initWithClass:(Class)cls
{
    if(self = [super init])
    {
        _list = [NSArray new];
        [self loadPropertyWith:cls];
    }
    return self;
}

- (void)loadPropertyWith:(Class)cls
{
    
    unsigned int count = 0;
    Ivar * list = class_copyIvarList(cls, &count);
    
    for (int i = 0; i < count; i++)
    {
      _list = [_list arrayByAddingObject:[[Object_Item alloc]initWithVar:list[i]]];
    }
    
    free(list);

}


@end

@implementation Object_Item
- (instancetype)initWithVar:(Ivar)var
{
    if(self)
    {
        self = [super init];
        _var = var;
        [self loadVar];
    }
    
    return self;
}

- (void)loadVar
{
    const char * name = ivar_getName(_var);
    const char * type = ivar_getTypeEncoding(_var);
    _name = [NSString stringWithFormat:@"%s",name];
    switch (*type)
    {
        case 'S':
        case 'I':
        case 'i':
        case 'C':
            _type = @"Int";
        case 'c':
            _type = @"Int";
            break;
        case 'B':
            _type = @"bool";
            break;
        case 'Q':
            _type = @"unsignedLongLongInt";
            break;
        case 'q':
            _type = @"longLongInt";
            break;
        case 'd':
        case 'D':
            _type = @"double";
            break;
        case '@':
        {
            if(strcmp("NSString", type)==0)
            {
                _type = @"string";
            }else if (strcmp("NSDate", type)==0)
            {
                _type = @"date";
            }
            
            break;
        }
        
    }

}

@end
