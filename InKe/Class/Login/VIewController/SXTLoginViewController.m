//
//  SXTLoginViewController.m
//  InKe
//
//  Created by sjq on 17/9/14.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTLoginViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "SXTMainViewController.h"
#import "SXTTabBarViewController.h"
#import "SXTRegisterViewController.h"
#import "SXTBaseNavViewController.h"
#import "SXTUserRegisterViewController.h"

@interface SXTLoginViewController ()

/** player */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@property (nonatomic, weak) UIButton *quickBtn;

@end

@implementation SXTLoginViewController

- (IJKFFMoviePlayerController *)player
{
    if (!_player) {
        // 随机播放一组视频
        NSString *path = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        // 设计player
        player.view.frame = self.view.bounds;
        // 填充fill
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        [self.view addSubview:player.view];
        [self.view sendSubviewToBack:player.view];
        // 设置自动播放
        player.shouldAutoplay = NO;
        // 准备播放
        [player prepareToPlay];
        
        _player = player;
    }
    return _player;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //隐藏nbv
    [self setNavigationBarWithType:FNNavationBarType_clear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setup];
}

- (void)setup
{
    [self initObserver];
    [self initUI];
    [self.player prepareToPlay];
}

- (void)initUI
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.equalTo(@150);
    }];
    
    UILabel *labelChange = [[UILabel alloc] init];
    labelChange.text = @"选择登录方式";
    labelChange.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    labelChange.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:labelChange];
    [labelChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@74);
        make.height.equalTo(@15);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [bottomView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(12);
        make.left.equalTo(bottomView.mas_left);
        make.right.equalTo(labelChange.mas_left).offset(-5);
        make.height.equalTo(@1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [bottomView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(12);
        make.left.equalTo(labelChange.mas_right).offset(5);
        make.right.equalTo(bottomView.mas_right);
        make.height.equalTo(@1);
    }];

    UIButton *xinlangLogBtn = [[UIButton alloc] init];
    xinlangLogBtn.tag = 1;
    [xinlangLogBtn setImage:[UIImage imageNamed:@"login_ico_weibo"] forState:UIControlStateNormal];
    [bottomView addSubview:xinlangLogBtn];
    [xinlangLogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    [xinlangLogBtn setTarget:self action:@selector(changTypeLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *weixinLogBtn = [[UIButton alloc] init];
    weixinLogBtn.tag = 2;
    [weixinLogBtn setImage:[UIImage imageNamed:@"login_ico_wechat"] forState:UIControlStateNormal];
    [bottomView addSubview:weixinLogBtn];
    [weixinLogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(xinlangLogBtn.mas_right).offset(25);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    [weixinLogBtn setTarget:self action:@selector(changTypeLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *phoneLogBtn = [[UIButton alloc] init];
    phoneLogBtn.tag = 3;
    [phoneLogBtn setImage:[UIImage imageNamed:@"login_ico_mobile"] forState:UIControlStateNormal];
    [bottomView addSubview:phoneLogBtn];
    [phoneLogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(weixinLogBtn.mas_right).offset(25);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    [phoneLogBtn setTarget:self action:@selector(changTypeLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *QQLogBtn = [[UIButton alloc] init];
    QQLogBtn.tag = 4;
    [QQLogBtn setImage:[UIImage imageNamed:@"login_ico_qq"] forState:UIControlStateNormal];
    [bottomView addSubview:QQLogBtn];
    [QQLogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    [QQLogBtn setTarget:self action:@selector(changTypeLoginAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changTypeLoginAction:(UIButton *)sender
{
    if (sender.tag == 3) {
        SXTRegisterViewController *registerVC = [[SXTRegisterViewController alloc] init];
        SXTBaseNavViewController *regisNav = [[SXTBaseNavViewController alloc] initWithRootViewController:registerVC];
        [self presentViewController:regisNav animated:YES completion:nil];
    }
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.quickBtn.hidden = NO;
            });
        }
    }
}

- (void)didFinish
{
    // 播放完之后, 继续重播
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
