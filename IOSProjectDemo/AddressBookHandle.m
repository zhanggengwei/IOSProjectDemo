//
//  AddressBookHandle.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/10.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "AddressBookHandle.h"
#import <AddressBook/AddressBook.h>
@implementation AddressBookHandle


- (void)loadContacts
{
    
    ABAddressBookRef addressbook = ABAddressBookCreateWithOptions(NULL, NULL);
    void (^requestContacts)(void) = ^(void)
    {
        
        /*
         AB_EXTERN CFArrayRef ABAddressBookCopyArrayOfAllSources(ABAddressBookRef addressBook) AB_DEPRECATED("use [CNContactStore containersMatchingPredicate:nil error:]");
         AB_EXTERN CFArrayRef ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook) AB_DEPRECATED("use CNContactFetchRequest with predicate = nil");
         */
        NSMutableArray *array = (__bridge NSMutableArray *)(ABAddressBookCopyArrayOfAllSources(addressbook));
//        array =  (__bridge NSMutableArray *)(ABAddressBookCopyArrayOfAllPeople(addressbook));
        for (int i = 0; i < array.count; i++)
        {
            ABRecordRef recoard = (__bridge ABRecordRef)(array[i]);
        
        }
        
    };
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if(status == kABAuthorizationStatusNotDetermined)
    {
        
       ABAddressBookRequestAccessWithCompletion(addressbook, ^(bool granted, CFErrorRef error) {
           if(granted)
           {
               requestContacts();
           }
       });
        
        
        
    }else if (status == kABAuthorizationStatusDenied)
    {
        
    }else if (status == kABAuthorizationStatusAuthorized)
    {
        requestContacts();
    }
    
}

@end
