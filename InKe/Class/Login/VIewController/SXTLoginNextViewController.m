//
//  SXTLoginNextViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/24.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTLoginNextViewController.h"
#import "SXTTabBarViewController.h"
#import "SXTForgetPassWorldViewController.h"

@interface SXTLoginNextViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation SXTLoginNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"输入密码";
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
    self.nameLable.text = [NSString stringWithFormat:@"将登陆如下账号：\n%@",self.account];
}

#pragma mark - Action

- (IBAction)forgetPassWorldAction:(id)sender {
    SXTForgetPassWorldViewController *forgetVC = [[SXTForgetPassWorldViewController alloc] init];
    forgetVC.account = self.account;
    [self.navigationController pushViewController:forgetVC animated:YES];
}


- (IBAction)loginAction:(id)sender {
    
    if (self.passwordLabel.text.length == 0) {
        [self.view makeToast:@"请输入密码！" duration:1 position:CSToastPositionCenter];
    } else {
        __weak typeof(self) weakSelf = self;
        //存系统偏好设置
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.account forKey:@"userName"];
        [defaults setObject:self.passwordLabel.text forKey:@"userPass"];
        [weakSelf showHint:@"登录成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
        });
        //登陆接口验证
//        [SXTLoginHandler loginAccount:self.account passwd:self.passwordLabel.text and:^(id obj) {
//            //判断登陆情况
//            if ([obj isEqualToString:@"0000"]) {
//                //成功
//                //存系统偏好设置
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                [defaults setObject:self.account forKey:@"userName"];
//                [defaults setObject:self.passwordLabel.text forKey:@"userPass"];
//                [weakSelf showHint:@"登录成功"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    weakSelf.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
//                });
//            } else if ([obj isEqualToString:@"0001"]) {
//                //用户不存在
//                [self.view makeToast:@"用户不存在！" duration:1 position:CSToastPositionCenter];
//            } else if ([obj isEqualToString:@"0002"])  {
//                //密码错误
//                [self.view makeToast:@"密码错误！" duration:1 position:CSToastPositionCenter];
//            }
//        } failed:^(id obj) {
//            NSLog(@"%@",obj);
//        }];
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
