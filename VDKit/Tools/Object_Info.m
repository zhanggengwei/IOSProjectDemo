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
{
    NSMutableDictionary * tempDict;
}
- (instancetype)initWithClass:(Class)cls
{
    if(self = [super init])
    {
        tempDict = [NSMutableDictionary new];
        [self loadVar:cls];
    }
    return self;
}

- (void)loadVar:(Class)cls
{
    
    unsigned int count = 0;
    Ivar * list = class_copyIvarList(cls, &count);
    
    for (int i = 0; i < count; i++)
    {
        Object_Item * item = [[Object_Item alloc]initWithVar:list[i]];
        [tempDict setObject:item forKey:item.name ];
    }
    _dict = [NSDictionary dictionaryWithDictionary:tempDict];
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
    _name = [[NSString stringWithFormat:@"%s",name] substringFromIndex:1];
    
    switch (*type)
    {
        case 'S':
        case 'I':
        case 'i':
        case 'C':
            _type = @"intValue";
            break;
        case 'B':
            _type = @"boolValue";
            break;
        case 'Q':
            _type = @"integerValue";
            break;
        case 'f':
            _type = @"floatValue";
        case 'd':
        case 'D':
            _type = @"doubleValue";
            break;
        case '@':
        {
            if(strcmp("@\"NSString\"", type)==0)
            {
                _type = @"string";
            }else if (strcmp("@\"NSDate\"", type)==0)
            {
                _type = @"date";
            }else if(strcmp("@\"NSNumber\"", type)==0)
            {
                _type = @"number";
            }
            
            break;
        }
        
    }

}

@end
