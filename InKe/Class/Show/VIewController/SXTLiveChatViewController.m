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
#import "SXTLiveChatTableViewCell.h"
#import "SXTCommentModel.h"

@interface SXTLiveChatViewController()<UITableViewDelegate,UITableViewDataSource,XHInputViewDelagete>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *yinPiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLB;
@property (weak, nonatomic) IBOutlet UIImageView *userCommentImageView;         //评论按钮
@property (nonatomic, strong) XHInputView *commentInputView;               //评论键盘

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIButton *focusBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation SXTLiveChatViewController

- (XHInputView *)commentInputView {
    if (!_commentInputView) {
        _commentInputView = [self inputViewWithStyle:InputViewStyleDefault];
        _commentInputView.delegate = self;
        [self.view addSubview:_commentInputView];
    }
    return _commentInputView;
}

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
    [self setupData];
    [self setupUIView];
    [self setupTableView];
}

- (void)setupData {
    _datasource = [[NSMutableArray alloc] init];
    
    SXTCommentModel *model11 = [[SXTCommentModel alloc] init];
    model11.userName = @"系统消息";
    model11.userComment = @"青柠提倡绿色直播，对于封面和直播内容违规的主播官方将给予严重处罚，严重私下货币交易，如遇纷争，概不负责";
    [_datasource addObject:model11];
}

- (void)setupTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"SXTLiveChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTLiveChatTableViewCell"];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(SCREEN_WIDTH/3));
        make.width.equalTo(@(SCREEN_WIDTH*3/4));
    }];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datasource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
    
    UITapGestureRecognizer *imageViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentAction)];
    // 2. 将点击事件添加到label上
    [_userCommentImageView addGestureRecognizer:imageViewTapGestureRecognizer];
    _userCommentImageView.userInteractionEnabled = YES; // 可以理解为设置imageview可被点击
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SXTLiveChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SXTLiveChatTableViewCell"];
    cell.commentModel = _datasource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SXTCommentModel *comment = _datasource[indexPath.row];
    CGFloat height = [SXTLiveChatTableViewCell cellHeightWithMsg:[NSString stringWithFormat:@"%@%@",comment.userName,comment.userComment]];
    return height;
}

#pragma mark - Action

- (void)commentAction {
    //点击评论按钮
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if (account.length > 0) {
        [self.commentInputView show];
    } else {
        [self.view makeToast:@"请登录！" duration:1 position:CSToastPositionCenter];
    }
    [self.commentInputView show];
}

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

#pragma mark - XHInputViewDelagete
/**
 XHInputView 将要显示
 */
-(void)xhInputViewWillShow:(XHInputView *)inputView {
}

/**
 XHInputView 将要影藏
 */
-(void)xhInputViewWillHide:(XHInputView *)inputView {
   
}

-(XHInputView *)inputViewWithStyle:(InputViewStyle)style{
    XHInputView *inputView = [[XHInputView alloc] initWithStyle:style];
    //设置最大输入字数
    inputView.maxCount = 50;
    //输入框颜色
    inputView.textViewBackgroundColor = [UIColor groupTableViewBackgroundColor];
    //占位符
    inputView.placeholder = @"发点有爱评论吧！";
    inputView.sendButtonBackgroundColor = RGB(0, 216, 201);
    inputView.sendButtonCornerRadius = 2.0;
    return inputView;
}

- (void)clickCompleteBtn:(XHInputView *)inputView andStr:(NSString *)str {
    [self.commentInputView hide];//隐藏输入框
    SXTCommentModel *model = [[SXTCommentModel alloc] init];
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if (account.length > 0) {
        model.userName = account;
    } else {
        model.userName = @"我是大魔王啊我看看";
    }
    model.userComment = str;
    [_datasource addObject:model];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datasource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
