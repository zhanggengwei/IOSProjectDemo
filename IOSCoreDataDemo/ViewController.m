//
//  ViewController.m
//  IOSCoreDataDemo
//
//  Created by Donald on 17/4/21.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import <CoreData/CoreData.h>
#import "Person.h"

@interface ViewController ()
@property (nonatomic,strong) AppDelegate * appdelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appdelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
  
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"U_table" inManagedObjectContext:self.appdelegate.persistentContainer.viewContext];
    Person *person = [[Person alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.appdelegate.persistentContainer.viewContext];
    person.password = [NSString stringWithFormat:@"JACK%d",arc4random()%100];person.identify = arc4random()%60+1;
    person.userName = arc4random()%2==0?@"man":@"woman";
    [self.appdelegate saveContext];
    
    
    [self getStatusByUserName:@""];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSArray *)getStatusByUserName:(NSString *)name {
    // 初始化查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"U_table"];
    // 初始化谓词，设置获取数据的条件
//    request.predicate = [NSPredicate predicateWithFormat:@"user.name=%@",name];
    // 执行对象管理上下文的查询方法
    NSError *error = nil;
    NSArray<NSEntityDescription *> *array = [self.appdelegate.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    NSLog(@"%@",[array.firstObject class]);
    for (Person *p in array)
    {
        NSLog(@"p.userName == %@,p.password == %@,identify == %ld",p.userName,p.password,p.identify);
        
    }    
    if (error) {
        NSLog(@"查询错误，错误信息：%@!",error.localizedDescription);
    }
    return  array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
