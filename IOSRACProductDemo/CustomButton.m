//
//  CustomButton.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/27.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "CustomButton.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation CustomButton


- (void)awakeFromNib
{
    [super awakeFromNib];
 
    
    //这样子不带协议是无法代替代理的,虽然能达到效果,这个方法表示某个selector被调用时执行一段代码.带有协议参数的表示该selector实现了某个协议，所以可以用它来实现Delegate。
    //    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)] subscribeNext:^(RACTuple* x) {
    
    //        NSLog(@"%@",[x class]);
    
    //        NSLog(@"%@",x);
    //    }];
    
    //这里是个坑,必须将代理最后设置,否则信号是无法订阅到的
   

}

- (instancetype)init
{
    if(self = [super init])
    {
        self.delegate = self;
    }
    return self;
}


@end
