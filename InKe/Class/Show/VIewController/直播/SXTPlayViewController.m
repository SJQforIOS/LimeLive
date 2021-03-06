//
//  SXTPlayViewController.m
//  InKe
//
//  Created by sjq on 17/9/12.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTPlayViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "SXTLiveChatViewController.h"
#import "AppDelegate.h"

@interface SXTPlayViewController ()

@property(atomic, retain) id<IJKMediaPlayback> player;
@property (nonatomic, strong) UIImageView * blurImageView;
@property (nonatomic, strong) UIButton * closeBtn;//关闭按钮
@property (nonatomic, strong) SXTLiveChatViewController * liveChatVC;

@end

@implementation SXTPlayViewController

- (SXTLiveChatViewController *)liveChatVC {
    if (!_liveChatVC) {
        _liveChatVC = [[SXTLiveChatViewController alloc] init];
    }
    return _liveChatVC;
}

- (UIButton *)closeBtn {
    
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - _closeBtn.width - 10, SCREEN_HEIGHT - _closeBtn.height - 10, _closeBtn.width, _closeBtn.height);
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)closeAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏nbv
    [self setNavigationBarWithType:FNNavationBarType_clear];
    //注册通知
    [self installMovieNotificationObservers];
    //自动播放
    [self.player prepareToPlay];
    
    UIWindow * w = [[UIApplication sharedApplication].delegate window];
    [w addSubview:self.closeBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    //关闭直播
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    [self.closeBtn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPlayer];
    [self initUI];//添加毛玻璃效果
    [self addChildVC];
}

- (void)addChildVC {
    [self addChildViewController:self.liveChatVC];
    [self.view addSubview:self.liveChatVC.view];
    [self.liveChatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.liveChatVC.miaoboModel = self.miaoBoModel;
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    
    self.blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.blurImageView.userInteractionEnabled = YES;
    [self.blurImageView downloadImage:[NSString stringWithFormat:@"%@",self.miaoBoModel.bigpic] placeholder:@"default_room"];
    [self.view addSubview:self.blurImageView];
    
    //创建毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建毛玻璃视图
    UIVisualEffectView * ve = [[UIVisualEffectView alloc] initWithEffect:blur];
    ve.frame = self.blurImageView.bounds;
    //毛玻璃视图加入图片view上
    [self.blurImageView addSubview:ve];
    [self.view addSubview:self.closeBtn];
}

- (void)initPlayer
{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.miaoBoModel.flv] withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
}

#pragma mark Install Movie Notifications

-(void)installMovieNotificationObservers
{
    //网络环境监听,监听缓冲
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    //监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    //监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,未知
    //    MPMovieLoadStatePlayable       = 1 << 0,缓冲结束,可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES缓冲结束自动播放
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
    
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,直播结束
    //    MPMovieFinishReasonPlaybackError,直播错误
    //    MPMovieFinishReasonUserExited.用户退出
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
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
