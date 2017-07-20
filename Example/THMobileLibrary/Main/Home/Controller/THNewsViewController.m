//
//  THNewsViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/15.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THNewsViewController.h"

@interface THNewsViewController ()

@end

@implementation THNewsViewController
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
    self.view.backgroundColor=RGB(242, 242, 242);
    
    //导航栏
    [self createNavgationBar];
    
    [self createNewsView];
}

-(void)createNewsView{
    
    UIView *newsView=[[UIView alloc]initWithFrame:CGRectMake(15,100, SCREEN_WIDTH-30, SCREEN_HEIGHT-180)];
    newsView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    newsView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    newsView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    newsView.layer.shadowRadius = 4;//阴影半径，默认3
    [self.view addSubview:newsView];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, newsView.frame.size.width-20, 30)];
    title.text=self.headline;
    title.font=[UIFont systemFontOfSize:18];
    [newsView addSubview:title];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, newsView.frame.size.width-20, newsView.frame.size.height-80)];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:18.f];
    textView.editable = NO; // 默认YES
    textView.text=self.content;
    
    [newsView addSubview:textView];
}

-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"系统公告"];
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


@end
