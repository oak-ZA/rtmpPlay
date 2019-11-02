//
//  ViewController.m
//  ZARTMPlayer
//
//  Created by 张奥 on 2019/11/2.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ViewController.h"
#import <PLPlayerKit/PLPlayerKit.h>
@interface ViewController ()<PLPlayerDelegate>
@property (nonatomic, strong)PLPlayer *player;
@property (nonatomic, strong)NSURL *URL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化 PLPlayerOption 对象
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    // 更改需要修改的 option 属性键所对应的值
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [option setOptionValue:@2000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [option setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [option setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [option setOptionValue:@(kPLLogInfo) forKey:PLPlayerOptionKeyLogLevel];
    
    // 初始化 PLPlayer
    self.URL = [NSURL URLWithString:@"rtmp://vod.vchat1.com/live/100?auth_key=1572753265-0-0-3a536e5cc18e0950195d8101794bb9ba"];
    self.player = [PLPlayer playerWithURL:self.URL option:option];
    // 设定代理 (optional)
    self.player.delegate = self;
    //获取视频输出视图并添加为到当前 UIView 对象的 Subview
    [self.view addSubview:self.player.playerView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 250, 60, 60);
    [button setTitle:@"开始" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 8.f;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(80, 250, 60, 60);
    [button2 setTitle:@"停止" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    button2.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.layer.cornerRadius = 8.f;
    button2.layer.masksToBounds = YES;
    [button2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(150, 250, 60, 60);
    [button3 setTitle:@"暂停" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor redColor];
    button3.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button3.layer.cornerRadius = 8.f;
    button3.layer.masksToBounds = YES;
    [button3 addTarget:self action:@selector(clickButton3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(220, 250, 60, 60);
    [button4 setTitle:@"继续播放" forState:UIControlStateNormal];
    button4.backgroundColor = [UIColor redColor];
    button4.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button4.layer.cornerRadius = 8.f;
    button4.layer.masksToBounds = YES;
    [button4 addTarget:self action:@selector(clickButton4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
}

-(void)clickButton{
    [self.player play];
}

-(void)clickButton2{
    [self.player stop];
}

-(void)clickButton3{
    [self.player pause];
}

-(void)clickButton4{
    [self.player resume];
}


// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
    // 开始播放，当连接成功后，将收到第一个 PLPlayerStatusCaching 状态
    // 第一帧渲染后，将收到第一个 PLPlayerStatusPlaying 状态
    // 播放过程中出现卡顿时，将收到 PLPlayerStatusCaching 状态
    // 卡顿结束后，将收到 PLPlayerStatusPlaying 状态
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误，停止播放时，会回调这个方法
}

- (void)player:(nonnull PLPlayer *)player codecError:(nonnull NSError *)error {
    // 当解码器发生错误时，会回调这个方法
    // 当 videotoolbox 硬解初始化或解码出错时
    // error.code 值为 PLPlayerErrorHWCodecInitFailed/PLPlayerErrorHWDecodeFailed
    // 播发器也将自动切换成软解，继续播放
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
