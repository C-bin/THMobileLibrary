//
//  THLibraryCatalogSearch.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNewsTableView.h"
#import "THAnnouncementTableView.h"
@interface THLibraryCatalogSearch : UIViewController
@property(nonatomic,strong)UIView *searchView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic, strong) UISegmentedControl *segmentCtrl;

@property (nonatomic, strong) UIScrollView *scrollView;
@end
