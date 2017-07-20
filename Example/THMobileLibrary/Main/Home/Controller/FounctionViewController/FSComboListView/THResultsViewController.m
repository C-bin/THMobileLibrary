//
//  THResultsViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/10.
//  Copyright © 2017年 C-bin. All rights reserved.
//


#import "THResultsViewController.h"
#import "THSearchTableViewCell.h"
#import "THBookModel.h"
@interface THResultsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArray;
     NSInteger page;
}

@end

@implementation THResultsViewController
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

    self.view.backgroundColor=[UIColor whiteColor];
    dataArray=[[NSMutableArray alloc]init];
    page=0;
    [self createNavBar];
    
    _progressHUD = [[THProgressHUD alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-40, 80, 80)];
    [self.view addSubview:_progressHUD];
    [_progressHUD startAnimation];
    
    [self getDataArrayByURL];
    [self createTableView];
  
}
-(void)createNavBar{
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"查询结果"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
}
-(void)getDataArrayByURL{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:SEARCHURL];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"category=题名&cateValue=%@&author=&publisher=&pageCount=20&page=%ld",self.searchTitle,(long)page] dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        [dataArray removeAllObjects];
        //        //8.解析数据
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in arr) {
            THBookModel *bookModel  =[[THBookModel alloc]init];
            [bookModel setValuesForKeysWithDictionary:dic];
            [dataArray addObject:bookModel];
          
        }

        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [_progressHUD stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                [self createTableView];
            }
         [_tableView.mj_header endRefreshing];
         [_tableView.mj_footer endRefreshing];
        });
    }];
    //7.执行任务
    [dataTask resume];

}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH-20, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 110;
     [self.view addSubview:_tableView];
    
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(uppull)];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downPull)];
}

-(void)uppull{
   
    [dataArray removeAllObjects];
    [self getDataArrayByURL];
//    [_tableView reloadData];
    
    // 结束刷新
    //    [mainCollectionView.mj_header endRefreshing];
}
-(void)downPull{
    page++;
    [self getDataArrayByURL];
    // 结束刷新
    //    [mainCollectionView.mj_footer endRefreshing];
}
/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    THSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[THSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    THBookModel *model=dataArray[indexPath.row];
    [cell configCellWithModel:model];
    cell.backgroundColor=[UIColor clearColor];

    NSLog(@"-------------%@",model.BookName);
    return cell;
    
}
// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    CZBookModel *model=dataArray[indexPath.row];
    NSLog(@"选中didSelectRowAtIndexPath row = %@", dataArray[indexPath.row]);
    
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
