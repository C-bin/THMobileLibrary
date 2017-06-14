//
//  THMainViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THMainViewController.h"
#import "THBaseNavView.h"
//定义四个视图控制器
#define ViewControllers @[@"THHomeViewController", @"THResourceViewController", @"THGuideViewController", @"THMineViewController"]
//标签 标题
#define Titles @[@"首页", @"电子资源", @"图书馆指南", @"我的"]
//标签 未选中图片
#define Images @[@"tabbar_picture@3x", @"tabbar_news@3x", @"tabbar_video@3x", @"tabbar_setting@3x"]
//标签 选中图片
#define SelectedImages @[@"tabbar_picture_hl@3x", @"tabbar_news_hl@3x", @"tabbar_video_hl@3x", @"tabbar_setting_hl@3x"]
@interface THMainViewController ()

@end

@implementation THMainViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //调用创建标签页方法
    [self createViewController];
    
   

}

#pragma mark 创建标签页
- (void)createViewController
{
    NSMutableArray *vcs = [NSMutableArray array];
    
    //循环创建四个视图控制
    for (int i = 0; i < ViewControllers.count; i ++) {
        
        //1 独立的News、Find、、、VC
        THRootViewController *rvc = [[NSClassFromString(ViewControllers[i]) alloc] init];
        
        //2 使用第一步的VC创建NVC(NavigationController)
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:rvc];
        
        //  将图片保持原色
        UIImage *image = [[UIImage imageNamed:Images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        UIImage *selectdImage = [[UIImage imageNamed:SelectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //  实现标签
        nc.tabBarItem = [[UITabBarItem alloc] initWithTitle:Titles[i] image:image selectedImage:selectdImage];
        
        
        //3 将NVC放入数组
        [vcs addObject:nc];
        
    }
    
    self.viewControllers = vcs;
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
