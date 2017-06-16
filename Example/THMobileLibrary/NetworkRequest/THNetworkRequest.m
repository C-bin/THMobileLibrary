//
//  THNetworkRequest.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THNetworkRequest.h"
#import "CZBookModel.h"
#define WEBSERVICEURL       @"http://101.201.116.210:7726/bookTypeAndSearch/queryBookList?bookType=&classificationId=&classificationNumber=&classificationType=&desc=0&keyword=&pageNum=%ld&pageSize=9&pageType=3&press=&rankType=1&upYearEndVal=&upYearStartVal=&yearEnd=&yearStart="

@implementation THNetworkRequest
-(NSMutableArray *)getBookList{
     NSMutableArray * books_Array =[[NSMutableArray alloc]init];
    //第一步，创建url
    
    NSString *get_url=[NSString stringWithFormat:WEBSERVICEURL];
    NSString *encodedURLString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)get_url,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
    
    NSURL *url = [NSURL URLWithString:encodedURLString];
    //第二步，创建请求
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError * json_error;
//    NSArray* bookarray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&json_error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&json_error];
 
    NSArray * books =[[dict objectForKey:@"data"] objectForKey:@"list"];
    [books_Array removeAllObjects];
    for (int i =0; i<books.count; i++) {
        NSDictionary * book =[books objectAtIndex:i];
        CZBookModel  *bookList =[[CZBookModel alloc]init];
        bookList.bookName = [book objectForKey:@"bookName"];
        bookList.id = [book objectForKey:@"id"];
        bookList.bookName = [NSString stringWithFormat:@"http://101.201.114.210/591/ebooks/%@",[[[book objectForKey:@"bookPictures"] objectAtIndex:0]objectForKey:@"filePath"]];
        
        [books_Array addObject:bookList];
    }
    return books_Array;
}
@end
