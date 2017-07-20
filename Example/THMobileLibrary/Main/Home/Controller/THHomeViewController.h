//
//  THHomeViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/7.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THRootViewController.h"
#import "BHInfiniteScrollView.h"
#import "HomeMenuCell.h"
#import "THNewsTableView.h"
#import "THNewsViewController.h"
#import "THLibraryCatalogSearch.h"
#import "THNewBookViewController.h"
#import "THScanningViewController.h"
@interface THHomeViewController : THRootViewController
@property (nonatomic, strong) UISegmentedControl *segmentCtrl;

@property (nonatomic, strong) UIScrollView *scrollView;
@end
