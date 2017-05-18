//
//  TestOperation.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/18.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "TestOperation.h"

@implementation TestOperation
{
    BOOL executing;
    BOOL finished;
}

//- (void)main
//{
//    while (1)
//    {
//        sleep(1);
//        NSLog(@"thread ==%@",[NSThread currentThread]);
//        NSURL *url=[NSURL URLWithString:@""];
//        NSData *data=[NSData dataWithContentsOfURL:url];
//        NSLog(@"data == %@",data);
//    }
//}
- (id)init {
    if(self = [super init])
    {
        executing = NO;
        finished = NO;
    }
    return self;
}
- (BOOL)isConcurrent {
    
    return YES;
}
- (BOOL)isExecuting {
    
    return executing;
}
- (BOOL)isFinished {
    
    return finished;
}

- (void)start {
    [super start];
    //第一步就要检测是否被取消了，如果取消了，要实现相应的KVO
    if ([self isCancelled]) {
        
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    //如果没被取消，开始执行任务
    [self willChangeValueForKey:@"isExecuting"];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        
        @autoreleasepool {
            //在这里定义自己的并发任务
            
            NSLog(@"自定义并发操作NSOperation  ");
            NSThread *thread = [NSThread currentThread];
            NSLog(@"%@",thread);
            
            //任务执行完成后要实现相应的KVO
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            
            executing = NO;
            finished = YES;
            
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
            
            
            NSLog(@"thread ==%@",[NSThread currentThread]);
        }
    }
    @catch (NSException *exception) {
        
    }
    
}

@end
