//
//  VDContactsStore.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/7.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "VDContactsStore.h"
#import <Contacts/Contacts.h>
@implementation VDContactsStore


- (void)loadDataContacts
{
    
    
    //+ (CNAuthorizationStatus)authorizationStatusForEntityType:(CNEntityType)entityType;
    CNAuthorizationStatus contactType = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    CNContactStore * store = [CNContactStore new];
    if(contactType==CNAuthorizationStatusNotDetermined)
    {
       
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    }else
    {
        if(contactType == CNAuthorizationStatusDenied)
        {
            NSLog(@"用户拒绝");
        }else
        {
            
        }
    }
    CNContactFetchRequest * request = [CNContactFetchRequest new];
    request.sortOrder = CNContactSortOrderFamilyName;
    
    NSError * error = nil;
   [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
      
   }];
    
    
   
    
}


@end
