//
//  THMineViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THMineViewController.h"
#import "THBaseNavView.h"
@interface THMineViewController ()

@end

@implementation THMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"我的"];
    [self.view addSubview:navView];
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
