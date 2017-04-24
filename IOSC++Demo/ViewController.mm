//
//  ViewController.m
//  IOSC++Demo
//
//  Created by Donald on 17/4/24.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "VDImage.hpp"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    char file[] = "/Users/donald/Documents/IOSProjectDemo/IOSC++Demo/签名.png";
    VDImage image = VDImage(file);
    
    image.printFileContent();
    
    

    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
