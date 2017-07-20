//
//  THResultsViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/10.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THResultsViewController : UIViewController
@property (nonatomic, strong) THProgressHUD* progressHUD;
@property (nonatomic,copy) NSString *searchTitle;
@property (nonatomic,strong)UITableView *tableView;
@end
