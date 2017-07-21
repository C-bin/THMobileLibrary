//
//  THMineViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THMineViewController.h"
#import "THBaseNavView.h"
#import "THAppDelegate.h"
#import "THLoginViewController.h"
#import "THPersonalInformation.h"
#import "THPersonalCell.h"
#import "THReaderViewController.h"
#import "THBorrowingViewController.h"
#import "THAboutusViewController.h"
#import "THSettingViewController.h"
//#import "CacheTool.h"
/***********************************************************
 **  我的
 **********************************************************/
#define   Head_HEIGHT    ([UIScreen mainScreen].bounds.size.height-114)/3
#define   Message_HEIGHT [UIScreen mainScreen].bounds.size.height/3*2-64

#define   DocumentPath   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
#define   LibraryPath    NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject
#define   TempPath       NSTemporaryDirectory()


@interface THMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    NSArray *title_array;
    NSString *cacheSize;
}
@property (nonatomic,strong) UITableView *tableView;
/** 数据数组 */
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation THMineViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGB(237, 236, 239);
 
    
    [self headImageView];
    [self createMessageAndSetting];
   
}
- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *miaoBi = [NSMutableDictionary dictionary];
        miaoBi[@"title"] = @"个人信息";
        miaoBi[@"icon"] = @"me.png";
        
        //自己写要跳转到的控制器
        miaoBi[@"controller"] = [THReaderViewController class];
        
//        NSMutableDictionary *zhiBoJian = [NSMutableDictionary dictionary];
//        zhiBoJian[@"title"] = @"借阅信息";
//        zhiBoJian[@"icon"] = @"borrowing.png";
//        //自己写要跳转到的控制器
//        zhiBoJian[@"controller"] = [UIViewController class];
        
        
        NSMutableDictionary *liCai = [NSMutableDictionary dictionary];
        liCai[@"title"] = @"借阅信息";
        liCai[@"icon"] = @"borrowing.png";
        liCai[@"controller"] = [THBorrowingViewController class];
        
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"程序设置";
        cleanCache[@"icon"] = @"setting.png";
        cleanCache[@"controller"] = [THSettingViewController class];
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"关于我们";
        setting[@"icon"] = @"about.png";
        setting[@"controller"] = [THAboutusViewController class];
        
        NSArray *section1 = @[miaoBi];
        NSArray *section2 = @[liCai];
        NSArray *section3 = @[cleanCache];
        NSArray *section4 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section1, section2, section3,section4, nil];
    }
    return _dataList;
}
#pragma mark -  头图片
-(void)headImageView{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Head_HEIGHT)];
    [_imageView setImage:[UIImage imageNamed:@"MineBackGround.jpg"]];
    [self.view addSubview:_imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3787527286718810832.jpg"]];
    
    imageView1.frame = CGRectMake(40,Head_HEIGHT-30, 60, 60);
    
    imageView1.layer.masksToBounds =YES;
    
    imageView1.layer.cornerRadius =30;
    
    [self.view addSubview:imageView1];
    
    UILabel *nameTitle=[[UILabel alloc]initWithFrame:CGRectMake(120, Head_HEIGHT+5, SCREEN_WIDTH-180, 20)];
    
    nameTitle.text=[THReaderConstant shareReadConstant].userName;
    nameTitle.backgroundColor=[UIColor clearColor];
    [self.view addSubview:nameTitle];
    
}

-(void)createMessageAndSetting{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Head_HEIGHT+40, SCREEN_WIDTH, SCREEN_HEIGHT-200) style:UITableViewStyleGrouped];
 
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
      self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];

}
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"mineCell";
    THPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[THPersonalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    
    cell.textLabel.text = dict[@"title"];
    cell.textLabel.textColor=RGB(107, 107, 107);
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
//    cell.selected = YES;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
        
        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
        NSLog(@"......%@",vc.title);
         [self.navigationController pushViewController:vc animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 1 : CGFLOAT_MIN;
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
