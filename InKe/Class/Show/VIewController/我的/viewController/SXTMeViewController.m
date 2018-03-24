//
//  SXTMeViewController.m
//  InKe
//
//  Created by sjq on 17/8/28.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "SXTMeViewController.h"
#import "SXTHeadView.h"
#import "SXTMeSetTableViewCell.h"
#import "SXTEditUserViewController.h"
#import "SXTSetViewController.h"
#import "SXTNoLoginHeadView.h"
#import "SXTLoginViewController.h"

@interface SXTMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) SXTHeadView *headView;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) SXTNoLoginHeadView *headLoginView;
@property (nonatomic, assign) BOOL isLogin;

@end

@implementation SXTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的";
    [self setupData];
    [self initUI];
    [self setupActionBlock];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWithType:FNNavationBarType_Green];
}

- (void)setupData
{
    _datasource = @[@[@{ @"icon":@"ic_my_readingrecord",@"title":@"观看记录"}],@[@{ @"icon":@"ic_my_readingrecord",@"title":@"设置"}]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *usertName = [defaults objectForKey:@"userName"];
    //NSString *userPass = [defaults objectForKey:@"userPass"];
    _isLogin = usertName.length != 0;
}

- (void)initUI
{
    _headView = [[SXTHeadView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
    _headView.backgroundColor = [UIColor whiteColor];
    
    _headLoginView = [[SXTNoLoginHeadView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 90)];
    _headLoginView.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStyleGrouped)];
    [self.view addSubview:_tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGB(244, 244, 244);
    
    if (_isLogin) {
        _tableview.tableHeaderView = _headView;
    } else {
        _tableview.tableHeaderView = _headLoginView;
    }
    
    [_tableview registerNib:[UINib nibWithNibName:@"SXTMeSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTMeSetTableViewCell"];
}

- (void)setupActionBlock
{
    __weak typeof(self) weakSelf = self;
    _headView.editUsrBlock = ^{
        SXTEditUserViewController *editVC = [[SXTEditUserViewController alloc] init];
//        weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        [weakSelf.navigationController pushViewController:editVC animated:YES];
    };
    
    _headView.focusUserBlock = ^{
        
    };
    
    _headView.fensiUsrBlock = ^{
        
    };
    
    _headLoginView.goLoginBlock = ^{
        SXTLoginViewController *login = [[SXTLoginViewController alloc] init];
        [weakSelf.navigationController pushViewController:login animated:YES];
    };
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_datasource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXTMeSetTableViewCell *cell = (SXTMeSetTableViewCell *)[self.tableview dequeueReusableCellWithIdentifier:@"SXTMeSetTableViewCell"];
    if (!cell) {
        cell = [[SXTMeSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SXTMeSetTableViewCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *data = _datasource[indexPath.section][indexPath.row];
    
    cell.iconImageView.image = [UIImage imageNamed:[data objectForKey:@"icon"]];
    cell.titleLabel.text = [data objectForKey:@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    return myView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* myView = [[UIView alloc] init];
    return myView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_isLogin == NO) {
        [self.view makeToast:@"请先登录" duration:1 position:CSToastPositionCenter];
        return;
    } else {
        if (indexPath.section == 1 && indexPath.row == 0) {
            //跳转到设置
            SXTSetViewController *setVC = [[SXTSetViewController alloc] init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
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
