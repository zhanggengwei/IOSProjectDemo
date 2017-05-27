//
//  ViewController.m
//  IOSRACProductDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFile1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.btn.enabled = NO;
    
    /*
         监听多个数据源的变化
     */
    RACSignal * signal = [RACSignal combineLatest:@[self.textFile1.rac_textSignal,self.textField2.rac_textSignal,self.textField3.rac_textSignal] reduce:^id{
        
        return @(self.textField3.text.length&&self.textField2.text.length&&self.textFile1.text.length);
    }];
    [signal subscribeNext:^(NSNumber * x) {
     
           self.btn.enabled = x.integerValue;
        
    }];
    
    
    RACSignal * signal2 =   [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"you are good"];
        [subscriber sendNext:@"byz"];
        
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:401 userInfo:nil];
        [subscriber sendError:error];
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    [signal2 subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];
    
  
    [signal2 subscribeError:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    [signal2 subscribeCompleted:^{
        
        NSLog(@"任务完成");
        
    }];
   
  
    
    
    
    

    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
