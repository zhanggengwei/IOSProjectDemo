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
    
    CNAuthorizationStatus contactType = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    CNContactStore * store = [CNContactStore new];
   void(^fetchContactsResult)(void)= ^(void)
    {
      
         NSArray *fetchKeys = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:fetchKeys];
        
        
        request.sortOrder = CNContactSortOrderFamilyName;
        
        NSError * error = nil;
        [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            
            NSLog(@"%@",contact);
            
        }];
    };
    if(contactType==CNAuthorizationStatusNotDetermined)
    {
       
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted)
            {
                fetchContactsResult();
            }
        }];
    }else
    {
        if(contactType == CNAuthorizationStatusDenied)
        {
            NSLog(@"用户拒绝");
        }else
        {
            fetchContactsResult();
        }
    }
   
    
    
   
    
}


@end
