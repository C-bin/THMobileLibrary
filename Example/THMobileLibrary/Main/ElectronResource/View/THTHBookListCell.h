//
//  THTHBookListCell.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/19.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZBookModel.h"
@interface THTHBookListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookname;
-(void)configCellWithModel:(CZBookModel *)model;
@end
