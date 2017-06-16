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
#import "THBaseNavView.h"
#import "THFounctionCell.h"
#import "THNewsTableView.h"
#import "THAnnouncementTableView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_ASPECTRATIO  [UIScreen mainScreen].bounds.size.width/375

#define LOOP_HEIGHT    164
#define FOUNCTION_HEIGHT    150


#define IMAGE_URL @"http://101.201.116.210:7726/imageManage/getImagePathForMobile/1902ce11663d4399856887e1d11918c0"

//ScrollView高度
#define LG_scrollViewH    SCREEN_HEIGHT-LOOP_HEIGHT-FOUNCTION_HEIGHT-SEGMENT_H-108
//Segment高度
#define SEGMENT_H 40
@interface THHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,BHInfiniteScrollViewDelegate>
{
    UICollectionView *mainCollectionView;
    NSArray * dataArray;
   
}
//@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,strong)NSMutableArray *loopImage_array;
@property(nonatomic,weak)CALayer *LGLayer;
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;
@end

@implementation THHomeViewController
- (NSMutableArray *)buttonList
{
    if (!_buttonList)
    {
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}
- (NSMutableArray *)loopImage_array
{
    if (!_loopImage_array)
    {
        _loopImage_array = [NSMutableArray array];
    }
    return _loopImage_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
   dataArray =@[@"馆藏查询",@"新书推荐",@"借阅排行",@"扫一扫",@"读者信息",@"我的书架",@"正在借阅",@"历史借阅"];
//loopImage_array=[[NSMutableArray alloc]init];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"首页"];
    [self.view addSubview:navView];
    
    //轮播图
       [self getImageArray:IMAGE_URL];
    //功能按钮
    [self createCollectionView];
    //加载Segment
    [self settingSegment];

    //加载ScrollView
   [self settingScrollView];

 
}

-(void)getImageArray:(NSString *)image_url{
   
    NSURL *url = [NSURL URLWithString:image_url];
    // 2.创建一个网络请求
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务：
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到数据");
        /*
         对从服务器获取到的数据data进行相应的处理：
         */
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        NSArray * images =[dict objectForKey:@"data"];
                //        [dataArray removeAllObjects];
                NSLog(@"--------*********%ld",images.count);
                for (NSDictionary *dic in images) {
        
                     THImageModel *loopImage=[[THImageModel alloc]init];
                    loopImage.fileUrl = [dic objectForKey:@"fileUrl"];
        
        
//                    NSLog(@"--------*********%@",loopImage.fileUrl);
                    [_loopImage_array addObject:loopImage.fileUrl];
                    
                }
        dispatch_async(dispatch_get_main_queue(),^{
            
            //更新界面
//            [self reloadData];
            [self createLoop];
            NSLog(@"图片数组----%@",_loopImage_array);
        });
    }];
    // 5.最后一步，执行任务（resume也是继续执行）:
    [sessionDataTask resume];
    
    
    
}
-(void)createLoop{
//    NSArray *imageArray=[NSArray arrayWithArray:loopImage_array];
//    NSLog(@"图片地址------%@",imageArray);
    BHInfiniteScrollView* infinitePageView1 = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), LOOP_HEIGHT) Delegate:self ImagesArray:_loopImage_array];
    
    infinitePageView1.dotSize = 10;
    infinitePageView1.pageControlAlignmentOffset = CGSizeMake(0, 20);
    //    infinitePageView1.titleView.textColor = [UIColor whiteColor];
    //    infinitePageView1.titleView.margin = 30;
    //    infinitePageView1.titleView.hidden = YES;
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
    NSLog(@"did scroll to index %ld", index);
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    //NSLog(@"did select item at index %ld", index);
}
//-(void)createLoopBanner{
//    
//    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, LOOP_HEIGHT) scrollDuration:3.f];
//    loop.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
//    loop.clickAction = ^(NSInteger index) {
//        
//    };
//    [self.view addSubview:loop];
//}
-(void)createCollectionView{
    #pragma mark - CreateUICollectionView
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width,44);
    //该方法也可以设置itemSize
    layout.itemSize = CGSizeMake(kScreenWidth / 4, 60);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+LOOP_HEIGHT, SCREEN_WIDTH,FOUNCTION_HEIGHT) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[THFounctionCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    //    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
 
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THFounctionCell *cell = (THFounctionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cell.botlabel.text =[dataArray objectAtIndex:indexPath.row];
    //    CZBookModel *model=dataArray[indexPath.row];
    //    [cell configCellWithModel:model];
    
    return cell;
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 1 / [UIScreen mainScreen].scale, 0);
    
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark - UICollectionViewDelegateFlowLayout method
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CZCollectionViewCell *cell = (CZCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    CZBookModel *model=dataArray[indexPath.row];
    NSLog(@"----------%ld",indexPath.row);
    
    
}

#pragma mark -  新闻公告

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
#pragma mark - ScrollView 新闻公告
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
