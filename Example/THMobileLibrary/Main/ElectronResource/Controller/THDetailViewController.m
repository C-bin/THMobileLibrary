//
//  THDetailViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THDetailViewController.h"
#import "THBaseNavView.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
@interface THDetailViewController ()


@end

@implementation THDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"图书详情"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
    
//    [_bookImage setImage:[UIImage imageNamed:self.bookPicture]];
   [self.bookImage sd_setImageWithURL:[NSURL URLWithString:self.bookPicture] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _bookName.text=@"我是名人";
    _bookName.font=[UIFont systemFontOfSize:18];
    _author.text=@"卡卡西";
    _author.font=[UIFont systemFontOfSize:15];
    _publishingHouse.text=@"木叶出版";
    _publishingHouse.font=[UIFont systemFontOfSize:15];
    _isbn.text=@"978-7-227-04462-8";
    _isbn.font=[UIFont systemFontOfSize:15];
    _fileFormat.text=@"epub";
    _fileFormat.font=[UIFont systemFontOfSize:15];
    _price.text=@"¥14.50";
    _price.font=[UIFont systemFontOfSize:15];
    
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)readNow:(id)sender {
    
    NSLog(@"》》》》》》》》》》》》》开始阅读");
    
    
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
