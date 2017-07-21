//
//  THHomeViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THHomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "THReaderViewController.h"
#import "THBorrowingViewController.h"
#import "THHistoryBorrowViewController.h"
#import "THRankViewController.h"
#import "THBookCaseViewController.h"
/***********************************************************
 **  首页
 **********************************************************/


//轮播图高度
#define LOOP_HEIGHT    [UIScreen mainScreen].bounds.size.height/3-64
//功能按钮区高度
#define FOUNCTION_HEIGHT    120
//轮播图数据
#define IMAGE_URL @"http://101.201.116.210:7726/imageManage/getImagePathForMobile/1902ce11663d4399856887e1d11918c0"
//ScrollView高度
#define LG_scrollViewH    [UIScreen mainScreen].bounds.size.height/3+10
//Segment高度
#define SEGMENT_H 35
#define  segmentedArray   [[NSArray alloc]initWithObjects:@"图书馆通知",@"系统公告",nil]


@interface THHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,BHInfiniteScrollViewDelegate,OnTapBtnViewDelegate>
{
    UICollectionView *mainCollectionView;
    NSArray * titleArray;
    NSArray * iconArray;
    NSInteger selectedIndex;
}
//@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,strong)NSMutableArray *loopImage_array;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)CALayer *LGLayer;
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;
@property (nonatomic, strong) THProgressHUD* progressHUD;
@end

@implementation THHomeViewController
- (NSMutableArray *)buttonList
{
    if (!_buttonList)
    {
        _buttonList = [[NSMutableArray alloc]init];
    }
    return _buttonList;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];

    //初始化
   _loopImage_array = [[NSMutableArray alloc]init];
   
    [self createNavgationBar];
    _progressHUD = [[THProgressHUD alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-40, 80, 80)];
    
    [self.view addSubview:_progressHUD];
    [_progressHUD startAnimation];  //开始转动
    
//       轮播图
        [self getImageData:IMAGE_URL];
//        //功能按钮
        [self createFeatureView];
        //加载Segment
        [self settingSegment];
    
        //加载ScrollView
        [self settingScrollView];
}

-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"首页"];
    [self.view addSubview:navView];
  
}

-(void)getImageData:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
      
             NSDictionary *dict=(NSDictionary *)responseObject;
             NSArray * images =[dict objectForKey:@"data"];
           
             for (NSDictionary *dic in images) {
                 //
                 //
                 NSString *image_url = [dic objectForKey:@"fileUrl"];
             
                 [_loopImage_array addObject:image_url];
                 //
             }
        [_progressHUD stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
             [self createImageLoop];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             [_progressHUD stopAnimationWithLoadText:@"加载失败" withType:NO];//加载失败
         }];
    
}
#pragma mark - createImageLoop 轮播视图
-(void)createImageLoop{
    
    BHInfiniteScrollView* infinitePageView1 = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, LOOP_HEIGHT-10) Delegate:self ImagesArray:_loopImage_array];
    infinitePageView1.dotSize = 10;
    infinitePageView1.pageControlAlignmentOffset = CGSizeMake(0, 20);
    infinitePageView1.scrollTimeInterval = 2;
    infinitePageView1.autoScrollToNextPage = YES;
    infinitePageView1.delegate = self;
    [self.view addSubview:infinitePageView1];
}
- (void)stop {
    [_infinitePageView stopAutoScrollPage];
}

- (void)start {
    [_infinitePageView startAutoScrollPage];
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didScrollToIndex:(NSInteger)index {
//    NSLog(@"did scroll to index %ld", index);
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    //NSLog(@"did select item at index %ld", index);
}
#pragma mark - createCollectionView 功能列表
-(void)createFeatureView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LOOP_HEIGHT+54, self.view.frame.size.width, FOUNCTION_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //禁止滑动
    self.tableView.scrollEnabled =NO;
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"menucell";
    HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier menuArray:iconArray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.onTapBtnViewDelegate = self;
    return cell;
}

#pragma mark -OnTapBtnViewDelegate

