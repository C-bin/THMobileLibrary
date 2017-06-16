//
//  THResourceViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THResourceViewController.h"
#import "THBaseNavView.h"

#import "CZCollectionViewCell.h"
#import "THDetailViewController.h"

#import "CZBookModel.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define WEBSERVICE_URL       @"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?bookType=&classificationId=&classificationNumber=&classificationType=&desc=0&keyword=&pageNum=%ld&pageSize=9&pageType=3&press=&rankType=1&upYearEndVal=&upYearStartVal=&yearEnd=&yearStart="
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_ASPECTRATIO  [UIScreen mainScreen].bounds.size.width/375
static NSString * const SupplementaryViewHeaderIdentify = @"SupplementaryViewHeaderIdentify";
@interface THResourceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSMutableArray * dataArray;
}


@end

@implementation THResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor=[UIColor yellowColor];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"电子资源"];
    [self.view addSubview:navView];
    dataArray=[[NSMutableArray alloc]init];
    
    
    
    [self getBooksData];
    NSLog(@"");
    
}

-(void)getBooksData{
    NSString *baseString = @"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?rankType=1&pageSize=12&pageNum=1&pageType=3&keyword=&classificationType=&classificationNumber=&classificationId=&bookType=L15_1&press=&upYearEndVal=&desc=0&upYearStartVal=&yearEnd=&yearStart=";
    //转化为URL
    NSURL *baseURL = [NSURL URLWithString:baseString];
    
    //根据 baseURL 创建网络请求对象
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:baseURL];
    //设置参数：1.POST 2.参数体（body）
    [requset setHTTPMethod:@"GET"];
    //2.body参数
    //    NSString *bodyString = @"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
    //    NSData *badyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //设置 body（POST参数）
    //    [requset setHTTPBody:badyData];
    
    //iOS 9 提供了 NSURLSession 来代替  NSURLConnection
    //首先，创建一个 NSURLSession 对象（如果要使用block来完成网络请求，这个对象可以使用 NSURLSession 自带的单例对象）
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    // session发送网络请求对象
    WEAKSELF
    NSURLSessionTask *task = [session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * books =[[dict objectForKey:@"data"] objectForKey:@"list"];
//        [dataArray removeAllObjects];
        NSLog(@"--------*********%ld",books.count);
        for (int i =0; i<books.count; i++) {
            NSDictionary * book =[books objectAtIndex:i];
            CZBookModel  *paperiteam =[[CZBookModel alloc]init];
            paperiteam.bookName = [book objectForKey:@"bookName"];
            paperiteam.id = [book objectForKey:@"id"];
            paperiteam.bookImage = [NSString stringWithFormat:@"http://101.201.114.210/591/ebooks/%@",[[[book objectForKey:@"bookPictures"] objectAtIndex:0]objectForKey:@"filePath"]];
//             NSLog(@"--------*********%@",paperiteam.bookName);
            [dataArray addObject:paperiteam];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
         
    
        });
    }];
    //开始网络请求任务
    [task resume];
    [self createCollectionView];
    
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
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-44) collectionViewLayout:layout];
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
    //轮播图
//    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) scrollDuration:3.f];
//    //    loop.imageURLStrings = @[@"lunbo2.png", @"lunbo1.jpg", @"lunbo3.png", @"lunbo4.png"];
//    loop.imageURLStrings = @[@"lunbo1.jpg", @"lunbo2.png", @"lunbo3.png", @"lunbo4.png"];
//    loop.clickAction = ^(NSInteger index) {
//        
//    };
//    [mainCollectionView addSubview:loop];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZCollectionViewCell *cell = (CZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    //    cell.botlabel.text =[dataArray objectAtIndex:indexPath.row];
        CZBookModel *model=dataArray[indexPath.row];
        [cell configCellWithModel:model];
    NSLog(@">>>>>>><<<<<<<<<<<%@",cell.botlabel);
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
        return CGSizeMake(100, 180);
    }
    return CGSizeMake(100, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CZCollectionViewCell *cell = (CZCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    CZBookModel *model=dataArray[indexPath.row];
    
    THDetailViewController *detail=[[THDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:NO];
    
    
    NSLog(@">>>>>>>>>>%ld",indexPath.row);
    
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
