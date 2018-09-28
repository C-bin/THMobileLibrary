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
    /*
     
     1. 主要分支介绍
     1.1 master分支
     1.2 develop分支
     1.3 release分支
     1.4 bugfix分支
     1.5 feature分支
     
     
     2. 新功能开发工作流
     2.1 切换到本地仓库工作区
     2.2 从远程仓库克隆代码到本地仓库
     2.3 基于master分支，创建develop分支
     2.4 在本地仓库的开发流程
     2.5 推送代码到远程仓库
     2.6 将代码发布到测试分支
     2.7 测试工程师提交Bug后修复
     2.8 测试工作完成后，合并代码到develop分支
     2.9 开发工作和测试工作都完毕后，发布时将develop分支合并到主线
     2.10 阶段开发完毕，打一个里程碑Tag包
     
     
     3. 发布后的产品Bug修复工作流
     3.1 获取Bug产品的软件发布版本号
     3.2 查找里程碑Tag
     3.3 基于里程碑Tag创建分支
     3.4 修复代码后可以查询修改过的地方
     3.5 修复完毕后分别合并到develop分支和master分支
     3.6 创建新的里程碑Tag
     3.7 删除bugfix分支
     
     
     4. 日常开发过程中常用操作
     4.1 撤销操作
     4.1.1 提交后发现丢了几个文件没有提交
     4.1.2 撤销上一次的提交，但是保留暂存区和当前修改不变
     4.1.3 撤销上一次的提交和暂存区修改，仅保留当前修改不变
     4.1.4 撤销上一次的提交，并丢弃所有修改，包括暂存区和当前目录中的修改，整体回档到上上次的提交
     4.1.5 撤销暂存区和当前目录下所有文件的修改，整体回档到上一次提交
     4.1.6 将文件提交到暂存区后撤回
     4.1.7 撤销对文件的修改
     
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
