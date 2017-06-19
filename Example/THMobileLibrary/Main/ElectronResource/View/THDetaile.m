//
//  THDetaile.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/19.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THDetaile.h"

@implementation THDetaile

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100,120)];
        
        [self addSubview:_topImage];
        
        
        
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImage.frame.size.height+10,frame.size.width, 20)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor blackColor];
        _botlabel.numberOfLines=0;
        _botlabel.font = [UIFont systemFontOfSize:15];
        self.botlabel.text=@"朱自清";
        [self addSubview:_botlabel];
    }
    
    
    return self;
}

@end
