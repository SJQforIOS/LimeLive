//
//  SXTRateViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/24.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTRateViewController.h"

@interface SXTRateViewController ()<UIScrollViewDelegate>

@property NSInteger PageHeight;
@property NSInteger PageWidth;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation SXTRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户协议";
    [self setupUIView];
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWithType:FNNavationBarType_Green];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupNav {
    UIButton *leftButton = [FNButton commonWhiteBackButton];
    [leftButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setupUIView {
    //创建uiscrollview
    self.PageHeight = self.view.bounds.size.height;
    self.PageWidth = self.view.bounds.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.PageWidth, self.PageHeight)];
    //标题
    UILabel *zuozheHome = [[UILabel alloc] initWithFrame:CGRectMake(15, 64, 100, 30)];
    zuozheHome.text = @"用户协议";
    zuozheHome.textColor = [UIColor blackColor];
    zuozheHome.font = [UIFont systemFontOfSize:21];
    zuozheHome.textAlignment = NSTextAlignmentLeft;
    
    //重要须知
    UILabel *zuozheHome2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 125, 100, 30)];
    zuozheHome2.text = @"重要须知";
    
    zuozheHome2.textColor = [UIColor blackColor];
    zuozheHome2.font = [UIFont systemFontOfSize:15];
    zuozheHome2.textAlignment = NSTextAlignmentLeft;
    
    //协议内容
    UITextView *textListHome = [[UITextView alloc] initWithFrame:CGRectMake(13, 155, self.PageWidth-30, self.PageHeight*2)];
    textListHome.editable=NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSString *textlabel = @"青柠直播平台 在此特别提醒用户认真阅读、充分理解本《软件许可及服务协议》（下称《协议》）──用户应认真阅读、充分理解本《协议》中各条款，包括免除或者限制 待着 责任的免责条款，以及对用户的权利限制条款。请您审慎阅读后，选择接受或不接受本《协议》（未成年人应在法定监护人陪同下阅读）。除非您接受本《协议》所有条款，否则您无权下载、安装或使用本软件及其相关服务。您的下载、安装、使用、帐号获取和登录等行为将被视为对本《协议》的接受，并表示您同意受本《协议》各项条款的约束。\n\n 本《协议》是您（下称「用户」）与青柠直播平台团队（及其运营合作单位（下称「合作单位」）之间关于用户下载、安装、使用、复制 待着 出品的阅读软件「趣享」（包括但不限于移动电话、平板电脑（tablet）等各种无线手持终端版本等，下称「软件」）；注册、使用、管理 青柠直播平台帐号；以及使用相关服务所订立的协议。本《协议》描述 待着 与用户之间关于「软件」许可使用及服务相关方面的权利义务。「用户」是指通过待着提供的获取软件授权和帐号注册的途径获得软件产品及授权许可以及使用 青柠直播平台团队 相关服务的个人或组织。本《协议》可由 青柠直播平台团队 随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不另行通知。用户可重新下载安装本软件或移步 趣享网站 查阅最新版协议条款。在 青柠直播平台团队 修改《协议》条款后，若用户不接受修改后的条款，请立即停止使用趣享提供的软件和服务，用户继续使用青柠直播平台提供的软件和服务将被视为已接受了修改后的协议。\n\n 青柠直播平台团队版权所有,保留一切解释权利。";
    textListHome.attributedText = [[NSAttributedString alloc] initWithString:textlabel attributes:attributes];
    
    
    [self.scrollView addSubview:zuozheHome];
    [self.scrollView addSubview:zuozheHome2];
    [self.scrollView addSubview:textListHome];
    
    
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(self.PageWidth,self.PageHeight*2-200);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    //加载服务
    self.scrollView.delegate = self;
}

- (void)onBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
