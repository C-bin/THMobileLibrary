//
//  THNewBookViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/6.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THNewBookViewController.h"
#import "THSearchTableViewCell.h"
#import "THRankCell.h"
#import "THBookModel.h"
@interface THNewBookViewController ()<UITableViewDelegate,UITableViewDataSource>{
     NSMutableArray *newBookArray;
     NSInteger page;
}


@end

@implementation THNewBookViewController
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
    
    newBookArray=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    [self createNavgationBar];
    _progressHUD = [[THProgressHUD alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-40, 80, 80)];
    [self.view addSubview:_progressHUD];
    [_progressHUD startAnimation];
    page=0;
    [self getnewBookDataArray];
    [self createTableView];
    
}
-(void)getnewBookDataArray{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:NEWBOOKURL];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"page=%ld&pageCount=10",page] dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //   解析数据
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in array) {
            THBookModel *bookModel  =[[THBookModel alloc]init];
            [bookModel setValuesForKeysWithDictionary:dic];
            
            [newBookArray addObject:bookModel];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
             [_progressHUD stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
            
        });
    }];
    //7.执行任务
    [dataTask resume];
    
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGB(242, 242, 242);
    [self.view addSubview:_tableView];
}
/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newBookArray.count;
}
//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    THRankCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[THRankCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    THBookModel *model=newBookArray[indexPath.row];
    [cell configCellWithModel:model];
    cell.backgroundColor=RGB(242, 242, 242);
    return cell;
    
}
// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //    CZBookModel *model=dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *bookName=newBookArray[indexPath.row];
    NSLog(@"选中 = %@",bookName);
    
}
-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"新书推荐"];
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
