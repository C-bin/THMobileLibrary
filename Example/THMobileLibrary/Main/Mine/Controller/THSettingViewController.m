//
//  THSettingViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/21.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THSettingViewController.h"
#import "THPersonalCell.h"
#import "THAppDelegate.h"
#import "THLoginViewController.h"
#define   DocumentPath   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
#define   LibraryPath    NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject
#define   TempPath       NSTemporaryDirectory()
@interface THSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    NSArray *historyArray;
     NSString *cacheSize;
}

@end

@implementation THSettingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self createTableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    historyArray=@[@"评分",@"检测更新",@"清除缓存"];
    self.view.backgroundColor=RGB(246, 246, 246);
    //导航栏
    [self createNavgationBar];
    
    [self createTableView];
    [self createExit_Button];
}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 150) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.backgroundColor=RGB(242, 242, 242);
    [self.view addSubview:_tableView];
}
/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return historyArray.count;
}
//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    THPersonalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[THPersonalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
   
   cell.textLabel.text = [historyArray objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    if (indexPath.row==2) {
        CGFloat size = [self folderSizeAtPath:DocumentPath] + [self folderSizeAtPath:LibraryPath] + [self folderSizeAtPath:TempPath];
        
        cacheSize = size > 1 ? [NSString stringWithFormat:@"%.2fM", size] : [NSString stringWithFormat:@"%.2fK", size * 1024.0];
        cell.detailTextLabel.text = cacheSize;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //    CZBookModel *model=dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *bookName=historyArray[indexPath.row];
    NSLog(@"选中 = %@",bookName);
    if (indexPath.row==0) {
        _alert = [[UIAlertView alloc] initWithTitle:nil message:@"谢谢" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        
        [_alert show];
    }else if (indexPath.row==1){
        _alert = [[UIAlertView alloc] initWithTitle:nil message:@"已经是最新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
      
        [_alert show];
    }else if (indexPath.row==2){
        
       _alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要清除缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        _alert.tag=10;
       [_alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
      if (buttonIndex == 1) {//确定则注销
    if (alertView.tag==10) {
       
            [self cleanCaches:DocumentPath];
            [self cleanCaches:LibraryPath];
            [self cleanCaches:TempPath];
            [_tableView reloadData];
  
    }
    if (alertView.tag==11) {//确定则注销
      
            THAppDelegate *appDelegate = (THAppDelegate *)[UIApplication sharedApplication].delegate;
            self.view.window.rootViewController = appDelegate.nav;
        }

    }
   
}
// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}


// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
#pragma mark -  退出登录按钮
-(void)createExit_Button{
    UIButton *exit_Button=[UIButton buttonWithType:UIButtonTypeCustom];
    exit_Button.frame=CGRectMake(30, 280, SCREEN_WIDTH-60, 50);
    [exit_Button setTitle:@"退出登录" forState:UIControlStateNormal];
    [exit_Button addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    exit_Button.layer.cornerRadius = 8.0;//2.0是圆角的弧度，根据需求自己更改
    exit_Button.layer.borderColor = (__bridge CGColorRef _Nullable)(RGB(254, 118, 84));//设置边框颜色
    exit_Button.layer.borderWidth = 1.0f;//设置边框颜色
    
    exit_Button.backgroundColor=RGB(254, 118, 84);
    [self.view addSubview:exit_Button];
}
#pragma mark -  点击退出登录
-(void)exitLogin{
    
    _alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    _alert.tag=11;
    [_alert show];
   
}

-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"程序设置"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
}
-(void)backtoHome{
    
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
