//
//  Marchos.h
//  IOSProjectDemo
//
//  Created by VD on 2017/9/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#ifndef Marchos_h
#define Marchos_h

#import "UIWindow+CurrentViewController.h"
#import "VDPlayerControlViewDelegate.h"
#import "VDPlayerModel.h"
#import "UIImageView+ZFCache.h"
#import "VDBrightnessView.h"



#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 监听TableView的contentOffset
#define kVDPlayerViewContentOffset          @"contentOffset"
// player的单例
#define VDPlayerShared                      [VDBrightnessView sharedBrightnessView]
// 颜色值RGB
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 图片路径
#define VDPlayerSrcName(file)    file

#define VDPlayerFrameworkSrcName(file) file
#define VDPlayerImage(file) [UIImage imageNamed:VDPlayerSrcName(file)]

#define VDPlayerOrientationIsLandscape      UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)

#define VDPlayerOrientationIsPortrait       UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)



#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#endif /* Marchos_h */
