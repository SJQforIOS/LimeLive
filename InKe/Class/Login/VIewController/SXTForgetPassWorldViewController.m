//
//  SXTForgetPassWorldViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/24.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTForgetPassWorldViewController.h"
#import "SXTSetPassWorldViewController.h"

@interface SXTForgetPassWorldViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *YZMTextFile;
@property (weak, nonatomic) IBOutlet UIButton *YZMButton;
@property (weak, nonatomic) IBOutlet UIButton *nextSetPassButton;


@end

@implementation SXTForgetPassWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    [self setupNav];
    [self setupUIView];
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

- (void)onBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUIView {
    self.nameLabel.text = [NSString stringWithFormat:@"将登陆如下账号：\n%@",self.account];
}


#pragma mark - Action

//获取验证码
- (IBAction)YZMAction:(id)sender {
    NSString *email = _YZMTextFile.text;
    __weak typeof(self) weakSelf = self;
    [SXTLoginHandler sendActivateCode:email and:^(id obj) {
        weakSelf.YZMButton.alpha = 0.5;
        weakSelf.YZMButton.enabled = NO;
        [weakSelf.view makeToast:@"验证码已发送到你的邮箱" duration:1 position:CSToastPositionCenter];
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
}

//下一步按钮
- (IBAction)nextSetPassAction:(id)sender {
    //验证判断
    if (_YZMTextFile.text.length == 0) {
        [self.view makeToast:@"输入不能为空！" duration:1 position:CSToastPositionCenter];
    } else {
        //跳转页面
        SXTSetPassWorldViewController *setPassVC = [[SXTSetPassWorldViewController alloc] init];
        setPassVC.account = self.account;
        setPassVC.YZM = _YZMTextFile.text;
        [self.navigationController pushViewController:setPassVC animated:YES];
    } 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
