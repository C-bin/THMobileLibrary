//
//  THTableViewCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/15.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THTableViewCell.h"

@implementation THTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI{
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width, 30)];
    self.label.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:self.label];
}
-(void)configCellWithModel:(THNewsModel *)model{
    
    self.label.text=model.QTitle;

}

@end
