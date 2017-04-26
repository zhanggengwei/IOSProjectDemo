//
//  ViewController.m
//  IOSSocketServer
//
//  Created by VD on 2017/4/17.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "HTTPServer.h"
#include "lhttp.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HTTPServer new]startPort:@"9090"];
//    if(-1 == (mkdir(WEB_SITE, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)))
//            {
//                if(ENOSPC == errno)
//                {
//                    perror ( "disk do not have enough space!\n" );
//                    exit(1);
//                }
//            }
//            chdir(WEB_SITE);
//            create_socket();
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
