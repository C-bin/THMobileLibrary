//
//  THUserInfoView.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/19.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THUserInfoView.h"
#define HMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HMRandomColor HMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@implementation THUserInfoView

-(id)initWithFrame:(CGRect)frame Array:(NSArray *)headArray InfoArray:(NSMutableArray *)infoArray{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<12; i++) {
           
            NSString *info=[NSString stringWithFormat:@"%@",[infoArray objectAtIndex:i]];
            NSString *str=[NSString stringWithFormat:@"%@: %@",[headArray objectAtIndex:i],info];
            
            UILabel *label=[self getHeightByWidth:CGRectMake(10, self.frame.size.height/15*(i+1), self.frame.size.width-20, self.frame.size.height/15) title:str font:[UIFont systemFontOfSize:18] info:info];
            if (SCREEN_WIDTH==320) {
                if (i==10) {
                    label=[self getHeightByWidth:CGRectMake(10, self.frame.size.height/15*(i+1), self.frame.size.width-20, self.frame.size.height/15*2) title:str font:[UIFont systemFontOfSize:18] info:info];
                }
                if (i==11) {
                    label=[self getHeightByWidth:CGRectMake(10, self.frame.size.height/15*(i+2), self.frame.size.width-20, self.frame.size.height/16*2) title:str font:[UIFont systemFontOfSize:18] info:info];
                }
            }
           
            [self addSubview:label];
            
        }
        
        
            }
    return self;
}

- (UILabel *)getHeightByWidth:(CGRect)frame title:(NSString *)title font:(UIFont *)font info:(NSString *)info
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
//    label.numberOfLines = 0;
//    [label sizeToFit];

   label.lineBreakMode = NSLineBreakByWordWrapping; //根据单词进行换行
     label.numberOfLines = 0;
    [label sizeToFit];
//    [self.view addSubview:textLabel];
//    label.backgroundColor=[UIColor whiteColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:@" "].location + 1;
   
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(firstLoc,info.length)];
    // 为label添加Attributed
    [label setAttributedText:noteStr];

    return label;
}

@end
