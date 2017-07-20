//
//  THMainViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THMainViewController.h"
#import "THBaseNavView.h"
#import "THHomeViewController.h"
#import "THResourceViewController.h"
#import "THGuideViewController.h"
#import "THMineViewController.h"
//定义四个视图控制器

@interface THMainViewController ()

@end

@implementation THMainViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //调用创建标签页方法

    self.view.backgroundColor=[UIColor whiteColor];
    THHomeViewController *homeVC = [[THHomeViewController alloc]init];
    [self createVC:homeVC Title:@"首页" imageName:@"home.png"];
    
    THResourceViewController *resourceVC = [[THResourceViewController alloc]init];
    [self createVC:resourceVC Title:@"电子资源" imageName:@"resource.png"];
    
    THGuideViewController *guideVC = [[THGuideViewController alloc]init];
    [self createVC:guideVC Title:@"图书馆指南" imageName:@"guide.png"];
    
    THMineViewController *mineVC = [[THMineViewController alloc]init];
    [self createVC:mineVC Title:@"我的" imageName:@"mine.png"];

}
- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName
{
      vc.title = title;
    self.tabBar.tintColor = RGB(14, 193, 194);
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *imageSelect = [NSString stringWithFormat:@"light%@",imageName];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:vc]];
}
#pragma mark 创建标签页

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
