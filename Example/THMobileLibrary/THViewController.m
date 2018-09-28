//
//  THViewController.m
//  THMobileLibrary
//
//  Created by C-bin on 06/07/2017.
//  Copyright (c) 2017 C-bin. All rights reserved.
//

#import "THViewController.h"

@interface THViewController ()

@end

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"新功能开发工作流");
    /* 基于master分支，创建develop分支
    
    
    
    切换到master分支
    $git checkout master
     基于master分支克隆develop分支，并在克隆完毕后直接跳转到develop分支
    $git checkout -b develop
     推送develop分支到远程仓库
    $git push origin develop
    
    ---------------------
    
    本文来自 花開酒暖 的CSDN 博客 ，全文地址请点击：https://blog.csdn.net/zsm180/article/details/75291260?utm_source=copy
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
