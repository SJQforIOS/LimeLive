//
//  SXTLiveChatViewController.m
//  bjsxt-inke
//
//  Created by 大欢 on 16/9/5.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTLiveChatViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface SXTLiveChatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *yinPiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLB;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIButton *focusBtn;


@end

@implementation SXTLiveChatViewController

//- (void)setLive:(SXTLive *)live {
//    
//    _live = live;
//    
//    [self.iconView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏nbv
    [self setNavigationBarWithType:FNNavationBarType_clear];
}


- (void)setMiaoboModel:(SXTMiaoBoModel *)miaoboModel
{
    _miaoboModel = miaoboModel;
    [self.iconView downloadImage:[NSString stringWithFormat:@"%@",miaoboModel.smallpic] placeholder:@"default_room"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.iconView.layer.cornerRadius = 15;
    self.iconView.layer.masksToBounds = YES;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        self.peopleCountLB.text = [NSString stringWithFormat:@"%d",[self getRandomNumber:1 to:10000]];
    } repeats:YES];
    
    [self initTimer];
    [self setupUIView];
}

- (void)setupUIView {
    _focusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:_focusBtn];
    _focusBtn.frame = CGRectMake(105, 34, 48, 24);
    _focusBtn.backgroundColor = UIColorFromRGB(0x2EDED0);
    _focusBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _focusBtn.layer.cornerRadius = 10;
    [_focusBtn setTitle:@"关注" forState:(UIControlStateNormal)];
    [_focusBtn setTitle:@"已关注" forState:(UIControlStateSelected)];
    [_focusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_focusBtn addTarget:self action:@selector(focusActionss:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)initTimer {
    
    //初始化心形动画
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        
        [self showMoreLoveAnimateFromView:self.shareButton addToView:self.view];
    });
    dispatch_resume(self.timer);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self showMoreLoveAnimateFromView:self.shareButton addToView:self.view];
}

- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    imageView.layer.position = position;
    NSArray *imgArr = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSInteger img = arc4random()%6;
    imageView.image = [UIImage imageNamed:imgArr[img]];
    [addToView addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

#pragma mark - Action

- (IBAction)shareAction:(id)sender {
    NSLog(@"点击了分享");
    
    //1、创建分享参数
    NSArray* imageArray = @[_miaoboModel.bigpic];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        NSString *shareBody = [NSString stringWithFormat:@"你关注的%@ @了你，想和你聊会天！%@",_miaoboModel.myname,_miaoboModel.flv];
        [shareParams SSDKSetupShareParamsByText:shareBody
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    }
}

- (void)focusActionss:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.view makeToast:@"已关注" duration:1 position:CSToastPositionCenter];
    } else {
        [self.view makeToast:@"已取消关注" duration:1 position:CSToastPositionCenter];
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
