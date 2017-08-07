//
//  RCRecoarder.m
//  IOSProjectDemo
//
//  Created by VD on 2017/7/25.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "RCRecoarder.h"
#import <AVFoundation/AVFoundation.h>

@interface RCRecoarder ()<AVAudioRecorderDelegate>

@end

@implementation RCRecoarder
{
    AVAudioRecorder * _recoarder;
    NSString * _filePath;
    sucessBlock _block;
    
}
- (instancetype)initWithRecoardFilePath:(NSString *)path
{
    if (self=[super init]) {
        _filePath = path;
        NSError * error;
        _recoarder = [[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:path] settings:[self recoardSetings] error:&error];
        _recoarder.delegate = self;
        
    }
    return self;
}

- (NSDictionary *)recoardSetings
{
    NSDictionary *settings = @{AVFormatIDKey:@(kAudioFormatAppleIMA4),AVSampleRateKey:@44100.0f,                               AVNumberOfChannelsKey:@1,                               AVEncoderBitDepthHintKey:@16,//位深为16位
                               AVEncoderAudioQualityKey:@(AVAudioQualityMax)//声音质量
                               };
    return settings;
    
    

}


- (void)startRecoard:(sucessBlock)block
{
    _block = block;
    [_recoarder prepareToRecord];
    [_recoarder record];
    
}
- (void)stopRecoard
{
     [_recoarder stop];
}
- (void)cancelRecoard
{
    [_recoarder stop];
    [_recoarder deleteRecording];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if(_block)
    {
        _block(_filePath);
    }
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error
{
    NSLog(@"error %@",error.localizedDescription);
}
@end
