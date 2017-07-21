//
//  THBorrowModel.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/21.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THBorrowModel : NSObject
@property (copy, nonatomic) NSString *BookID;
@property (copy, nonatomic) NSString *Barcode;  //条码号
@property (copy, nonatomic) NSString *BookName;
@property (copy, nonatomic) NSString *BorrowTime;  //借阅日期
@property (copy, nonatomic) NSString *GiveBackTime;  //归还日期
@end
