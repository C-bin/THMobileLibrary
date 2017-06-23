//
//  THDetailViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZBookModel.h"
@interface THDetailViewController : UIViewController
@property (nonatomic,copy) NSString *bookPicture;
@property (nonatomic,strong) CZBookModel *bookModel;



@end
