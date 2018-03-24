//
//  SXTSetViewController.m
//  InKe
//
//  Created by SJQ on 2018/3/21.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTSetViewController.h"
#import "SXTSetTableViewCell.h"
#import "SXTSetLogoffTableViewCell.h"
#import "SXTLoginViewController.h"

@interface SXTSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, assign) NSInteger cacheNum;

@end

@implementation SXTSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self setupNav];
    [self setupData];
    [self setupTableView];
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

- (void)setupData
{
    _datasource = @[@[@"账户与安全"],@[@"通知提醒"],@[@"清理缓存"],@[@"帮助与反馈",@"关于我们"],@[@"退出登录"]];
    _cacheNum = 88;
}


- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStyleGrouped)];
    [self.view addSubview:_tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGB(244, 244, 244);
    [_tableview registerNib:[UINib nibWithNibName:@"SXTSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTSetTableViewCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"SXTSetLogoffTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTSetLogoffTableViewCell"];
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
    NSString *data = _datasource[indexPath.section][indexPath.row];
    if (indexPath.section != 4) {
        SXTSetTableViewCell *cell = (SXTSetTableViewCell *)[self.tableview dequeueReusableCellWithIdentifier:@"SXTSetTableViewCell"];
        if (!cell) {
            cell = [[SXTSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SXTSetTableViewCell"];
        }
        
        if (indexPath.section != 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.cacheNum = _cacheNum;
        }
        
        cell.title = data;
        return cell;
    } else {
        SXTSetLogoffTableViewCell *cell = (SXTSetLogoffTableViewCell *)[self.tableview dequeueReusableCellWithIdentifier:@"SXTSetLogoffTableViewCell"];
        if (!cell) {
            cell = [[SXTSetLogoffTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SXTSetLogoffTableViewCell"];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* myView = [[UIView alloc] init];
    return myView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView* myView = [[UIView alloc] init];
    return myView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 4) {
        //清除登陆数据
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"userName"];
        [defaults removeObjectForKey:@"userPass"];
        [defaults synchronize];
        
        SXTLoginViewController *login = [[SXTLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

#pragma mark -- Action

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
