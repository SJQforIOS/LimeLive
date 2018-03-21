//
//  SXTRegisterViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/21.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTRegisterViewController.h"

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



#pragma mark - Action

- (IBAction)messageAction:(UIButton *)sender {
}


- (IBAction)nextAction:(UIButton *)sender {
}

- (void)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
