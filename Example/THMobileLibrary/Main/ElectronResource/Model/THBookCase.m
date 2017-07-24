//
//  THBookCase.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THBookCase.h"
#define BOOKSHELF_ENCODER_KEY @"books_shelf"
#define BOOKSHELF_ENCODER_PATH @"/bookShelf.plist"
@implementation THBookCase
+(THBookCase *)shareBookShelf{
    static THBookCase *bookConstant;
    if (!bookConstant) {
        bookConstant =[[THBookCase alloc]init];
        [bookConstant decoderBooks];
    }
    return bookConstant;
}

//归档图书到书架2
-(void)encodeBook:(THDetaileModel*)book {
    //解档
    [self decoderBooks];
    //检查书架是否有书
    if (!self.books) {
        self.books=[[NSMutableArray alloc]init];
    }
    //过滤掉重复的书
    for (int i =0; i<self.books.count; i++) {
        THDetaileModel *book_tmp= [self.books objectAtIndex:i];
        
        if ([book_tmp.bookid isEqualToString:book.bookid]) {
           [self.books removeObjectAtIndex:i];
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"书架中已经存在" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
        }
    }
    
    [self.books addObject:book];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"成功加入书架" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [alert show];
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *bookArrPath = [paths stringByAppendingString:BOOKSHELF_ENCODER_PATH];
    [NSKeyedArchiver archiveRootObject:self.books toFile:bookArrPath];
    
}

-(void)decoderBooks{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *bookArrPath = [paths stringByAppendingString:BOOKSHELF_ENCODER_PATH];
    self.books=[NSKeyedUnarchiver unarchiveObjectWithFile:bookArrPath];
    
}
@end
