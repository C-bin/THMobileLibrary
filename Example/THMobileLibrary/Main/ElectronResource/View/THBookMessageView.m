//
//  THBookMessageView.m
//  Label自适应高度
//
//  Created by 天海网络  on 2017/6/22.
//  Copyright © 2017年 天海网络 . All rights reserved.
//



#import "THBookMessageView.h"

@implementation THBookMessageView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUIWith:frame];
    }
    
    
    return self;
}

-(void)setupUIWith:(CGRect)frame{
//    CGFloat height;
    CGFloat opinX=10;
    //图书图片
    _bookImage  = [[UIImageView alloc] initWithFrame:CGRectMake(15, opinX, 100,130)];
    _bookImage.layer.shadowOpacity=0.8;
    _bookImage.layer.shadowRadius=4;
    _bookImage.layer.shadowOffset=CGSizeMake(2, 2);
    _bookImage.layer.shadowColor=[UIColor grayColor].CGColor;
    [self addSubview:_bookImage];
    //书名
    _bookName = [[UILabel alloc] initWithFrame:CGRectMake(_bookImage.frame.size.width+30, opinX,frame.size.width-_bookImage.frame.size.width-30, 20)];
    _bookName.textAlignment = NSTextAlignmentLeft;
    _bookName.textColor = [UIColor blackColor];
    _bookName.numberOfLines=0;
    _bookName.font = [UIFont systemFontOfSize:17];
    [self addSubview:_bookName];
//    作者
    _bookAuthor = [[UILabel alloc] initWithFrame:CGRectMake(_bookImage.frame.size.width+30,opinX+30 ,frame.size.width-_bookImage.frame.size.width-30, 15)];
    _bookAuthor.textAlignment = NSTextAlignmentLeft;
    _bookAuthor.textColor = [UIColor blackColor];
    _bookAuthor.font = [UIFont systemFontOfSize:14];
    [self addSubview:_bookAuthor];
    
    
//    出版社
    _press = [[UILabel alloc] initWithFrame:CGRectMake(_bookImage.frame.size.width+30,opinX+50 ,frame.size.width-_bookImage.frame.size.width-30, 15)];
    _press.textAlignment = NSTextAlignmentLeft;
    _press.textColor = [UIColor blackColor];
    _press.font = [UIFont systemFontOfSize:14];
    [self addSubview:_press];
    
    
    
//    ISBN
    
    _isbn = [[UILabel alloc] initWithFrame:CGRectMake(_bookImage.frame.size.width+30,opinX+70 ,frame.size.width-_bookImage.frame.size.width-30, 15)];
    _isbn.textAlignment = NSTextAlignmentLeft;
    _isbn.textColor = [UIColor blackColor];
    _isbn.font = [UIFont systemFontOfSize:14];
    [self addSubview:_isbn];
    
    
//    文件格式
    _fileExt = [[UILabel alloc] initWithFrame:CGRectMake(_bookImage.frame.size.width+30,opinX+90 ,frame.size.width-_bookImage.frame.size.width-30, 15)];
    _fileExt.textAlignment = NSTextAlignmentLeft;
    _fileExt.textColor = [UIColor blackColor];
    _fileExt.font = [UIFont systemFontOfSize:14];
    [self addSubview:_fileExt];
    
    
}

-(void)configCellWithModel:(THDetaileModel *)model{
    
    
    [self.bookImage sd_setImageWithURL:[NSURL URLWithString:model.bookImage] placeholderImage:[UIImage imageNamed:@"000000.jpg"]];
    self.bookName.text=model.bookName;
    self.bookAuthor.text=model.bookAuthor;
    self.press.text=model.press;
    self.isbn.text=model.isbn;
    self.fileExt.text=model.fileExt;

}

@end
