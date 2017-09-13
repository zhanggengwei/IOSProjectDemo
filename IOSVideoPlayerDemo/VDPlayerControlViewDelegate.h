//
//  VDPlayerControlViewDelegate.h
//  IOSProjectDemo
//
//  Created by VD on 2017/9/13.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VDPlayerControlViewDelegate <NSObject>
@optional
/** 返回按钮事件 */
- (void)vd_controlView:(UIView *)controlView backAction:(UIButton *)sender;
/** cell播放中小屏状态 关闭按钮事件 */
- (void)vd_controlView:(UIView *)controlView closeAction:(UIButton *)sender;
/** 播放按钮事件 */
- (void)vd_controlView:(UIView *)controlView playAction:(UIButton *)sender;
/** 全屏按钮事件 */
- (void)vd_controlView:(UIView *)controlView fullScreenAction:(UIButton *)sender;
/** 锁定屏幕方向按钮时间 */
- (void)vd_controlView:(UIView *)controlView lockScreenAction:(UIButton *)sender;
/** 重播按钮事件 */
- (void)vd_controlView:(UIView *)controlView repeatPlayAction:(UIButton *)sender;
/** 中间播放按钮事件 */
- (void)vd_controlView:(UIView *)controlView cneterPlayAction:(UIButton *)sender;
/** 加载失败按钮事件 */
- (void)vd_controlView:(UIView *)controlView failAction:(UIButton *)sender;
/** 下载按钮事件 */
- (void)vd_controlView:(UIView *)controlView downloadVideoAction:(UIButton *)sender;
/** 切换分辨率按钮事件 */
- (void)vd_controlView:(UIView *)controlView resolutionAction:(UIButton *)sender;
/** slider的点击事件（点击slider控制进度） */
- (void)vd_controlView:(UIView *)controlView progressSliderTap:(CGFloat)value;
/** 开始触摸slider */
- (void)vd_controlView:(UIView *)controlView progressSliderTouchBegan:(UISlider *)slider;
/** slider触摸中 */
- (void)vd_controlView:(UIView *)controlView progressSliderValueChanged:(UISlider *)slider;
/** slider触摸结束 */
- (void)vd_controlView:(UIView *)controlView progressSliderTouchEnded:(UISlider *)slider;
/** 控制层即将显示 */
- (void)vd_controlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen;
/** 控制层即将隐藏 */
- (void)vd_controlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen;
@end
