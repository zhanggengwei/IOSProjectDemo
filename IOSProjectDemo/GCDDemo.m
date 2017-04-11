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
 
 GCD的队列组 dispatch_group
 
 有时候我们会有这样的需求：分别异步执行2个耗时操作，然后当2个耗时操作都执行完毕后再回到主线程执行操作。这时候我们可以用到GCD的队列组。
 我们可以先把任务放到队列中，然后将队列放入队列组中。
 调用队列组的dispatch_group_notify回到主线程执行操作。
 dispatch_group_t group =  dispatch_group_create();
 
 dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 // 执行1个耗时的异步操作
 });
 
 dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 // 执行1个耗时的异步操作
 });
 
 dispatch_group_notify(group, dispatch_get_main_queue(), ^{
 // 等前面的异步操作都执行完毕后，回到主线程...
 });
 
 GCD的快速迭代方法 dispatch_apply
 
 通常我们会用for循环遍历，但是GCD给我们提供了快速迭代的方法dispatch_apply，使我们可以同时遍历。比如说遍历0~5这6个数字，for循环的做法是每次取出一个元素，逐个遍历。dispatch_apply可以同时遍历多个数字。
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 
 dispatch_apply(6, queue, ^(size_t index) {
 NSLog(@"%zd------%@",index, [NSThread currentThread]);
 });
 输出结果：
 2016-09-03 19:37:02.250 GCD[11764:1915764] 1------<NSThread: 0x7fac9a7029e0>{number = 1, name = main}
 2016-09-03 19:37:02.250 GCD[11764:1915885] 0------<NSThread: 0x7fac9a614bd0>{number = 2, name = (null)}
 2016-09-03 19:37:02.250 GCD[11764:1915886] 2------<NSThread: 0x7fac9a542b20>{number = 3, name = (null)}
 2016-09-03 19:37:02.251 GCD[11764:1915764] 4------<NSThread: 0x7fac9a7029e0>{number = 1, name = main}
 2016-09-03 19:37:02.250 GCD[11764:1915884] 3------<NSThread: 0x7fac9a76ca10>{number = 4, name = (null)}
 2016-09-03 19:37:02.251 GCD[11764:1915885] 5------<NSThread: 0x7fac9a614bd0>{number = 2, name = (null)}
 从输出结果中前边的时间中可以看出，几乎是同时遍历的。
 
 2. GCD的延时执行方法 dispatch_after
 
 当我们需要延迟执行一段代码时，就需要用到GCD的dispatch_after方法。
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 // 2秒后异步执行这里的代码...
 NSLog(@"run-----");
 });
 1. GCD的栅栏方法 dispatch_barrier_async
 
 我们有时需要异步执行两组操作，而且第一组操作执行完之后，才能开始执行第二组操作。这样我们就需要一个相当于栅栏一样的一个方法将两组异步执行的操作组给分割起来，当然这里的操作组里可以包含一个或多个任务。这就需要用到dispatch_barrier_async方法在两个操作组间形成栅栏。
 - (void)barrier
 {
 dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
 
 dispatch_async(queue, ^{
 NSLog(@"----1-----%@", [NSThread currentThread]);
 });
 dispatch_async(queue, ^{
 NSLog(@"----2-----%@", [NSThread currentThread]);
 });
 
 dispatch_barrier_async(queue, ^{
 NSLog(@"----barrier-----%@", [NSThread currentThread]);
 });
 
 dispatch_async(queue, ^{
 NSLog(@"----3-----%@", [NSThread currentThread]);
 });
 dispatch_async(queue, ^{
 NSLog(@"----4-----%@", [NSThread currentThread]);
 });
 }
 输出结果：
 2016-09-03 19:35:51.271 GCD[11750:1914724] ----1-----<NSThread: 0x7fb1826047b0>{number = 2, name = (null)}
 2016-09-03 19:35:51.272 GCD[11750:1914722] ----2-----<NSThread: 0x7fb182423fd0>{number = 3, name = (null)}
 2016-09-03 19:35:51.272 GCD[11750:1914722] ----barrier-----<NSThread: 0x7fb182423fd0>{number = 3, name = (null)}
 2016-09-03 19:35:51.273 GCD[11750:1914722] ----3-----<NSThread: 0x7fb182423fd0>{number = 3, name = (null)}
 2016-09-03 19:35:51.273 GCD[11750:1914724] ----4-----<NSThread: 0x7fb1826047b0>{number = 2, name = (null)}
 可以看出在执行完栅栏前面的操作之后，才执行栅栏操作，最后再执行栅栏后边的操作。
 */


@end
