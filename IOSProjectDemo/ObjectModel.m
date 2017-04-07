//
//  ObjectModel.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ObjectModel.h"

@implementation ObjectModel


- (void)printModelAddress
{
    NSLog(@"%p %p %p %p",self,&_name,&_passWord);
    NSLog(@"%ld",sizeof(_name));
    /*
     使用@property声明的属性在编译阶段会自动生成一个以下划线开头的ivar并且绑定setter和getter方法，所以我们可以在类文件中使用_property的方式访问变量。那么根据上面的地址偏移的输出，属性生成的变量实际上是跟在成员变量的后面的，那么这是怎么实现的？
     
     */
    
    
}

@end
