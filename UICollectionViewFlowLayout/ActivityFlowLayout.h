//
//  ActivityFlowLayout.h
//  IOSProjectDemo
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityModel <NSObject>

@property (nonatomic,assign) CGFloat imageWidth;//default
@property (nonatomic,assign) CGFloat imageHeight;


@end

@protocol ActivityFlowLayoutDelegate <NSObject>

- (NSArray<ActivityModel> *)modelLayoutArr;


@end

@interface ActivityFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<ActivityFlowLayoutDelegate> delegate;


@end
