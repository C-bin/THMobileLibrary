//
//  THGuideView.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/5.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THGuideView.h"

@implementation THGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        UIImageView *mapImage=[[UIImageView alloc]init];
        mapImage.frame=self.bounds;
        
        mapImage.image=[UIImage imageNamed:@"mapImage.jpg"];
        mapImage.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:mapImage];
        
        [self createGuideView];
    }
    return self;
}

-(void)createGuideView{
    
//    UIImageView *imageView=[UIImageView alloc]initWithImage:<#(nullable UIImage *)#> highlightedImage:<#(nullable UIImage *)#>
    
}

@end
