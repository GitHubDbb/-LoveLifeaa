//
//  MusicPlayingViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 DBBPerson. All rights reserved.
//

#import "MusicPlayingViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayingViewController ()<AVAudioPlayerDelegate>
{
    //指示条
    UISlider * _slider;
    //播放器
    AVAudioPlayer * _player;
}
@property(nonatomic,strong)NSTimer * timer;

@end

@implementation MusicPlayingViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //图片设为背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"23.jpg"]];
    //创建 队列组
    [self createUI];
    dispatch_group_t grounp = dispatch_group_create()
    ;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //请求异步方法
    dispatch_group_async(grounp, queue, ^{
        [self createAVaudioPlayer];
    });
    
    
    [self createAVaudioPlayer];
    //创建一个定时器,实时改变 slider 的 value 值
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sliderValueChage) userInfo:nil repeats:YES];
    
    //设置后台播放模式, AVAudioSession 指音频会话
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //后台保持活跃
    [session setActive:YES error:nil];
    
    //拔出耳机暂停播放,通过观察者监测
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isHasDevice:) name:AVAudioSessionRouteChangeNotification object:nil];
    

}

#pragma mark - 监听是否有耳机
-(void)isHasDevice:(NSNotification*)notification
{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            if ([_player isPlaying])
            {
                [_player pause];
                self.timer.fireDate=[NSDate distantFuture];
            }
        }
    }
}

#pragma mark - 创建音乐播放器
-(void)createAVaudioPlayer
{
    //NSURL创建 (播放本地的,暂时不用)
    //     = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:@""] error:nil];
    
    //NSData 创建
    _player = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlArray[_currentIndex]]] error:nil];
    //设置代理
    _player.delegate =self;
    //播放音量
    _player.volume = 0.5; //0-1之间
    //播放进度
    _player.currentTime = 0;
    //循环次数
    _player.numberOfLoops = -1; //负数表示无限循环播放 , 0 是一次 , 正数是几就几次
    //只读属性
    //    _player.isPlaying //是否正在播放
    //声道数
    //    _player.numberOfChannels //声道数
    //持续时间
    //    _player.duration //时间
    
    //预播放,将播放资源添加到播放器中,播放器自己分配播放队列
    [_player prepareToPlay];
    
    
}

#pragma mark -创建 UI
-(void)createUI
{
    //返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 20, 30, 30) title:nil titleColor:[UIColor whiteColor] imageName:@"iconfont-fanhui" backgroundImageName:nil target:self selector:@selector(buttonBackClick)];
    [self.view addSubview:backButton];
    
    //标题
    UILabel * title = [FactoryUI createLabelWithFrame:CGRectMake(0, 40, SCREEN_W, 30) text:self.model.title textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:22]];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    //作者
    UILabel * author = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W-100, CGRectGetMaxY(title.frame), 90, 20) text:[NSString stringWithFormat:@"演唱者:%@",self.model.artist] textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
    author.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:author];
    
    UIImageView * imageVIew = [FactoryUI createImageViewWithFrame:CGRectMake(10, CGRectGetMaxY(author.frame)+5, SCREEN_W-20, SCREEN_W-20) imageName:nil];
    //赋值
    [imageVIew sd_setImageWithURL:[NSURL URLWithString:self.model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageVIew];
    
    //指示条
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageVIew.frame)+40, SCREEN_W-20, 20)];
    //设置初始 value
    _slider.value = 0.0;
    //添加事件
    [_slider addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    //创建 按钮
    NSArray * buttonImageArray = @[@"iconfont-bofangqishangyiqu",@"iconfont-musicbofang",@"iconfont-bofangqixiayiqu"];
    for (int i=0; i<buttonImageArray.count; i++) {
        UIButton * button = [FactoryUI createButtonWithFrame:CGRectMake(70
                                                                        +i*90, _slider.frame.size.height+_slider.frame.origin.y+30, 40, 40) title:nil titleColor:nil imageName:buttonImageArray[i] backgroundImageName:nil target:self selector:@selector(playButtonClick:)];
        button.tag = i + 10;
        [self.view addSubview:button];
        
    }
}

-(void)playButtonClick:(UIButton*)button
{
    switch (button.tag - 10) {
        case 0:{
            //上一曲
            [_player stop];
            if (_currentIndex ==0) {
                _currentIndex = (int)self.urlArray.count - 1;
            }
            _currentIndex --;
            [self createAVaudioPlayer];
            [_player play];
        }
            break;
            
        case 1:{
            // 播放/暂停
            if (_player.isPlaying) {
                [button setImage:[UIImage imageNamed:@"iconfont-musicbofang"] forState:UIControlStateNormal];
                [_player pause];
                [self.timer setFireDate:[NSDate distantFuture]];
            }
            else{
                [button setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateNormal];
                [_player play];
                [self.timer setFireDate:[NSDate distantPast]];  //重启定时器
                //                [self.timer invalidate]; //销毁定时器,以后无法恢复
            }
        }
            break;
        case 2:{
            //下一曲
            [_player stop];
            if (_currentIndex == self.urlArray.count-1) {
                _currentIndex = 0;
            }
            _currentIndex++;
            [self createAVaudioPlayer];
            [_player play];
        }
            break;
        default:
            break;
    }
}
// 定时器实时监测 slider 的 value
-(void)sliderValueChage
{
    _slider.value = _player.currentTime/_player.duration;
}

//进度条
-(void)changeOption:(UISlider *)slider
{
    _player.currentTime = _player.duration * _slider.value;
}

-(void)buttonBackClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//播放器的代理方法
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        //说明 音频文件是正常播放完毕的
    }
    else{
        //音频文件虽然播放完了,但是数据解码错误
    }
}

//iOS 8 被废弃了*******************  iOS 8 之后就自动处理
//开始被中断,比如说用户 home 键返回或者突然地来电打断
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [_player pause];
}
//中断结束回到播放器继续播放
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    //继续播放
    [_player play];
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"对音频文件解码错误");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
