//
//  THGuideViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THRootViewController.h"

@interface THGuideViewController : THRootViewController
@property (copy, nonatomic) NSString *SchoolIntro;  //本馆简介
@property (copy, nonatomic) NSString *SchoolName;
@property (copy, nonatomic) NSString *SchoolRule; //读者须知
@property (copy, nonatomic) NSString *WorkTime;  //开馆时间
@property (copy, nonatomic) NSString *BorrowCard;  //办证指南
@property (nonatomic, strong) THProgressHUD* progressHUD;
@end
