//
//  THReaderViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/18.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THReaderViewController.h"
#import "THUserInfoView.h"
@interface THReaderViewController (){
    NSMutableArray *infoArray;
}

@end

@implementation THReaderViewController
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
    infoArray=[[NSMutableArray alloc]init];
    self.view.backgroundColor=RGB(237, 237, 239);
   
    _progressHUD = [[THProgressHUD alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-40, 80, 80)];
    [self.view addSubview:_progressHUD];
     //导航栏
    [_progressHUD startAnimation];
    [self createNavgationBar];
    [self getReaderInfo];
  
}

-(void)createInfoViewWithArray:(NSArray *)headArray InfoArray:(NSMutableArray *)info{
    THUserInfoView *infoView=[[THUserInfoView alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, SCREEN_HEIGHT-164) Array:headArray InfoArray:info];
    infoView.backgroundColor=[UIColor whiteColor];
    infoView.layer.cornerRadius=10;
    infoView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    infoView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    infoView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    infoView.layer.shadowRadius = 4;//阴影半径，默认3
    
    [self.view addSubview:infoView];
    
}

-(void)getReaderInfo{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
  
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://www.thyhapp.com:8091/UserInfoService.asmx/GetUserInfo"];
//    http://www.thyhapp.com:8091/UserInfoService.asmx/GetUserInfo
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
//    NSLog(@"-%@",name);
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserName=%@",[THReaderConstant shareReadConstant].userName] dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
  dispatch_sync(dispatch_get_main_queue(), ^{
        //   解析数据
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSMutableArray *arr1 =[[NSMutableArray alloc]init];
//
        for (NSDictionary *dic in array)
        {
            if ([dic objectForKey:@"UserName"]) {
                
//                NSString *SchoolID  = [dic objectForKey:@"SchoolID"];
                self.UserName       = [dic objectForKey:@"UserName"];
                self.RealName       = [dic objectForKey:@"RealName"];
                self.Email          = [dic objectForKey:@"Email"];
                self.Sex            = [dic objectForKey:@"Sex"];
                self.Address        = [dic objectForKey:@"Address"];
                self.BorrowTimes    = [dic objectForKey:@"BorrowTimes"];
                self.LastLoginTime  = [dic objectForKey:@"LastLoginTime"];
                self.LastLoginTime=[self.LastLoginTime stringByReplacingOccurrencesOfString:@"T"withString:@" "];
                self.Telephone      = [dic objectForKey:@"Telephone"];
                
            }else if ([dic objectForKey:@"BorrowedCount"] ){
              self.BorrowedCount    =[dic objectForKey:@"BorrowedCount"];
              self.OrderCount       =[dic objectForKey:@"OrderCount"];
              self.OverTimeCount    =[dic objectForKey:@"OverTimeCount"];
              self.MaxBorrowedCount =[dic objectForKey:@"MaxBorrowedCount"];

            }
        }
      
      
      [infoArray addObject:self.UserName];
      [infoArray addObject:self.RealName];
      [infoArray addObject:self.Sex];
      [infoArray addObject:self.Email];
      [infoArray addObject:self.Telephone];
      [infoArray addObject:self.MaxBorrowedCount];
      [infoArray addObject:self.BorrowTimes];
      [infoArray addObject:self.BorrowedCount];
      [infoArray addObject:self.OrderCount];
      [infoArray addObject:self.OverTimeCount];
      [infoArray addObject:self.LastLoginTime];
      [infoArray addObject:self.Address];
    
      NSArray *headArray=@[@"登录名",@"真实姓名",@"性别",@"电子邮箱",@"电话",@"可借阅量",@"借阅次数",@"已借阅量",@"已预约量",@"超期图书",@"上次登录时间",@"我的地址"];
    
    
  [self createInfoViewWithArray:headArray InfoArray:infoArray];
       [_progressHUD stopAnimationWithLoadText:@"finish" withType:YES];//加载成功

  });
    }];
    //7.执行任务
    [dataTask resume];
    
}

-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"个人信息"];
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
