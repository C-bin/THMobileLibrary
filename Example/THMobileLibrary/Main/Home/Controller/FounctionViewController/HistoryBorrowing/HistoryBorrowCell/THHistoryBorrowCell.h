//
//  THHistoryBorrowCell.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THHistoryBorrow.h"
@interface THHistoryBorrowCell : UITableViewCell
@property (strong, nonatomic) UILabel *BookName;        //书名
@property (strong, nonatomic) UILabel *Borrowtime ;      //借阅日期
@property (strong, nonatomic) UILabel *Actualtime ;      //归还日期

-(void)configCellWithModel:(THHistoryBorrow *)model;
@end
