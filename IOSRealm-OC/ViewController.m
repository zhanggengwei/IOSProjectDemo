//
//  ViewController.m
//  IOSRealm-OC
//
//  Created by Donald on 17/5/2.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#include <Realm/Realm.h>
#import "UserInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatDataBaseWithName:@"data.realm"];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)creatDataBaseWithName:(NSString *)databaseName
{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.objectClasses = @[NSClassFromString(@"UserInfo")];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {
        // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
        }
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    
    RLMRealm * realm = [RLMRealm realmWithConfiguration:config error:nil];
    [realm beginWriteTransaction];
    UserInfo * info = [UserInfo new];
    info.name = @"zhangsan";
    info.passWord = @"zhongjie";
    info.phone = @"18863014571";
    [realm addObject:info];
    [realm commitWriteTransaction];
    
    
    RLMResults * arr  = [UserInfo allObjects];
    NSLog(@"arr == %@",arr);
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
