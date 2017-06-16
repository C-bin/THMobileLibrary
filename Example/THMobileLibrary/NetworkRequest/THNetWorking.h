//
//  THNetWorking.h
//  LTHNewspaper
//
//  Created by 天海网络 on 2017/3/16.
//  Copyright © 2017年 哒哒哒. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^successBlock)(NSURLSessionDataTask * task,id responseObject);
typedef void(^failureBlock)(NSURLSessionDataTask * task,NSError * error);


@interface THNetWorking : NSObject

+(instancetype)sharedNetworkingTool;
    
-(void)POSTWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(successBlock)success failure:(failureBlock)failure;
    
@end
