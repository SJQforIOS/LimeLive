//
//  SXTUserRegisterViewController.m
//  InKe
//
//  Created by SJQ on 2018/5/1.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTUserRegisterViewController.h"
#import "SXTTabBarViewController.h"

@interface SXTUserRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *YZMTextField;
@property (weak, nonatomic) IBOutlet UIButton *YZMBtn;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end

@implementation SXTUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册账号";
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

- (IBAction)YZMBtn:(id)sender {
    NSString *email = _account.text;
    
    [SXTLoginHandler sendActivateCode:email and:^(id obj) {
        NSLog(@"%@",obj);
        
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
}


- (IBAction)completeAction:(id)sender {
    NSString *strAccount = _account.text;
    NSString *strPassWord = _password.text;
    NSString *strYZM = _YZMTextField.text;
    if (strAccount.length == 0 || strPassWord.length == 0) {
        [self.view makeToast:@"输入不能为空！" duration:1 position:CSToastPositionCenter];
    } else if (![self isValidateEmail:strAccount]) {
        [self.view makeToast:@"请输入正确格式的邮箱！" duration:1 position:CSToastPositionCenter];
    } else {
        __weak typeof(self) weakSelf = self;
        [SXTLoginHandler resourceAccount:strAccount passwd:strPassWord activateCode:strYZM and:^(id obj) {
            //判断登陆情况
            if ([obj isEqualToString:@"0000"]) {
                //成功
                //存系统偏好设置
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:strAccount forKey:@"userName"];
                [defaults setObject:strPassWord forKey:@"userPass"];
                [weakSelf showHint:@"登录成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.view.window.rootViewController = [[SXTTabBarViewController alloc] init];
                });
            } else if ([obj isEqualToString:@"0001"]) {
                //验证码错误
                [self.view makeToast:@"验证码错误！" duration:1 position:CSToastPositionCenter];
            } else if ([obj isEqualToString:@"0002"])  {
                //注册失败
                [self.view makeToast:@"位置错误！" duration:1 position:CSToastPositionCenter];
            } else if ([obj isEqualToString:@"0003"])  {
                //账号已注册
                [self.view makeToast:@"账号已注册！" duration:1 position:CSToastPositionCenter];
            }
        } failed:^(id obj) {
            NSLog(@"%@",obj);
        }];
    }
}

//邮箱格式验证
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
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
