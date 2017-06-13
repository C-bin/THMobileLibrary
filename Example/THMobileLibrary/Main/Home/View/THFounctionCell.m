//
//  THFounctionCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/13.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THFounctionCell.h"

@implementation THFounctionCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-40)/2, 10, 40,40)];
        
        [_topImage setImage:[UIImage imageNamed:@"热门话题.png"]];
        [self.contentView addSubview:_topImage];
        
        
        
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImage.frame.size.height+5,frame.size.width, 20)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor blackColor];
        _botlabel.numberOfLines=0;
        _botlabel.font = [UIFont systemFontOfSize:15];
        self.botlabel.text=@"朱自清";
        [self.contentView addSubview:_botlabel];
    }
    
    
    return self;
}

@end
