//
//  THBorrowingCell.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/21.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THBorrowingCell.h"
#define CELL_WIDTH        self.frame.size.width
@implementation THBorrowingCell

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
    
    self.Borrowtime=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, CELL_WIDTH-20, 20)];
    self.Borrowtime.font = [UIFont boldSystemFontOfSize:14];
    self.Borrowtime.textColor=[UIColor lightGrayColor];
    self.Borrowtime.textAlignment=NSTextAlignmentLeft;
    [view addSubview:self.Borrowtime];
    self.Actualtime=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, CELL_WIDTH-120, 20)];
    self.Actualtime.font = [UIFont boldSystemFontOfSize:14];
    self.Actualtime.textColor=[UIColor lightGrayColor];
    self.Actualtime.textAlignment=NSTextAlignmentLeft;
    [view addSubview:self.Actualtime];
    
    
}
-(void)configCellWithModel:(THBorrowModel *)model{
    
    self.BookName.text=model.BookName;
    self.Borrowtime.text=[NSString stringWithFormat:@"借阅日期:%@",model.BorrowTime];
    self.Actualtime.text=[NSString stringWithFormat:@"结束日期:%@",model.GiveBackTime];
    
}


@end
