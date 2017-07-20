//
//  THNewsTableView.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/15.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
// @protocol THNewsDelegate <NSObject>
//
//-(void)newsWithHeadline:(NSString *)headline content:(NSString *)content;
//
// @end

@interface THNewsTableView : UITableView<UITableViewDelegate, UITableViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url type:(NSString *)type;
//@property(strong , nonatomic) id<THNewsDelegate> delegate;
@end
