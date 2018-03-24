//
//  SXTRegisterViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/21.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTRegisterViewController.h"
#import "SXTRateViewController.h"
#import "SXTLoginNextViewController.h"

@interface SXTRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextFile;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation SXTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登陆";
    [self setupNav];
    [self setupTextFile];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWithType:FNNavationBarType_Green];
}

- (void)setupNav {
    UIButton *leftButton = [FNButton commonWhiteBackButton];
    [leftButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setupTextFile {
    [_accountTextFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark - Action

- (IBAction)messageAction:(UIButton *)sender {
    SXTRateViewController *rateVC = [[SXTRateViewController alloc] init];
    [self.navigationController pushViewController:rateVC animated:YES];
}


- (IBAction)nextAction:(UIButton *)sender {
    
    SXTLoginNextViewController *loginNext = [[SXTLoginNextViewController alloc] init];
    loginNext.account = self.accountTextFile.text;
    [self.navigationController pushViewController:loginNext animated:YES];
    
    NSString *uAccount = self.accountTextFile.text;
    if (uAccount.length == 0) {
        [self.view makeToast:@"输入不能为空！" duration:1 position:CSToastPositionCenter];
    } else if (![self isValidateEmail:uAccount]) {
        [self.view makeToast:@"请输入正确格式的邮箱！" duration:1 position:CSToastPositionCenter];
    } else {
        SXTLoginNextViewController *loginNext = [[SXTLoginNextViewController alloc] init];
        loginNext.account = uAccount;
        [self.navigationController pushViewController:loginNext animated:YES];
    }
}

- (void)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
   
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
