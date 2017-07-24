//
//  THRankCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THRankCell.h"
#define CELL_WIDTH        self.frame.size.width
@implementation THRankCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=RGB(242, 242, 242);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 100)];
    view.backgroundColor=[UIColor whiteColor];
    //    view.layer.cornerRadius=10;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色
    
    view.layer.borderWidth = 1;//边框宽度
//    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
//    view.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    view.layer.shadowOpacity = 1;//阴影透明度，默认0
//    view.layer.shadowRadius = 3;//阴影半径，默认3
    [self addSubview:view];
    
    self.BookName=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, CELL_WIDTH-20, 20)];
    self.BookName.font = [UIFont boldSystemFontOfSize:18];
    self.BookName.textColor=[UIColor blackColor];
    self.BookName.textAlignment=NSTextAlignmentLeft;
    [view addSubview:self.BookName];
    
    self.FirstAuthor=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, CELL_WIDTH-20, 20)];
    self.FirstAuthor.font = [UIFont boldSystemFontOfSize:14];
    self.FirstAuthor.textColor=[UIColor blackColor];
    self.FirstAuthor.textAlignment=NSTextAlignmentLeft;
    [view addSubview:self.FirstAuthor];
    
    self.PublishName=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, CELL_WIDTH-20, 20)];
    self.PublishName.font = [UIFont boldSystemFontOfSize:14];
    self.PublishName.textColor=[UIColor blackColor];
    self.PublishName.textAlignment=NSTextAlignmentLeft;
    [view addSubview:self.PublishName];

    
}
-(void)configCellWithModel:(THBookModel *)model{
    
    self.BookName.text=model.BookName;
    self.FirstAuthor.text=[NSString stringWithFormat:@"作者:%@",model.FirstAuthor];
    self.PublishName.text=[NSString stringWithFormat:@"出版社:%@",model.PublishName];

}
@end
