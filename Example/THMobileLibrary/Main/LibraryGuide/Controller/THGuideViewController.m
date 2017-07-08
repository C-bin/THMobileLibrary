//
//  THGuideViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THGuideViewController.h"
#import "THBaseNavView.h"
#import "THGuideView.h"
/***********************************************************
 **  图书馆指南
 **********************************************************/
@interface THGuideViewController ()

@end
#define Guide_HEIGHT [UIScreen mainScreen].bounds.size.height/3-64
#define MAP_HEIGHT [UIScreen mainScreen].bounds.size.height/3

@implementation THGuideViewController
//http://192.168.1.4:8080/newsWeb/EnterWelcome.action
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImage *image=[UIImage imageNamed:@"3787527286718810832.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:image];
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"图书馆指南"];
    [self.view addSubview:navView];
    [self createGuideView];
    [self createImageView];
    [self createLabel];
}
-(void)createImageView{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 104+Guide_HEIGHT, SCREEN_WIDTH-60, 20)];
    label.text=@"地理位置:";
    [self.view addSubview:label];
    THGuideView *mapView=[[THGuideView alloc]initWithFrame:CGRectMake(30, 144+Guide_HEIGHT, SCREEN_WIDTH-60, MAP_HEIGHT)];
    mapView.layer.cornerRadius = 10;
    
    mapView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    mapView.layer.borderWidth = 5;
    
    mapView.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
    
    [self.view addSubview:mapView];

    
}
-(void)createGuideView{
    
    UIView *instructionsView=[[UIView alloc]initWithFrame:CGRectMake(30, 84, SCREEN_WIDTH-60, Guide_HEIGHT)];
    instructionsView.backgroundColor=[UIColor colorWithRed:250/255.0 green:252/255.0 blue:251/255.0 alpha:0.6];
    
    [self.view addSubview:instructionsView];
    
    
}
-(void)createLabel{

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 164+Guide_HEIGHT+MAP_HEIGHT, SCREEN_WIDTH-60, 20)];
    label.text=@"公交路线:";
    [self.view addSubview:label];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
