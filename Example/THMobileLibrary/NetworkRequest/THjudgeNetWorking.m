//
//  THjudgeNetWorking.m
//  LTHNewspaper
//
//  Created by 天海网络 on 2017/3/8.
//  Copyright © 2017年 哒哒哒. All rights reserved.
//

#import "THjudgeNetWorking.h"

@implementation THjudgeNetWorking
 static THjudgeNetWorking* _instance = nil;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[THjudgeNetWorking alloc]init];
        
    });
    return _instance;
}
-(void)judgeNetWorkingWith:(netWorking)net{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        if (status == 0) {
//            NSLog(@"未连接网络");
            net(@"未连接网络");
        }
        if (status == 1) {
//            NSLog(@"3G/4G网络");
            net(@"3G/4G网络");
        }
        if (status == 2) {
//            NSLog(@"Wifi网络");
            net(@"Wifi网络");
        }
    }];
    
}
     
@end
