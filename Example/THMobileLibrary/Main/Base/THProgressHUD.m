//
//  THProgressHUD.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/11.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THProgressHUD.h"

@implementation THProgressHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _isAnimating = NO;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width,frame.size.height-10)];
        [self addSubview:_imageView];
        //设置动画帧
        _imageView.animationImages=[NSArray arrayWithObjects:
                                   [UIImage imageNamed:@"loading1"],
                                   [UIImage imageNamed:@"loading2"],
                                   [UIImage imageNamed:@"loading3"],
                                   [UIImage imageNamed:@"loading4"],
                                   [UIImage imageNamed:@"loading5"],
                                   [UIImage imageNamed:@"loading6"],
                                   [UIImage imageNamed:@"loading7"],
                                   nil ];
        
        
        _Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        _Infolabel.backgroundColor = [UIColor clearColor];
        _Infolabel.textAlignment = NSTextAlignmentCenter;
        //        Infolabel.textColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
        //        Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:14.0f];
        [self addSubview:_Infolabel];
        self.layer.hidden = YES;
    }
    return self;
}


- (void)startAnimation
{
    _isAnimating = YES;
    self.layer.hidden = NO;
    [self doAnimation];
}

-(void)doAnimation{
    
    _Infolabel.text = @"正在加载";
    _Infolabel.textColor = [UIColor lightGrayColor];
    _Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:8.0f];
    //设置动画总时间
    _imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    _imageView.animationRepeatCount=0;
    //开始动画
    [_imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
{
    _isAnimating = NO;
    _Infolabel.text = text;
    if(type){
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [_imageView stopAnimating];
            self.layer.hidden = YES;
            self.alpha = 1;
        }];
    }else{
        [_imageView stopAnimating];
        
    }
    
}


@end
