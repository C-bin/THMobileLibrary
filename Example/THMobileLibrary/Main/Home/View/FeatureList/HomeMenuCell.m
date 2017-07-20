//
//  HomeMenuCell.m
//  meituan
//
//  Created by lujh on 15/6/30.
//  Copyright (c) 2015年 lujh. All rights reserved.
//
// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define navigationBarColor RGB(33, 192, 174)

#import "HomeMenuCell.h"
@interface HomeMenuCell ()<UIScrollViewDelegate>

@end

@implementation HomeMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSArray *)menuArray{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

         self.menuArray =@[@"馆藏查询",@"新书推荐",@"借阅排行",@"扫一扫",@"读者信息",@"我的书架",@"正在借阅",@"历史借阅"];self.imageArray=@[@"inquire.png",@"recommend.png",@"rank.png",@"scan.png",@"reader.png",@"bookshelf.png",@"Borrow.png",@"history.png"];
        
        // 初始化cell布局
        [self setUpSubViews];
        
    }
    return self;
}

#pragma mark -初始化cell布局

- (void)setUpSubViews {

    // 轮播图第一页
    _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 120)];
    [self addSubview:_backView1];

    //创建8个view
    for (int i = 0; i < 8; i++) {
        if (i < 4) {
            CGRect frame = CGRectMake(i*(screen_width-50)/4+10+i*10, 0, (screen_width-50)/4, 50);
            NSString *title = [_menuArray objectAtIndex:i];
            NSString *imageStr = [_imageArray objectAtIndex:i];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            
            // 点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneView:)];
            [btnView addGestureRecognizer:tap];
            
        }else if(i<8){
            CGRect frame = CGRectMake((i-4)*(screen_width-50)/4+10+(i-4)*10, 60, (screen_width-50)/4, 50);
            NSString *title = [_menuArray objectAtIndex:i];
            NSString *imageStr = [_imageArray objectAtIndex:i];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            
            // 点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneView:)];
            [btnView addGestureRecognizer:tap];
        }
    }
    
  
}

#pragma mark -手势点击事件

-(void)tapOneView:(UITapGestureRecognizer *)sender{
    
    
    if ([self.onTapBtnViewDelegate respondsToSelector:@selector(OnTapBtnView:)]) {
        
        [self.onTapBtnViewDelegate OnTapBtnView:sender];
    }
    
}

#pragma mark - UIScrollViewDelegate



@end
