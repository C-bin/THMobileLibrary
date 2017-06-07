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
@interface THHomeViewController ()

@end

@implementation THHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:navView];
    LoopBanner *loop = [[LoopBanner alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 200) scrollDuration:3.f];
    [self.view addSubview:loop];
    loop.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    loop.clickAction = ^(NSInteger index) {
        
    };
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