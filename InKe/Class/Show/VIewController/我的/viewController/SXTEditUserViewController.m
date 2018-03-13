//
//  SXTEditUserViewController.m
//  InKe
//
//  Created by SJQ on 2018/2/28.
//  Copyright © 2018年 sjq. All rights reserved.
//

#import "SXTEditUserViewController.h"
#import "SXTEditUserTitleTableViewCell.h"
#import "SXTEditUserHeadImageTableViewCell.h"
#import "SXTMiaoBoModel.h"
#import "FNUIActionSheet.h"
#import <MessageUI/MessageUI.h>
#import "UIImage+NTES.h"
#import "NTESFileLocationHelper.h"

@interface SXTEditUserViewController ()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) SXTMiaoBoModel *miaoModel;
@property (nonatomic, strong) FNUIActionSheet *moreActionSheet;


@end

@implementation SXTEditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"编辑信息";
    [self setupNav];
    [self setupTableView];
    [self setupData];
}

- (void)setupNav {
    UIButton *leftButton = [FNButton commonNavBackButton];
    [leftButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWithType:FNNavationBarType_Normal];
}

- (void)setupTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    headView.backgroundColor = UIColorFromRGB(0xF8F5F6);
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStylePlain)];
    [self.view addSubview:_tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = UIColorFromRGB(0xF8F5F6);
    _tableview.tableHeaderView = headView;
    
    [_tableview registerNib:[UINib nibWithNibName:@"SXTEditUserTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTEditUserTitleTableViewCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"SXTEditUserHeadImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SXTEditUserHeadImageTableViewCell"];
}

- (void)setupData
{
    _datasource = @[@[@"头像"],@[@"昵称",@"ID",@"性别",@"个性签名"],@[@"直播时长",@"实名认证",@"绑定手机"]];
    
    SXTMiaoBoModel *model = [[SXTMiaoBoModel alloc] init];
    model.myname = @"你比星光还要遥远";
    model.signatures = @"我只想拥有挽留你的能力";
    model.userId  = @"123456";
    model.sex = 1;
    model.liveTimes = 1.5;
    self.miaoModel = model;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datasource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SXTEditUserHeadImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SXTEditUserHeadImageTableViewCell" forIndexPath:indexPath];
        cell.miaoModel = self.miaoModel;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 1) {
        SXTEditUserTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SXTEditUserTitleTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:self.miaoModel.myname];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.row == 1) {
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:self.miaoModel.userId];
        } else if (indexPath.row == 2) {
            NSString *sex  = nil;
            if (self.miaoModel.sex == 0) {
                sex = @"女";
            } else {
                sex = @"男";
            }
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:sex];
        } else {
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
    } else {
        SXTEditUserTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SXTEditUserTitleTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:[NSString stringWithFormat:@"%ld(h)",self.miaoModel.liveTimes]];
        } else if(indexPath.row == 1) {
            NSString *messageDate = nil;
            if (self.miaoModel.isRealName) {
                messageDate = @"已实名";
            } else {
                messageDate = @"未实名";
            }
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:messageDate];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else{
            NSString *messageIPhone  = nil;
            if (self.miaoModel.sex) {
                messageIPhone = @"已绑定";
            } else {
                messageIPhone = @"暂未绑定";
            }
            [cell setTitle:self.datasource[indexPath.section][indexPath.row] values:messageIPhone];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        return 50;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        //更换头像
        [self changeHeadImage];
    }
}




#pragma mark -- Action

- (void)onBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeHeadImage {
    /* -----功能记录------- */
//    NSMutableArray *buttonArray = [@[@"复制", @"拨打电话",@"发送信息",@"更换头像"] mutableCopy];
//    _moreActionSheet = [[FNUIActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" otherButtonList:buttonArray];
//    __weak typeof(self) weakSelf = self;
//    [_moreActionSheet showFNActionSheetWithCompletionHandler:^(NSInteger buttonIndex) {
//        if (buttonIndex == 0) {
//            //复制
//        } else if (buttonIndex == 1) {
//            //拨打电话
//            [FNAlertHelper showAlertWithTitle:@"标题" msg:@"123" chooseBlock:^(NSInteger buttonIdx) {
//                if (buttonIdx == 1) {
//                    NSLog(@"点击了呼叫");
//                }
//            } buttonsStatement:@"取消", @"呼叫", nil];
//        } else if (buttonIndex == 2) {
//            //发送消息
//            [weakSelf showMessageView:[NSArray arrayWithObjects:@"18895359235", nil] title:@"" body:@""];
//        } else {
//            //更换头像
//            [self changeHeadImageAction];
//        }
//    }];
    
    
    [self changeHeadImageAction];
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        [FNAlertHelper showAlertWithTitle:@"提示信息" msg:@"该设备不支持短信功能" chooseBlock:^(NSInteger buttonIdx) {
            
        } buttonsArray:@[@"确定"]];
    }
}

//选取相册内的图片
- (void)changeHeadImageAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //初始化UIImagePickerController
                          UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
                          //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
                          //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
                          //获取方法3，通过图片（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
                          PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                          //允许编辑，即放大裁剪
                          PickerImage.allowsEditing = YES;
                          //自代理
                          PickerImage.delegate = self;
                          //页面跳转
                          [[[[UIApplication sharedApplication].windows objectAtIndex:0]rootViewController] presentViewController:PickerImage animated:YES completion:nil];
                      }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          /**
                           其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
                           */
                          UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
                          //获取方式:通过相机
                          PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
                          PickerImage.allowsEditing = YES;
                          PickerImage.delegate = self;
                          [[[[UIApplication sharedApplication].windows objectAtIndex:0]rootViewController] presentViewController:PickerImage animated:YES completion:nil];
                      }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                      }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImage *imageForAvatarUpload = [newPhoto imageForAvatarUpload];
    //上传图片名字
    NSString *fileName = [NTESFileLocationHelper genFilenameWithExt:@"jpg"];
    [self.view makeToast:fileName duration:0.5 position:CSToastPositionCenter];
    //上传图片路径
    NSString *filePath = [[NTESFileLocationHelper getAppDocumentPath] stringByAppendingPathComponent:fileName];
//    _myHeadPortrait.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
