//
//  ViewController.m
//  AvAudioDemo
//
//  Created by Donald on 17/5/9.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //IOS 音频播放分为音效播放 音乐播放 数据必须是PCM或者IMA4格式 时间少于30秒
    CFURLRef url = CFURLCreateWithString(kCFAllocatorDefault, CFSTR(""),NULL);
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID(url, &soundId);
    AudioServicesPlayAlertSound(soundId);
    CFRelease(url);
    
    
    //音乐播放 播放多组音乐通过创建多个ACAudioPlayer实现的
    AVAudioPlayer * player= [[AVAudioPlayer alloc]initWithContentsOfURL:nil error:nil];
    //实现后台播放1.设置后台运行模式：在plist文件中添加Required background modes，并且设置item 0=App plays audio or streams audio/video using AirPlay（其实可以直接通过Xcode在Project Targets-Capabilities-Background Modes中设置）
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    //开启远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
    //添加通知，拔出耳机后暂停播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    //录音
    //    AVAudioRecorder属性 说明
    /*
    @property(readonly, getter=isRecording) BOOL recording; 是否正在录音，只读
    @property(readonly) NSURL url 录音文件地址，只读
    @property(readonly) NSDictionary settings 录音文件设置，只读
    @property(readonly) NSTimeInterval currentTime 录音时长，只读，注意仅仅在录音状态可用
    @property(readonly) NSTimeInterval deviceCurrentTime 输入设置的时间长度，只读，注意此属性一直可访问
    @property(getter=isMeteringEnabled) BOOL meteringEnabled; 是否启用录音测量，如果启用录音测量可以获得录音分贝等数据信息
    @property(nonatomic, copy) NSArray *channelAssignments 当前录音的通道
    对象方法 说明
    
    (instancetype)initWithURL:(NSURL )url settings:(NSDictionary )settings error:(NSError **)outError 录音机对象初始化方法，注意其中的url必须是本地文件url，settings是录音格式、编码等设置
    (BOOL)prepareToRecord 准备录音，主要用于创建缓冲区，如果不手动调用，在调用record录音时也会自动调用
    (BOOL)record 开始录音
    (BOOL)recordAtTime:(NSTimeInterval)time 在指定的时间开始录音，一般用于录音暂停再恢复录音
    (BOOL)recordForDuration:(NSTimeInterval) duration 按指定的时长开始录音
    (BOOL)recordAtTime:(NSTimeInterval)time forDuration:(NSTimeInterval) duration 在指定的时间开始录音，并指定录音时长
    (void)pause; 暂停录音
    (void)stop; 停止录音
    (BOOL)deleteRecording; 删除录音，注意要删除录音此时录音机必须处于停止状态
    (void)updateMeters; 更新测量数据，注意只有meteringEnabled为YES此方法才可用
    (float)peakPowerForChannel:(NSUInteger)channelNumber; 指定通道的测量峰值，注意只有调用完updateMeters才有值
    (float)averagePowerForChannel:(NSUInteger)channelNumber 指定通道的测量平均值，注意只有调用完updateMeters才有值
    代理方法 说明
    (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag 完成录音
    (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder )recorder error:(NSError )error 录音编码发生错误
    AVAudioRecorder很多属性和方法跟AVAudioPlayer都是类似的,但是它的创建有所不同，在创建录音机时除了指定路径外还必须指定录音设置信息，因为录音机必须知道录音文件的格式、采样率、通道数、每个采样点的位数等信息，但是也并不是所有的信息都必须设置，通常只需要几个常用设置。关于录音设置详见帮助文档中的“AV Foundation Audio Settings Constants”。
     
     -(NSDictionary )getAudioSetting{
     NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
     //设置录音格式
     [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
     //设置录音采样率，8000是电话采样率，对于一般录音已经够了
     [dicM setObject:@(8000) forKey:AVSampleRateKey];
     //设置通道,这里采用单声道
     [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
     //每个采样点位数,分为8、16、24、32
     [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
     //是否使用浮点数采样
     [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
     //....其他设置等
     return dicM;
     }
     -(void)audioPowerChange{
     [self.audioRecorder updateMeters];//更新测量值
     float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
     CGFloat progress=(1.0/160.0)(power+160.0);
     [self.audioPower setProgress:progress];
     }
     
     那么在iOS中如何播放网络流媒体呢？就是使用AudioToolbox框架中的音频队列服务Audio Queue Services。
     一个音频服务队列Audio Queue有三部分组成：
     
     三个缓冲器Buffers:每个缓冲器都是一个存储音频数据的临时仓库。
     
     一个缓冲队列Buffer Queue:一个包含音频缓冲器的有序队列。
     
     一个回调Callback:一个自定义的队列回调函数。
     声音通过输入设备进入缓冲队列中，首先填充第一个缓冲器；当第一个缓冲器填充满之后自动填充下一个缓冲器，同时会调用回调函数；在回调函数中需要将缓冲器中的音频数据写入磁盘，同时将缓冲器放回到缓冲队列中以便重用。下面是Apple官方关于音频队列服务的流程示意图：
     
     -(FSAudioStream )audioStream{
     if (!_audioStream) {
     NSURL *url=[self getNetworkUrl];
     //创建FSAudioStream对象
     _audioStream=[[FSAudioStream alloc]initWithUrl:url];
     _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
     NSLog(@"播放过程中发生错误，错误信息：%@",description);
     };
     _audioStream.onCompletion=^(){
     NSLog(@"播放完成!");
     };
     [_audioStream setVolume:0.5];//设置声音
     }
     return _audioStream;
     }
     
     MPMediaPlayerController 播放视频
     
     */
    
//    AVAudioRecorder recoard = [[AVAudioRecorder alloc]init];
    

    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)routeChange:(NSNotification *)notification{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            [self pause];
        }
    }
}
//MediaPlayer.frameowork中有一个MPMusicPlayerController用于播放音乐库中的音乐。

- (void)pause{}
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
