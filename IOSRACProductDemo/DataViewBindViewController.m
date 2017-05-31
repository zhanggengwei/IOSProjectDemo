//
//  DataViewBindViewController.m
//  IOSProjectDemo
//
//  Created by Donald on 17/5/31.
//  Copyright © 2017年 Susu. All rights reserved.
//
/*
 *  数据 与view的绑定
 *
 */
#import "DataViewBindViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UserInfo.h"
#import "CustomButton.h"
@interface DataViewBindViewController ()

@property (nonatomic,strong) UserInfo * info;
@property (weak, nonatomic) IBOutlet UITextField *textfile1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;

@property (weak, nonatomic) IBOutlet UITextField *textfield3;
@property (weak, nonatomic) IBOutlet CustomButton *btn;

@end
@implementation DataViewBindViewController


+ (instancetype)createViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"DataViewBindViewController"];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 模型 －》UI的改变 模型的改变会影响到UI的改变
    self.info = [UserInfo new];
 
    //self.info.nickName = @"zahgn";
    
    
    
    [[RACSignal combineLatest:@[self.textfile1.rac_textSignal,self.textfield2.rac_textSignal,self.textfield3.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        
        self.info.nickName = x.first;
        self.info.paddWord = x.second;
        self.info.phone = x.third;
    }];
    RAC(self.textfile1,text) = RACObserve(self.info, nickName);
    self.info.nickName = @"sdsfsdfsdf";
    
    
//    RAC(self.info,paddWord) = RACObserve(self.textfield2,text);
//    RAC(self.info,phone) = RACObserve(self.textfield3,text);
//    self.info.nickName = @"zhangsan";
    // Do any additional setup after loading the view.
    
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"%@  %@   %@",self.info.nickName,self.info.paddWord,self.info.phone);
    }];
    
    
//    RACSequence  高效的遍历数组
    
    
    
    NSArray * arr = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9)];
    
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [self concatSignal];
    
    
    
}
// 组合信号

- (void)concatSignal
{
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted]; // 必须要调用sendCompleted方法！
        return nil;
        
    }];
    
    // 创建信号B，
    RACSignal *signalsB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        //        NSLog(@"--发送下部分请求--afn");
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    
   RACSignal * concatSignal = [signalA concat:signalsB];
    // 订阅组合信号
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
