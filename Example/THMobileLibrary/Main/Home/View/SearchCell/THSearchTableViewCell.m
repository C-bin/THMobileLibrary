//
//  THSearchTableViewCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THSearchTableViewCell.h"
#define CELL_WIDTH        self.frame.size.width
@implementation THSearchTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI{
    
    self.BookName=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, CELL_WIDTH-20, 20)];
    self.BookName.font = [UIFont boldSystemFontOfSize:18];
    self.BookName.textColor=[UIColor blackColor];
    self.BookName.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.BookName];
    
    self.FirstAuthor=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, CELL_WIDTH-20, 20)];
    self.FirstAuthor.font = [UIFont boldSystemFontOfSize:14];
    self.FirstAuthor.textColor=[UIColor blackColor];
    self.FirstAuthor.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.FirstAuthor];
    
    self.PublishName=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, CELL_WIDTH-120, 20)];
    self.PublishName.font = [UIFont boldSystemFontOfSize:14];
    self.PublishName.textColor=[UIColor blackColor];
    self.PublishName.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.PublishName];
    
    self.ChineseSort=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 100, 20)];
    self.ChineseSort.font = [UIFont boldSystemFontOfSize:14];
    self.ChineseSort.textColor=[UIColor blackColor];
    self.ChineseSort.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.ChineseSort];
    
   }
-(void)configCellWithModel:(THBookModel *)model{
  
    self.BookName.text=model.BookName;
    self.FirstAuthor.text=[NSString stringWithFormat:@"作者:%@",model.FirstAuthor];
    self.PublishName.text=[NSString stringWithFormat:@"出版社:%@",model.PublishName];
    self.ChineseSort.text=[NSString stringWithFormat:@"索书号:%@",model.ChineseSort];
    
}


@end
