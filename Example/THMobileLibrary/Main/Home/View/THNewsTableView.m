//
//  THNewsTableView.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/15.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THNewsTableView.h"
#import "THNewsModel.h"
#import "THTableViewCell.h"
@interface THNewsTableView (){
    NSMutableArray * dataArray;
    NSInteger page;
}


@end
@implementation THNewsTableView

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url type:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self) {
        dataArray=[[NSMutableArray alloc]init];
        page=0;
       self.separatorStyle = UITableViewCellSeparatorStyleNone;
       self.delegate = self;
       self.dataSource = self;
      [self getDataArrayWithURL:url type:type];
    }
    return self;
}
-(void)getDataArrayWithURL:(NSString *)urlstring type:(NSString *)type{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:urlstring];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"type=%@&page=%ld&pageCount=20",type,page] dataUsingEncoding:NSUTF8StringEncoding];
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //   解析数据
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in array) {
            THNewsModel *newsModel  =[[THNewsModel alloc]init];
            [newsModel setValuesForKeysWithDictionary:dic];
            
            [dataArray addObject:newsModel];
            
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self reloadData];
            
        });
    }];
    //7.执行任务
    [dataTask resume];
 
    
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    THTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil) {
        cell = [[THTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
    }
    THNewsModel *model=dataArray[indexPath.row];
    cell.textLabel.text=model.QTitle;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor whiteColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    THNewsModel *model=dataArray[indexPath.row];
    NSLog(@"选中didSelectRowAtIndexPath row = %@", model.QContent );
    
      NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
     [center postNotificationName:@"newsMessage" object:model.QTitle userInfo:@{@"Value": model.QContent}];

    

    
   
    
}


@end
