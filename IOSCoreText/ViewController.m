//
//  ViewController.m
//  IOSCoreText
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import "NSTextAttachment+ImageURL.h"
@interface ViewController ()

@property (nonatomic,strong) UITextView * textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.textView];
    self.textView.allowsEditingTextAttributes = YES;
    
    self.textView.editable = NO;
    
    NSTextAttachment * attchment = [[NSTextAttachment alloc]init];
    attchment.bounds = CGRectMake(0,0,100, 100);
    attchment.image = [UIImage imageNamed:@"个人主页.png"];
    attchment.ImageURL = @"http://img4.imgtn.bdimg.com/it/u=819201812,3553302270&fm=23&gp=0.jpg";
 
  __block  NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attchment]];
    self.textView.attributedText = string;
    NSMutableParagraphStyle * style = [NSMutableParagraphStyle new];
    style.lineSpacing = 10;
    //style.alignment = NSTextAlignmentCenter;
    
    
    [attchment loadImageURl:attchment.ImageURL withBlock:^(UIImage *image, NSError *error) {
        if(!error){
            attchment.image = image;
            string = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attchment]];
            [string appendAttributedString:string];
            [string setAttributes:@{NSAttachmentAttributeName:attchment} range:NSMakeRange(0, string.length)];
            [string setAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, string.length)];
            
            self.textView.attributedText = string;
            
        }
    }];
    

    

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
