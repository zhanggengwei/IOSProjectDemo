//
//  VDLoadingVideoView.h
//  IOSProjectDemo
//
//  Created by VD on 2017/9/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double MMMaterialDesignSpinnerVersionNumber;

//! Project version string for MMMaterialDesignSpinner.
FOUNDATION_EXPORT const unsigned char MMMaterialDesignSpinnerVersionString[];

@interface VDLoadingVideoView : UIView

@property (nonatomic) BOOL hidesWhenStopped;

@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

@property (nonatomic, readonly) BOOL isAnimating;
@property (nonatomic, readwrite) NSTimeInterval duration;

- (void)setAnimating:(BOOL)animate;

/**
 *  Starts animation of the spinner.
 */
- (void)startAnimating;

/**
 *  Stops animation of the spinnner.
 */
- (void)stopAnimating;


@end
