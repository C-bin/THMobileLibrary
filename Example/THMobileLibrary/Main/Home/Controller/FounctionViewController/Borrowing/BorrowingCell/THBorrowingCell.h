//
//  THBorrowingCell.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/21.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THBorrowModel.h"
@interface THBorrowingCell : UITableViewCell
@property (strong, nonatomic) UILabel *BookName;        //书名
@property (strong, nonatomic) UILabel *Borrowtime ;      //借阅日期
@property (strong, nonatomic) UILabel *Actualtime ;      //归还日期

-(void)configCellWithModel:(THBorrowModel *)model;
@end
