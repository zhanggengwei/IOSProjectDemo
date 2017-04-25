//
//  ActivityFlowLayout.h
//  IOSProjectDemo
//
//  Created by Donald on 17/4/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityModelProtrol <NSObject>

@property (nonatomic,assign) CGRect  itemframe;

@end


@interface ActivityModel : NSObject<ActivityModelProtrol>


@end

@protocol ActivityFlowLayoutDelegate <NSObject>

- (NSArray<ActivityModelProtrol> *)modelLayoutArr;

@end

@interface ActivityFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<ActivityFlowLayoutDelegate> delegate;


@end
