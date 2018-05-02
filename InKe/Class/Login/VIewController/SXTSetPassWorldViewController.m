//
//  SXTSetPassWorldViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/24.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTSetPassWorldViewController.h"
#import "SXTTabBarViewController.h"

@interface SXTSetPassWorldViewController ()

@property (weak, nonatomic) IBOutlet UITextField *uPassworldLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end

@implementation SXTSetPassWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置密码";
    [self setupNav];
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

- (IBAction)nextAction:(id)sender {
    if (self.uPassworldLabel.text.length == 0) {
        [self.view makeToast:@"密码不能为空！" duration:1 position:CSToastPositionCenter];
    } else {
        //接口验证
        __weak typeof(self) weakSelf = self;
        [SXTLoginHandler fogetPasswdWithAccount:self.account passwd:self.uPassworldLabel.text activateCode:self.YZM and:^(id obj) {
            //直接登陆
            [weakSelf showHint:@"登录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
            });
        } failed:^(id obj) {
            NSLog(@"%@",obj);
        }];
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
