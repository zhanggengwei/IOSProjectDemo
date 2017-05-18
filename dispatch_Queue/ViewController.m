//
//  ViewController.m
//  dispatch_Queue
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"

void test(void * buf)
{
    printf("%s",buf);
    
}
typedef void (*hwcTestForGCD)(void*);
hwcTestForGCD getFuncPointer(void * buf){
    return test;
    
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    dispatch_async 立即放回
//    dispatch_sync  等待block执行完毕后返回
    
    /*
     //死锁产生的原因 dispatch_sync 等待block的结束，block 等待主线程的结束堵塞现线程
     dispatch_sync(dispatch_get_main_queue(), ^{
     
     NSLog(@"%s",__PRETTY_FUNCTION__);
     });
     */
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        NSLog(@"%s",__PRETTY_FUNCTION__);
//    });
    //并行线程队列  dispatch_get_global_queue("", 0); dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
    //串行线程队列 dispatch_queue_create("", DISPATCH_QUEUE_SERIAL)
    void (*pointer)(void * arg) = &test;
    /*
     dispatch_async_f(dispatch_queue_t queue,
     void *_Nullable context,
     dispatch_function_t work);
     context 代表 dispatch_function_t 内部参数
     
     */
   
    
    //定时器
    
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
//    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC,0);
//    dispatch_source_set_event_handler(timer, ^{
//        NSLog(@"timer start");
//    });
//    dispatch_resume(timer);
    
    
    [self startTime];
    
    
}
-(void)startTime{
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    NSLog(@"start thread");
    dispatch_source_set_event_handler(_timer, ^{
        
        NSLog(@"time start");
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                
                
            });
            timeout--;
            //
        }
 
    });
    dispatch_resume(_timer);
    
    NSLog(@"threa");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
