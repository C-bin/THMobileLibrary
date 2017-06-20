//
//  THBaseNavView.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THBaseNavView.h"

@implementation THBaseNavView

- (instancetype)initWithFrame:(CGRect)frame navTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:RGB(14, 193, 194)];
        UILabel *navTitle=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2, 32, 100, 20)];
        
        
        navTitle.textAlignment=NSTextAlignmentCenter;
        navTitle.text=title;
        
        navTitle.font=[UIFont systemFontOfSize:18];
        
        
        [self addSubview:navTitle];
       
    }
    return self;
}


@end
