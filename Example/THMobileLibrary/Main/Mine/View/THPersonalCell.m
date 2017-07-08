//
//  THPersonalCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/6.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THPersonalCell.h"
#import "CZBookModel.h"

@interface THPersonalCell (){
//    UIImageView *_imageView;
}

@end

@implementation THPersonalCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI{
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60, 30)];
    self.label.font = [UIFont boldSystemFontOfSize:16];
    self.label.textColor=RGB(196, 197, 196);
    [self.contentView addSubview:self.label];
    self.iconView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 30, 30)];
    [self.contentView addSubview:self.iconView];
    
    
}


@end
