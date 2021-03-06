//
//  CZCollectionViewCell.m
//  CZReader
//
//  Created by Castiel Chen on 11/03/2017.
//  Copyright © 2017 1124835650@qq.com. All rights reserved.
//

#import "CZCollectionViewCell.h"
#import "CZBookModel.h"
@implementation CZCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.width*1.2)];
        _topImage.layer.shadowOpacity=0.8;
        _topImage.layer.shadowRadius=4;
        _topImage.layer.shadowOffset=CGSizeMake(2, 2);
        _topImage.layer.shadowColor=[UIColor grayColor].CGColor;
        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImage.frame.size.height+5,frame.size.width, 40)];
        _botlabel.textAlignment = NSTextAlignmentLeft;
        _botlabel.textColor = [UIColor blackColor];
        _botlabel.numberOfLines=0;
        _botlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_botlabel];
    }

    
    return self;
}


-(void)configCellWithModel:(CZBookModel*)model{
   [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.bookImage] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.botlabel.text=model.bookName;
//    self.bookId=model.bookid;
}

@end
