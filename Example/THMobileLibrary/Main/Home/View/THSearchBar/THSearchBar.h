//
//  THSearchBar.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THSearchBar : UISearchBar
@property (nonatomic,strong) UIColor *cursorColor;//光标颜色
@property (nonatomic,strong) UITextField *searchBarTextField;//搜索框TextField
@property (nonatomic,assign) BOOL hideSearchBarBackgroundImage;//隐藏SearchBar背景灰色部分 默认显示
@property (nonatomic,strong) UIButton *cancleButton;//取消按钮 showsCancelButton = YES 才能获取到
@end
