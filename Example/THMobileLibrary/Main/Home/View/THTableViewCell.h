//
//  THTableViewCell.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/15.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CZBookModel.h"
@interface THTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *label;
-(void)configCellWithModel:(CZBookModel *)model;
@end
