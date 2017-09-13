//
//  VDPlayerView.h
//  IOSProjectDemo
//
//  Created by VD on 2017/9/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VDPlayerControlViewDelegate.h"
#import "VDPlayerModel.h"


@protocol VDPlayerDelegate <NSObject>
@optional
/** 返回按钮事件 */
- (void)vd_playerBackAction;
/** 下载视频 */
- (void)vd_playerDownload:(NSString *)url;
/** 控制层即将显示 */
- (void)vd_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen;
/** 控制层即将隐藏 */
- (void)vd_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen;

@end

// playerLayer的填充模式（默认：等比例填充，直到一个维度到达区域边界）
typedef NS_ENUM(NSInteger, VDPlayerLayerGravity) {
    VDPlayerLayerGravityResize,           // 非均匀模式。两个维度完全填充至整个视图区域
    VDPlayerLayerGravityResizeAspect,     // 等比例填充，直到一个维度到达区域边界
    VDPlayerLayerGravityResizeAspectFill  // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

// 播放器的几种状态
typedef NS_ENUM(NSInteger, VDPlayerState) {
    VDPlayerStateFailed,     // 播放失败
    VDPlayerStateBuffering,  // 缓冲中
    VDPlayerStatePlaying,    // 播放中
    VDPlayerStateStopped,    // 停止播放
    VDPlayerStatePause       // 暂停播放
};

@interface VDPlayerView : UIView <VDPlayerControlViewDelegate>

/** 设置playerLayer的填充模式 */
@property (nonatomic, assign) VDPlayerLayerGravity    playerLayerGravity;
/** 是否有下载功能(默认是关闭) */
@property (nonatomic, assign) BOOL                    hasDownload;
/** 是否开启预览图 */
@property (nonatomic, assign) BOOL                    hasPreviewView;
/** 设置代理 */
@property (nonatomic, weak) id<VDPlayerDelegate>      delegate;
/** 是否被用户暂停 */
@property (nonatomic, assign, readonly) BOOL          isPauseByUser;
/** 播发器的几种状态 */
@property (nonatomic, assign, readonly) VDPlayerState state;
/** 静音（默认为NO）*/
@property (nonatomic, assign) BOOL                    mute;
/** 当cell划出屏幕的时候停止播放（默认为NO） */
@property (nonatomic, assign) BOOL                    stopPlayWhileCellNotVisable;
/** 当cell播放视频由全屏变为小屏时候，是否回到中间位置(默认YES) */
@property (nonatomic, assign) BOOL                    cellPlayerOnCenter;
/** player在栈上，即此时push或者模态了新控制器 */
@property (nonatomic, assign) BOOL                    playerPushedOrPresented;

/**
 *  单例，用于列表cell上多个视频
 *
 *  @return vdPlayer
 */
+ (instancetype)sharedPlayerView;

/**
 * 指定播放的控制层和模型
 * 控制层传nil，默认使用vdPlayerControlView(如自定义可传自定义的控制层)
 */
- (void)playerControlView:(UIView *)controlView playerModel:(VDPlayerModel *)playerModel;

/**
 * 使用自带的控制层时候可使用此API
 */
- (void)playerModel:(VDPlayerModel *)playerModel;

/**
 *  自动播放，默认不自动播放
 */
- (void)autoPlayTheVideo;

/**
 *  重置player
 */
- (void)resetPlayer;

/**
 *  在当前页面，设置新的视频时候调用此方法
 */
- (void)resetToPlayNewVideo:(VDPlayerModel *)playerModel;

/**
 *  播放
 */
- (void)play;

/**
 * 暂停
 */
- (void)pause;
@end
