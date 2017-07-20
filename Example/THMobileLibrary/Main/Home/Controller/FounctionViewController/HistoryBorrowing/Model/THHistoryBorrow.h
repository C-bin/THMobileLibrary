//
//  THHistoryBorrow.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THHistoryBorrow : NSObject
@property (copy, nonatomic) NSString *Bookid;
@property (copy, nonatomic) NSString *Barcode;  //条码号
@property (copy, nonatomic) NSString *Bookname;
@property (copy, nonatomic) NSString *Borrowtime;  //借阅日期
@property (copy, nonatomic) NSString *Actualtime;  //归还日期
@end
