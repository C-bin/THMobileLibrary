//
//  THMineViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THMineViewController.h"
#import "THBaseNavView.h"
/***********************************************************
 **  我的
 **********************************************************/

@interface THMineViewController ()<UIScrollViewDelegate>

@end

@implementation THMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"我的"];
    [self.view addSubview:navView];
    //加载Segment
    [self settingSegment];
    
    //加载ScrollView
    [self settingScrollView];
}
#pragma mark -  新闻公告

- (void)settingSegment{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"借阅信息",@"个人信息",nil];
    //1.初始化UISegmentedControl
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentCtrl.frame=CGRectMake(0, 64, self.view.frame.size.width, 40);
    
    segmentCtrl.selectedSegmentIndex = 0;
    //2.segmentCtrl字体大小，颜色
    [segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //2.segmentCtrl 背景颜色
    segmentCtrl.tintColor = RGB(109, 205, 250);
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-248)];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    scrollView.contentSize = CGSizeMake(2 *SCREEN_WIDTH, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    
    THNewsTableView *tableViewOne = [[THNewsTableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-248)];
    
    THAnnouncementTableView *tableViewTwo = [[THAnnouncementTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-248)];
    [scrollView addSubview:tableViewOne];
    [scrollView addSubview:tableViewTwo];
    
    UIButton *detail_Button=[UIButton buttonWithType:UIButtonTypeCustom];
    detail_Button.frame=CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-124, 100, 30);
    [detail_Button setTitle:@"详情" forState:UIControlStateNormal];
    detail_Button.backgroundColor=RGB(109, 205, 250);
    [self.view addSubview:detail_Button];
    
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
