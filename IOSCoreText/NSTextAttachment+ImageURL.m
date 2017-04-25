//
//  NSTextAttachment+ImageURL.m
//  IOSProjectDemo
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "NSTextAttachment+ImageURL.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSString+isValid.h"

#if __has_include(<SDWebImage/SDWebImageDownloader.h>)
#import <SDWebImage/SDWebImageManager.h>
#else
#import "SDWebImage/SDWebImageDownloader.h"
#endif

const void *  ImageURLKey = &ImageURLKey;

@implementation NSTextAttachment (ImageURL)



- (void)setImageURL:(NSString *)ImageURL
{
   
    objc_setAssociatedObject(self, ImageURLKey, ImageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)loadImageURl:(NSString *)imageUrl withBlock:(downImageblock)block
{
    [self setImageURL:imageUrl];
    if(![imageUrl isValid])
    {
        NSLog(@"imageUrl isValid");
        return;
    }
    NSURL * imageURL = [NSURL URLWithString:imageUrl];
    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:imageURL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            NSString * imageKey = [manager cacheKeyForURL:imageURL];
            UIImage * image = [manager.imageCache imageFromMemoryCacheForKey:imageKey]?[manager.imageCache imageFromMemoryCacheForKey:imageKey]:[manager.imageCache imageFromDiskCacheForKey:imageKey];
            if(block)
            {
                block(image,nil);
                
            }
            
        }
        else
        {
            [manager downloadImageWithURL:imageURL options:SDWebImageLowPriority|SDWebImageProgressiveDownload|SDWebImageRefreshCached|SDWebImageAllowInvalidSSLCertificates progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
               
                if(block)
                {
                    block(image,error);
                }
            }];
        }
    }];
}

- (NSString *)ImageURL
{
    return objc_getAssociatedObject(self, ImageURLKey);
}





@end
