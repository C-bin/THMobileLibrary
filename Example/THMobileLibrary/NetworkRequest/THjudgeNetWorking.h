//
//  THjudgeNetWorking.h
//  LTHNewspaper
//
//  Created by 天海网络 on 2017/3/8.
//  Copyright © 2017年 哒哒哒. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^netWorking)(NSString*NET);

@interface THjudgeNetWorking : NSObject
+(instancetype) shareInstance;
//判断网络
-(void)judgeNetWorkingWith:(netWorking)net;
@end
