//
//  THProgressHUD.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/11.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THProgressHUD : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *Infolabel;
@property (nonatomic, readonly) BOOL isAnimating;


- (id)initWithFrame:(CGRect)frame;


- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
@end
