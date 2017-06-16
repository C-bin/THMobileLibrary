//
//  THNetWorking.m
//  LTHNewspaper
//
//  Created by 天海网络 on 2017/3/16.
//  Copyright © 2017年 哒哒哒. All rights reserved.
//

#import "THNetWorking.h"

@implementation THNetWorking

    +(instancetype)sharedNetworkingTool{
        
        static THNetWorking * instance;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[THNetWorking alloc]init];
        });
        return instance;
        
    }
    
    -(void)POSTWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(successBlock)success failure:(failureBlock)failure{
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
        //如果返回的就是二进制数据，那么采用默认二进制的方式来解析数据
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        //采用JSON的方式来解析数据
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //请求超时
        manager.requestSerializer.timeoutInterval = 30.0;
        
        [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (responseObject) {
                //            NSArray* result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
                success(task,responseObject);
            }else{
                DLog(@"返回的数据出现问题");
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failure(task,error);
        }];

    }
    
@end
