//
//  CZCollectionViewCell.m
//  CZReader
//
//  Created by Castiel Chen on 11/03/2017.
//  Copyright © 2017 1124835650@qq.com. All rights reserved.
//

#import "CZCollectionViewCell.h"
#import "CZBookModel.h"
#import "UIImageView+WebCache.h"
#define head_URL   @"http://101.201.114.210/591/ebooks/"

@implementation CZCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,140)];
       
        [_topImage setImage:[UIImage imageNamed:@"woshi.jpg"]];
        [self.contentView addSubview:_topImage];
        
        
        
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImage.frame.size.height+5,frame.size.width, 40)];
        _botlabel.textAlignment = NSTextAlignmentLeft;
        _botlabel.textColor = [UIColor blackColor];
        _botlabel.numberOfLines=0;
        _botlabel.font = [UIFont systemFontOfSize:15];
         self.botlabel.text=@"朱自清";
        [self.contentView addSubview:_botlabel];
    }

    
    return self;
}


-(void)configCellWithModel:(CZBookModel*)model{
//    [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.bookImage]];
     [self.topImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",head_URL,model.bookImage]]];
//    [self.topImage sd_se]
    self.botlabel.text=model.bookName;
//    self.bookId=model.id;
}

@end
