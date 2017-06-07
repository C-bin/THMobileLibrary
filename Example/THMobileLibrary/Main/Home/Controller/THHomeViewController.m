//
//  THHomeViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THHomeViewController.h"
#import "THBaseNavView.h"
@interface THHomeViewController ()

@end

@implementation THHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:navView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
