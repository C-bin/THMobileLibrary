//
//  THPersonalInformation.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/6.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THPersonalInformation.h"
#import "CZBookModel.h"
#import "THPersonalCell.h"
@interface THPersonalInformation (){
    
        NSArray * dataArray;
   
}

@end


@implementation THPersonalInformation

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       dataArray=@[@"个人信息",@"借阅信息"];
       
        self.delegate = self;
        self.dataSource = self;
//        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.separatorColor = [UIColor redColor];
  
    }
    return self;
}

-(void)getDataArray{
//    //入参直接拼接在URL后（？衔接），多个入参用&分割
//    NSString *urlstring=@"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?bookType=&classificationId=&classificationNumber=&classificationType=&desc=0&keyword=&pageNum=1&pageSize=9&pageType=3&press=&rankType=1&upYearEndVal=&upYearStartVal=&yearEnd=&yearStart=";
//    
//    NSURL *url = [NSURL URLWithString:urlstring];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        //获取的内容是字符串
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSArray * books =[[dict objectForKey:@"data"] objectForKey:@"list"];
//        
//        for (int i =0; i<books.count; i++) {
//            NSDictionary * book =[books objectAtIndex:i];
//            CZBookModel  *paperiteam =[[CZBookModel alloc]init];
//            paperiteam.bookName = [book objectForKey:@"bookName"];
//            
//            [dataArray addObject:paperiteam];
//            
//            
//        }
//        dispatch_async(dispatch_get_main_queue(),^{
//            
//            //更新界面
//            [self reloadData];
//            
//        });
//    }];
//    [dataTask resume];
    
    
    
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    THPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil) {
        cell = [[THPersonalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
    }
     cell.backgroundColor = [UIColor clearColor];
//    CZBookModel *model=dataArray[indexPath.row];
    cell.textLabel.text=dataArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"user_icon@2x.png"];
//箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
    
}
// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
}

@end
