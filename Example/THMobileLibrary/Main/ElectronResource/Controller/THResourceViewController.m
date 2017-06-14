//
//  THResourceViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THResourceViewController.h"
#import "THBaseNavView.h"
#import "LoopBanner.h"
#import "CZCollectionViewCell.h"
#import "THDetailViewController.h"
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_ASPECTRATIO  [UIScreen mainScreen].bounds.size.width/375
static NSString * const SupplementaryViewHeaderIdentify = @"SupplementaryViewHeaderIdentify";
@interface THResourceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSArray * dataArray;
}


@end

@implementation THResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor=[UIColor yellowColor];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:navView];
    
    dataArray =@[@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清",@"朱自清"];
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
    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180) scrollDuration:3.f];
    //    loop.imageURLStrings = @[@"lunbo2.png", @"lunbo1.jpg", @"lunbo3.png", @"lunbo4.png"];
    loop.imageURLStrings = @[@"lunbo1.jpg", @"lunbo2.png", @"lunbo3.png", @"lunbo4.png"];
    loop.clickAction = ^(NSInteger index) {
        
    };
    [mainCollectionView addSubview:loop];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZCollectionViewCell *cell = (CZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    //    cell.botlabel.text =[dataArray objectAtIndex:indexPath.row];
    //    CZBookModel *model=dataArray[indexPath.row];
    //    [cell configCellWithModel:model];
    
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
