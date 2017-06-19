//
//  THTHBookListCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/19.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THTHBookListCell.h"
#import "UIImageView+WebCache.h"
@implementation THTHBookListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)configCellWithModel:(CZBookModel*)model{
   
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:model.bookImage] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
  
    self.bookname.text=model.bookName;
  
}
@end
