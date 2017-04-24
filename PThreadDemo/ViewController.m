//
//  ViewController.m
//  PThreadDemo
//
//  Created by Donald on 17/4/21.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

static int a = 500;
@interface ViewController ()

@end

@implementation ViewController

void * function(void * p)
{
    for (int i=0; i <= 10; i++)
    {
        sleep(i*0.1);
        a = a-i;
        printf("%s == %d\n",p,a);
    }
    return NULL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    pthread_t Athread = NULL;
    pthread_t Bthread = NULL;
    
    
    pthread_mutex_t lock ;//= PTHREAD_MUTEX_INITIALIZER;
    
    
    pthread_mutex_init(&lock, NULL);
    pthread_mutex_lock(&lock);
//    pthread_create(&Bthread, NULL,function, "b");
    pthread_join(Bthread, NULL);
    pthread_mutex_unlock(&lock);
    pthread_mutex_destroy(&lock);
    
    
   // pthread_create(&Athread, NULL,function, "a");
    pthread_join(Athread, NULL);//
    
    
    
    //模拟多线程中的线程不安全问题
//    pthread_join函数的调用者在等待子线程退出后才继续执行{存在可能，不使用这个方法 子线程 未结束，主线程 结束 退出程序}
    
    
    /*
     mutex 互斥量使用框架
     pthread_mutex_t lock;
     pthread_mutex_init 或者 PTHREAD_MUTEX_INITIALIZER（仅可用在静态变量）
     pthread_mutex_lock / pthread_mutex_unlock / pthread_mutex_trylock
     pthread_mutex_destroy
    */
    /*
     5. cond 条件变量
     pthread_cond_t qready;
     pthread_mutex_t qlock;
     pthread_mutex_init 或者 PTHREAD_MUTEX_INITIALIZER
     pthread_cond_init 或者 PTHREAD_COND_INITIALIZER
     pthread_mutex_lock(&qlock...)
     pthread_cond_wait(&qready, &qlock...) / pthread_cond_timewait
     pthread_mutex_unlock(&qlock)
     pthread_cond_destroy
     */
//    //唤醒条件变量
//    pthread_cond_signal
//    pthread_cond_broadcast
    
//    pthread_mutex_t _lock;
//    pthread_mutex_init(&_lock, NULL); //初始化一个互斥锁
//    pthread_mutex_lock(&_lock); //加锁，线程进入临界区，其他线程在外面等待
//    ...... //执行临界区代码
//    pthread_mutex_unlock(&_lock); //解锁，线程离开临界区，其他线程进入临界区执行
//    pthread_mutex_destroy(&_lock); //最后销毁互斥锁
//    
//    
    // pthread_detach:设置子线程的状态设置为detached,则该线程运行结束后会自动释放所有资源。
    //pthread_detach(threadId);
    // Do any additional setup after loading the view, typically from a nib.
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
