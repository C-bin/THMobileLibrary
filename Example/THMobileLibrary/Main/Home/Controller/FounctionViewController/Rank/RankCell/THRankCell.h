//
//  THRankCell.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THBookModel.h"
@interface THRankCell : UITableViewCell
@property (strong, nonatomic) UILabel *BookName;        //书名
@property (strong, nonatomic) UILabel *FirstAuthor ;          //作者
@property (strong, nonatomic) UILabel *PublishName ; //出版社
//@property (copy, nonatomic) NSString *isbn;            //ISBN
@property (strong, nonatomic) UILabel *ChineseSort ;      //索书号
-(void)configCellWithModel:(THBookModel *)model;
@end
