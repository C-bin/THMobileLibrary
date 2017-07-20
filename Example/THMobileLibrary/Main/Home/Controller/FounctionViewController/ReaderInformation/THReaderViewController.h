//
//  THReaderViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/18.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THReaderViewController : UIViewController
/* 登录名 */
@property (nonatomic,copy)NSString *UserName;
/* 真实姓名 */
@property (nonatomic,copy)NSString *RealName;
/* 性别 */
@property (nonatomic,copy)NSString *Sex;
/* 邮箱 */
@property (nonatomic,copy)NSString *Email;
/* 上次登陆时间 */
@property (nonatomic,copy)NSString *LastLoginTime;
/* 电话 */
@property (nonatomic,copy)NSString *Telephone;
/* 借阅次数 */
@property (nonatomic,copy)NSString *BorrowTimes;
/* 已借阅量 */
@property (nonatomic,copy)NSString *BorrowedCount;
/* 已预约量 */
@property (nonatomic,copy)NSString *OrderCount;
/* 超期图书 */
@property (nonatomic,copy)NSString *OverTimeCount;
/* 可借阅量*/
@property (nonatomic,copy)NSString *MaxBorrowedCount;
/* 我的地址 */
@property (nonatomic,copy)NSString *Address;

@end
