//
//  THGuideViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THGuideViewController.h"
#import "THGuideView.h"
#import "THLibMessageViewController.h"
#import "THLibMessageModel.h"

#define Guide_HEIGHT 90
#define MAP_HEIGHT [UIScreen mainScreen].bounds.size.height/3
#define imageArray @[@"简介.png",@"办证.png",@"须知.png",@"时间.png"]
#define titleArray @[@"本馆简介",@"办证指南",@"读者须知",@"开馆时间"]
/***********************************************************
 **  图书馆指南
 *************************三国*********************************/
@interface THGuideViewController (){
     NSMutableArray *libMessage;
}

@end

@implementation THGuideViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    libMessage=[[NSMutableArray alloc]init];
   
    self.view.backgroundColor=RGB(242, 242, 242);
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64) navTitle:@"图书馆指南"];
    [self.view addSubview:navView];
   
    [self getLibMessageData];
    
}

-(void)getLibMessageData{
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:LIBINFO];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = nil;
    
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //   解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
      
             self.SchoolIntro=[dic objectForKey:@"SchoolIntro"];
             self.SchoolRule=[dic objectForKey:@"SchoolRule"];
             self.WorkTime=[dic objectForKey:@"WorkTime"];
             self.BorrowCard=[dic objectForKey:@"BorrowCard"];
            
             [libMessage addObject:self.SchoolIntro];
             [libMessage addObject:self.BorrowCard];
             [libMessage addObject:self.SchoolRule];
             [libMessage addObject:self.WorkTime];
     
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self createGuideView];
            [self createImageView];
            [self createLabel];
            
        });
    }];
    //7.执行任务
    [dataTask resume];
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
    
    
    for (int i=0; i<4; i++) {
        UIButton*butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(i*(instructionsView.frame.size.width/4), 0, instructionsView.frame.size.width/4, Guide_HEIGHT);
      
        [butt setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(getLibInfo:) forControlEvents:UIControlEventTouchUpInside];
        butt.tag =30+i;
        [instructionsView addSubview:butt];
        
    }
}

-(void)getLibInfo:(UIButton *)btn{
    
    THLibMessageViewController *libVC=[[THLibMessageViewController alloc]init];
    libVC.navtitle=[titleArray objectAtIndex:(btn.tag-30)];
    libVC.headline=[titleArray objectAtIndex:(btn.tag-30)];
    libVC.content=[libMessage objectAtIndex:(btn.tag-30)];
    [self.navigationController pushViewController:libVC animated:NO];
    
}
-(void)createLabel{

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 164+Guide_HEIGHT+MAP_HEIGHT, SCREEN_WIDTH-60, 20)];
    label.text=@"公交路线:";
    [self.view addSubview:label];
    
    UILabel *way=[[UILabel alloc]initWithFrame:CGRectMake(30, 194+Guide_HEIGHT+MAP_HEIGHT, SCREEN_WIDTH-60, 20)];
    way.backgroundColor=[UIColor whiteColor];
    way.text=@"30路、36路、43路、51路、60路、85路";
    [self.view addSubview:way];

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
