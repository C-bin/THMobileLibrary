//
//  THHomeViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THHomeViewController.h"
#import "LoopBanner.h"
#import "THBaseNavView.h"
#import "THFounctionCell.h"
#import "LGSegment.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_ASPECTRATIO  [UIScreen mainScreen].bounds.size.width/375

//ScrollView高度
#define LG_scrollViewH 250
//Segment高度
#define LG_segmentH 40
@interface THHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,SegmentDelegate>
{
    UICollectionView *mainCollectionView;
    NSArray * dataArray;
}
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property (nonatomic, weak) LGSegment *segment;
@property(nonatomic,weak)CALayer *LGLayer;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
   dataArray =@[@"馆藏查询",@"新书推荐",@"借阅排行",@"扫一扫",@"读者信息",@"我的书架",@"正在借阅",@"历史借阅"];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:navView];
  
    //轮播图
    [self createLoopBanner];
    //功能按钮
    [self createCollectionView];
    //加载Segment
    [self setSegment];
    //加载ViewController
//    [self addChildViewController];
    //加载ScrollView
    [self setContentScrollView];
    
//    [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];

}
-(void)createLoopBanner{
    
    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 180) scrollDuration:3.f];
    loop.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    loop.clickAction = ^(NSInteger index) {
        
    };
    [self.view addSubview:loop];
}
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
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 244, SCREEN_WIDTH, 150) collectionViewLayout:layout];
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
//LGSegment
-(void)setSegment {
    
    [self buttonList];
    //初始化
    LGSegment *segment = [[LGSegment alloc]initWithFrame:CGRectMake(0, 390, self.view.frame.size.width, LG_segmentH)];
    segment.delegate = self;
    self.segment = segment;
    segment.backgroundColor=[UIColor redColor];
    [self.view addSubview:segment];
    [self.buttonList addObject:segment.buttonList];
    self.LGLayer = segment.LGLayer;
    
}
//加载ScrollView
-(void)setContentScrollView {
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 390+LG_segmentH, self.view.frame.size.width, LG_scrollViewH)];
    [self.view addSubview:sv];
    sv.bounces = NO;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.scrollEnabled = YES;
    sv.userInteractionEnabled = YES;
    sv.delegate = self;
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, 300);
        [sv addSubview:vc.view];
        sv.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
    }
//    sv.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    sv.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
    self.contentScrollView = sv;
}
//加载3个ViewController
-(void)addChildViewController{
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 390, self.view.frame.size.width, LG_scrollViewH)];
    [self.view addSubview:sv];
    sv.bounces = NO;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.scrollEnabled = YES;
    sv.userInteractionEnabled = YES;
    sv.delegate = self;
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, 300);
        sv.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [sv addSubview:vc.view];
        
    }
    

    sv.contentSize = CGSizeMake(3 * SCREEN_WIDTH, 0);
    self.contentScrollView = sv;
}

#pragma mark - UIScrollViewDelegate
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    [self.segment moveToOffsetX:offsetX];
    
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
