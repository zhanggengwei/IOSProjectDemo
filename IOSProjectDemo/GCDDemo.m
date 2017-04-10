//
//  GCDDemo.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/10.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "GCDDemo.h"

@implementation GCDDemo
/*
    GCD的好处：
      1 GCD会自动利用更多的CPU内核（比如双核、四核）
      2 GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程
      3 GCD可用于多核的并行运算
      4 程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
 
    任务：就是执行操作的意思，换句话说就是你在线程中执行的那段代码。在GCD中是放在block中的。执行任务有两种方式：
        同步执行和异步执行。两者的主要区别是：是否具备开启新线程的能力
        同步执行（sync）：只能在当前线程中执行任务，不具备开启新线程的能力
        异步执行（async）：可以在新的线程中执行任务，具备开启新线程的能力
 
    队列：这里的队列指任务队列，即用来存放任务的队列。队列是一种特殊的线性表，采用FIFO（先进先出）的原则，即新任务总是被插入到队列的末尾，而读取任务的时候总是从队列的头部开始读取。每读取一个任务，则从队列中释放一个任务。在GCD中有两种队列：串行队列和并发队列。
     并发队列（Concurrent Dispatch Queue）：可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）
     并发功能只有在异步（dispatch_async）函数下才有效
     串行队列（Serial Dispatch Queue）：让任务一个接着一个地执行（一个任务执行完毕后，再执行下一个任务）
    // 串行队列的创建方法
     dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    // 并发队列的创建方法
     dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
 
                   并发队列	            串行队列	主队列
 同步(sync)	没有开启新线程，串行执行任务	没有开启新线程，串行执行任务	没有开启新线程，串行执行任务
 异步(async)	有开启新线程，并发执行任务	有开启新线程(1条)，串行执行任务	没有开启新线程，串行执行任务

 
 
 */


@end
