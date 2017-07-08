//
//  THHomeViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THHomeViewController.h"
#import "BHInfiniteScrollView.h"
#import "THImageModel.h"
#import "HomeMenuCell.h"
#import "THNewsTableView.h"
#import "THAnnouncementTableView.h"
#import "THLibraryCatalogSearch.h"
#import "MBProgressHUD.h"
#import "THNewBookViewController.h"
/***********************************************************
 **  首页
 **********************************************************/

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define SCREEN_ASPECTRATIO  [UIScreen mainScreen].bounds.size.width/375
//轮播图高度
#define LOOP_HEIGHT    [UIScreen mainScreen].bounds.size.height/3-64
//功能按钮区高度
#define FOUNCTION_HEIGHT    160
//轮播图数据
#define IMAGE_URL @"http://101.201.116.210:7726/imageManage/getImagePathForMobile/1902ce11663d4399856887e1d11918c0"
//ScrollView高度
#define LG_scrollViewH    [UIScreen mainScreen].bounds.size.height/3+10
//Segment高度
#define SEGMENT_H 40
@interface THHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,BHInfiniteScrollViewDelegate,OnTapBtnViewDelegate>
{
    UICollectionView *mainCollectionView;
    NSArray * titleArray;
    NSArray * iconArray;
}
//@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,strong)NSMutableArray *loopImage_array;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)CALayer *LGLayer;
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;
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
//self.view.frame.size.height
    //初始化
   titleArray =@[@"馆藏查询",@"新书推荐",@"借阅排行",@"扫一扫",@"读者信息",@"我的书架",@"正在借阅",@"历史借阅"];
    _loopImage_array = [[NSMutableArray alloc]init];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"首页"];
    [self.view addSubview:navView];
//       轮播图
        [self getImageData:IMAGE_URL];
        //功能按钮
        [self createFeatureView];
        //加载Segment
        [self settingSegment];
    
        //加载ScrollView
        [self settingScrollView];
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

             [self createImageLoop];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
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
    
    
    return 140;
    
    
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
    
    NSLog(@"tag:%ld",sender.view.tag);
    if (sender.view.tag==10) {
        THLibraryCatalogSearch *libraryCatalogSearch=[[THLibraryCatalogSearch alloc]init];
        [self.navigationController pushViewController:libraryCatalogSearch animated:NO];
    }else if (sender.view.tag==11){
        THNewBookViewController *newBook=[[THNewBookViewController alloc]init];
        [self.navigationController pushViewController:newBook animated:NO];
    }else if (sender.view.tag==12){
        NSLog(@"2");
    }
    else if (sender.view.tag==13){
        NSLog(@"3");
    }
    else if (sender.view.tag==14){
        NSLog(@"4");
    }
    else if (sender.view.tag==15){
        NSLog(@"5");
    }
    else if (sender.view.tag==16){
        NSLog(@"6");
    }else if (sender.view.tag==17){
        NSLog(@"7");
    }
}
#pragma mark -  新闻公告 Segment

- (void)settingSegment{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"图书馆通知",@"系统公告",nil];
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
    
    THNewsTableView *tableViewOne = [[THNewsTableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, LG_scrollViewH)];
    
    THAnnouncementTableView *tableViewTwo = [[THAnnouncementTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, LG_scrollViewH)];
    [scrollView addSubview:tableViewOne];
    [scrollView addSubview:tableViewTwo];
    
    _scrollView = scrollView;
    
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
