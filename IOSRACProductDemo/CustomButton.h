//
//  CustomButton.h
//  IOSProjectDemo
//
//  Created by Donald on 17/5/27.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonProtrocal.h"
@interface CustomButton : UIButton<UIButtonProtrocal>


@property (nonatomic,weak) id <UIButtonProtrocal> delegate;

- (void)printMessage:(id)sender;


@end
