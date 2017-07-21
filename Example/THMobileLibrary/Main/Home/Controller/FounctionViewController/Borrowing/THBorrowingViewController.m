//
//  THBorrowingViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THBorrowingViewController.h"
#import "THBorrowModel.h"
#import "THBorrowingCell.h"
@interface THBorrowingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *borrowArray;
  
}


@end

@implementation THBorrowingViewController
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
    borrowArray=[[NSMutableArray alloc]init];
   //导航栏
    [self createNavgationBar];
    [self getBorrowingDataArray];
    [self createTableView];
   
}

-(void)getBorrowingDataArray{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:BORROW];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"username=%@",[THReaderConstant shareReadConstant].userName] dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //   解析数据
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        for (NSDictionary *dic in array) {
            THBorrowModel *borrow  =[[THBorrowModel alloc]init];
            
            [borrow setValuesForKeysWithDictionary:dic];
//            NSLog(@"-------------%@",[dic objectForKey:@"BookName"]);
            [borrowArray addObject:borrow];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });

        
    }];
    //7.执行任务
    [dataTask resume];
    
}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    NSLog(@"didCompleteWithError33333--%@",[NSThread currentThread]);
    _tableView.backgroundColor=RGB(242, 242, 242);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
/* 这个函数是指定显示多少cells*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return borrowArray.count;
}
//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    THBorrowingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[THBorrowingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    THBorrowModel *model=borrowArray[indexPath.row];
    [cell configCellWithModel:model];
    cell.backgroundColor=RGB(242, 242, 242);
    NSLog(@"-------------%@",model.BookName);
    
    return cell;
    
}
// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //    CZBookModel *model=dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *bookName=borrowArray[indexPath.row];
    NSLog(@"选中 = %@",bookName);
    
}
-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"正在借阅"];
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
