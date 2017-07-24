//
//  THDetailViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZBookModel.h"
#import "THHomeViewController.h"
#import "THDetaileModel.h"
@interface THDetailViewController : UIViewController
@property (nonatomic,copy) NSString *bookPicture;
@property (nonatomic,copy) NSString *bookURL;
@property (nonatomic,strong) CZBookModel *bookModel;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic, strong) THProgressHUD* progressHUD;
@property (nonatomic,strong) THDetaileModel  *detaile;
@property (nonatomic,copy) NSString *typeVC;
@end
