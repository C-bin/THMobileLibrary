//
//  THBaseNavView.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THBaseNavView.h"
#define RGB(R,G,B)          [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
@implementation THBaseNavView

- (instancetype)initWithFrame:(CGRect)frame navTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:RGB(14, 193, 194)];
        UILabel *navTitle=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-80)/2, 32, 80, 20)];
        
        
        navTitle.textAlignment=NSTextAlignmentCenter;
        navTitle.text=title;
        
        navTitle.font=[UIFont systemFontOfSize:18];
        
        
        [self addSubview:navTitle];
       
    }
    return self;
}


@end
