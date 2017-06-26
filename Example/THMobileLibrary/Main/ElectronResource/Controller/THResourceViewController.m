//
//  THResourceViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THResourceViewController.h"
#import "THBaseNavView.h"
#import "BHInfiniteScrollView.h"
#import "CZCollectionViewCell.h"
#import "THDetailViewController.h"
#import "AFNetworking.h"
#import "CZBookModel.h"
#import "THTHBookListCell.h"
#import "MJRefresh.h"
/***********************************************************
 **  电子资源
 **********************************************************/
#define LOOP_HEIGHT    164
#define IMAGE_URL @"http://101.201.116.210:7726/imageManage/getImagePathForMobile/1902ce11663d4399856887e1d11918c0"

#define HEADER_URL @"http://101.201.114.210/591/ebooks/"

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define WEBSERVICE_URL       @"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?bookType=&classificationId=&classificationNumber=&classificationType=&desc=0&keyword=&pageNum=%ld&pageSize=9&pageType=3&press=&rankType=1&upYearEndVal=&upYearStartVal=&yearEnd=&yearStart="
#define BOOKSTORE_HEARD  @"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?rankType=1&pageSize=12&pageNum="
#define BOOKSTORE_END    @"&pageType=3&keyword=&classificationType=&classificationNumber=&classificationId=&bookType=L15_1&press=&upYearEndVal=&desc=0&upYearStartVal=&yearEnd=&yearStart="


#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_ASPECTRATIO  [UIScreen mainScreen].bounds.size.width/375
static NSString * const SupplementaryViewHeaderIdentify = @"SupplementaryViewHeaderIdentify";
@interface THResourceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BHInfiniteScrollViewDelegate>
{
    UICollectionView *mainCollectionView;
    NSMutableArray * dataArray;
    NSInteger page;
    BOOL _ispulling;
}
@property(nonatomic,strong)NSMutableArray *loopImage_array;
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;

@end

@implementation THResourceViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor=[UIColor whiteColor];
    _loopImage_array = [[NSMutableArray alloc]init];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"电子资源"];
    [self.view addSubview:navView];
    page=1;
    dataArray=[[NSMutableArray alloc]init];

    [self getBooksData];
   
}

#pragma mark UICollectionView 上下拉刷新


#pragma mark - 获取轮播图数据
-(void)getImageData:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [_loopImage_array removeAllObjects];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSDictionary *dict=(NSDictionary *)responseObject;
             NSArray * images =[dict objectForKey:@"data"];

             for (NSDictionary *dic in images) {
        
                 NSString *image_url = [dic objectForKey:@"fileUrl"];
        
                 [_loopImage_array addObject:image_url];
             }
             
             [self createImageLoop];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}
-(void)createImageLoop{
    
    BHInfiniteScrollView* infinitePageView1 = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LOOP_HEIGHT) Delegate:self ImagesArray:_loopImage_array];
    infinitePageView1.dotSize = 10;
    infinitePageView1.pageControlAlignmentOffset = CGSizeMake(0, 20);
    infinitePageView1.scrollTimeInterval = 2;
    infinitePageView1.autoScrollToNextPage = YES;
    infinitePageView1.delegate = self;
    [mainCollectionView addSubview:infinitePageView1];
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
#pragma mark - 获取书城数据
-(void)getBooksData{
    NSString *baseString = [NSString stringWithFormat:@"%@%ld%@",BOOKSTORE_HEARD,page,BOOKSTORE_END];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:baseString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
             NSDictionary *dict=(NSDictionary *)responseObject;

                     NSArray * list =[[dict objectForKey:@"data"] objectForKey:@"list"];
             //        [dataArray removeAllObjects];
                     NSLog(@"--------*********%ld",list.count);
                     for (NSDictionary *bookDic in list) {
                        
                         CZBookModel  *model =[[CZBookModel alloc]init];
                         model.bookName = [bookDic objectForKey:@"bookName"];
                         model.bookid = [bookDic objectForKey:@"id"];
//                        NSLog(@"ID---------------%@",model.bookid);
                         NSArray *pictures=[bookDic objectForKey:@"bookPictures"];
                         NSString *bookPicture=[[pictures objectAtIndex:0]objectForKey:@"filePath"];
                         
                         model.bookImage =[NSString stringWithFormat:@"%@%@",HEADER_URL,bookPicture];
//                          NSLog(@"书名---------------%@",model.bookImage);
                         [dataArray addObject:model];
                       

             }
             if (mainCollectionView) {
                   [mainCollectionView reloadData];
             }else{
              [self createCollectionView];
             }
             [mainCollectionView.mj_header endRefreshing];
             [mainCollectionView.mj_footer endRefreshing];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];

}


-(void)createCollectionView{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width,44);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(100, 100);
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-108) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[CZCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupplementaryViewHeaderIdentify];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    //    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(uppull)];
    
    mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downPull)];
    //轮播图
    [self getImageData:IMAGE_URL];
   

}
-(void)uppull{
    [_loopImage_array removeAllObjects];
    [dataArray removeAllObjects];
    [self getBooksData];
    [mainCollectionView reloadData];
    
    // 结束刷新
//    [mainCollectionView.mj_header endRefreshing];
}
-(void)downPull{
    page++;
    
    [self getBooksData];
    // 结束刷新
//    [mainCollectionView.mj_footer endRefreshing];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZCollectionViewCell *cell = (CZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    //    cell.botlabel.text =[dataArray objectAtIndex:indexPath.row];
        CZBookModel *model=dataArray[indexPath.row];
        [cell configCellWithModel:model];

    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN_WIDTH<SCREEN_HEIGHT) {
        return CGSizeMake(90*SCREEN_ASPECTRATIO, 150*SCREEN_ASPECTRATIO);
    }else{
        return CGSizeMake(90, 150);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15,15,10,15);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
#pragma mark - UICollectionViewDelegateFlowLayout method
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(100, 164);
    }
    return CGSizeMake(100, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    CZBookModel *model=dataArray[indexPath.row];
   
    THDetailViewController *detail=[[THDetailViewController alloc]init];
    detail.bookModel = model;
    
    
    [self.navigationController pushViewController:detail animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
