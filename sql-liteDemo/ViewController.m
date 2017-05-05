//
//  ViewController.m
//  sql-liteDemo
//
//  Created by Donald on 17/5/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * directonary = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    if(fopen([directonary stringByAppendingString:@"/sql.sqlite"].UTF8String,"a+")==0)
    {
        
    }
    sqlite3 * sql;
    int flag = sqlite3_open([directonary stringByAppendingString:@"/sql.sqlite"].UTF8String, &sql);
    char * searchSql = "show tablebases";
    
    

    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