- (void)OnTapBtnView:(UITapGestureRecognizer *)sender {
    
   
    if (sender.view.tag==10) {
        THLibraryCatalogSearch *libraryCatalogSearch=[[THLibraryCatalogSearch alloc]init];
        [self.navigationController pushViewController:libraryCatalogSearch animated:NO];
    }else if (sender.view.tag==11){
        THNewBookViewController *newBook=[[THNewBookViewController alloc]init];
        [self.navigationController pushViewController:newBook animated:NO];
    }else if (sender.view.tag==12){
        THRankViewController *rank=[[THRankViewController alloc]init];
        [self.navigationController pushViewController:rank animated:NO];
    }
    else if (sender.view.tag==13){
        [self openQrCodeScanningView];
    }
    else if (sender.view.tag==14){
        THReaderViewController *userInfo=[[THReaderViewController alloc]init];
         [self.navigationController pushViewController:userInfo animated:NO];
    }
    else if (sender.view.tag==15){
        
        THBookCaseViewController *bookShell = [[THBookCaseViewController alloc]init];
        [self.navigationController pushViewController:bookShell animated:NO];
    }
    else if (sender.view.tag==16){
        THBorrowingViewController *borrowing=[[THBorrowingViewController alloc]init];
        [self.navigationController pushViewController:borrowing animated:NO];
    }else if (sender.view.tag==17){
       THHistoryBorrowViewController *history=[[THHistoryBorrowViewController alloc]init];
        [self.navigationController pushViewController:history animated:NO];
    }
}
#pragma mark -  扫一扫 openQrCodeScanningView
-(void)openQrCodeScanningView{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        THScanningViewController *scanVC=[[THScanningViewController alloc]init];
                        [self.navigationController pushViewController:scanVC animated:YES];
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            THScanningViewController *scanVC=[[THScanningViewController alloc]init];
            [self.navigationController pushViewController:scanVC animated:YES];
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }

}

#pragma mark -  新闻公告 Segment
- (void)settingSegment{
//    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"图书馆通知",@"系统公告",nil];
    //1.初始化UISegmentedControl
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentCtrl.frame=CGRectMake(0, 64+LOOP_HEIGHT+FOUNCTION_HEIGHT, self.view.frame.size.width, SEGMENT_H);
    
    segmentCtrl.selectedSegmentIndex = 0;
    //2.segmentCtrl字体大小，颜色
    [segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //2.segmentCtrl 背景颜色
    segmentCtrl.tintColor = [UIColor lightGrayColor];
    [segmentCtrl addTarget:self action:@selector(segmentBtnClick:) forControlEvents:UIControlEventValueChanged];
    _segmentCtrl = segmentCtrl;
    [self.view addSubview:segmentCtrl];
    
}
//segmentCtrl 点击事件
- (void)segmentBtnClick:(UISegmentedControl *)segmentCtrl{
 
    selectedIndex= segmentCtrl.selectedSegmentIndex;
    self.scrollView.contentOffset = CGPointMake(self.segmentCtrl.selectedSegmentIndex * SCREEN_WIDTH, 0);
}
#pragma mark -  新闻公告 ScrollView
- (void)settingScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+LOOP_HEIGHT+FOUNCTION_HEIGHT+SEGMENT_H, SCREEN_WIDTH, LG_scrollViewH)];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    scrollView.contentSize = CGSizeMake(2 *SCREEN_WIDTH, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    THNewsTableView *tableViewOne = [[THNewsTableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, LG_scrollViewH) URL:NEWS_URL type:@"1"];
    THNewsTableView *tableViewTwo = [[THNewsTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, LG_scrollViewH) URL:NEWS_URL type:@"2"];

    [scrollView addSubview:tableViewOne];
    [scrollView addSubview:tableViewTwo];
    //通知中心是个单例
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:@"newsMessage" object:nil];
    _scrollView = scrollView;
}

- (void)receiveNotification:(NSNotification *)noti
{
    THNewsViewController *newsVC=[[THNewsViewController alloc]init];
    newsVC.headline=noti.object;
    newsVC.content= noti.userInfo[@"Value"];
    newsVC.navtitle=[segmentedArray objectAtIndex:selectedIndex];
    [self.navigationController pushViewController:newsVC animated:NO];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    self.segmentCtrl.selectedSegmentIndex = offset/SCREEN_WIDTH;
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
   

