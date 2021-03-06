//
//  THAboutusViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/21.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THAboutusViewController.h"

@interface THAboutusViewController ()

@end

@implementation THAboutusViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    [self createNavgationBar];
    [self aboutUsView];
}

-(void)aboutUsView{
//    UIView *aboutUs=[[UIView alloc]initWithFrame:CGRectMake(15,100, SCREEN_WIDTH-30, SCREEN_HEIGHT-180)];
//    aboutUs.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色
//    aboutUs.layer.borderWidth = 1;//边框宽度
//    aboutUs.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:aboutUs];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2, 114, 60, 60)];
    imageView.image=[UIImage imageNamed:@"btn_opac.png"];
    imageView.layer.cornerRadius=15;
    [self.view addSubview:imageView];
    
//    UILabel *appName=[[UILabel alloc]initWithFrame:CGRectMake(75, 20, SCREEN_WIDTH-75, 20)];
//    appName.font=[UIFont systemFontOfSize:18];
//    appName.text=@"天海移动图书";
//    [aboutUs addSubview:appName];
    
    UILabel *versions=[[UILabel alloc]initWithFrame:CGRectMake(0,184, SCREEN_WIDTH, 20)];
    versions.font=[UIFont systemFontOfSize:14];
    versions.textColor=[UIColor lightGrayColor];
    versions.text=@"V 1.0.0";
    versions.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:versions];

    UILabel *brief=[[UILabel alloc]initWithFrame:CGRectMake(0, 214, SCREEN_WIDTH, 20)];
    brief.font=[UIFont systemFontOfSize:15];
    brief.textColor=[UIColor lightGrayColor];
    NSString *netAddress=@"http://www.hbthwl.net";
    brief.text=[NSString stringWithFormat:@"官网:%@",netAddress];
    brief.textAlignment=NSTextAlignmentCenter;
    brief.numberOfLines=0;
    [self.view addSubview:brief];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 244, SCREEN_WIDTH, 20)];
     brief.font=[UIFont systemFontOfSize:15];
    line.textColor=[UIColor lightGrayColor];
    line.text=@"客服电话:0311-8361820";
    line.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:line];

}

-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"关于我们"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
}
-(void)backtoHome{
    
    [self.navigationController popViewControllerAnimated:YES];
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
