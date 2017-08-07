//
//  RCAudioPlayer.m
//  IOSProjectDemo
//
//  Created by VD on 2017/7/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "RCAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface RCAudioPlayer ()<AVAudioPlayerDelegate>

@end

@implementation RCAudioPlayer
{
    AVAudioPlayer * _audioPlayer;
    
}
+ (instancetype)shareManager
{
    static dispatch_once_t token;
    static RCAudioPlayer * palyer;
    _dispatch_once(&token, ^{
        palyer = [RCAudioPlayer new];
    });
    return palyer;
}
- (void)startPlayWithUrl:(NSString *)url
{
    [_audioPlayer stop];
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:url] error:nil];
    _audioPlayer.delegate = self;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    
}
- (void)stopPaly
{
    [_audioPlayer stop];
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    
}
@end
