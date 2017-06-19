//
//  THAnnouncementTableView.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/15.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THAnnouncementTableView.h"
#import "CZBookModel.h"
#import "THTableViewCell.h"
#import "THNewsViewController.h"
@interface THAnnouncementTableView() {
    
    NSMutableArray *dataArray;
}

@end

@implementation THAnnouncementTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        dataArray=[[NSMutableArray alloc]init];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
        
        //        self.bounces = NO;
        [self getDataArray];
    }
    return self;
}
-(void)getDataArray{
    //入参直接拼接在URL后（？衔接），多个入参用&分割
    NSString *urlstring=@"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?bookType=&classificationId=&classificationNumber=&classificationType=&desc=0&keyword=&pageNum=6&pageSize=20&pageType=3&press=&rankType=1&upYearEndVal=&upYearStartVal=&yearEnd=&yearStart=";
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //获取的内容是字符串
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * books =[[dict objectForKey:@"data"] objectForKey:@"list"];
        //        [dataArray removeAllObjects];
        NSLog(@"--------*********%ld",books.count);
        for (int i =0; i<books.count; i++) {
            NSDictionary * book =[books objectAtIndex:i];
            CZBookModel  *paperiteam =[[CZBookModel alloc]init];
            paperiteam.bookName = [book objectForKey:@"bookName"];
            
            
            NSLog(@"--------*********%@",paperiteam.bookName);
            [dataArray addObject:paperiteam];
            
            
        }
        dispatch_async(dispatch_get_main_queue(),^{
            
            //更新界面
            [self reloadData];
            
        });
    }];
    [dataTask resume];
    
    NSLog(@"--------%@*********",dataArray);
    
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    THTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil) {
        cell = [[THTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
    }
    CZBookModel *model=dataArray[indexPath.row];
    cell.textLabel.text=model.bookName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CZBookModel *model=dataArray[indexPath.row];
    NSLog(@"选中didSelectRowAtIndexPath row = %@", model.bookName);
    
}



@end
