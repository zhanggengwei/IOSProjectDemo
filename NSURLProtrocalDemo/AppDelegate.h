//
//  AppDelegate.h
//  NSURLProtrocalDemo
//
//  Created by Donald on 17/4/21.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

