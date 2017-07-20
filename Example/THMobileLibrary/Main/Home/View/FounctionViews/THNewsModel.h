//
//  THNewsModel.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THNewsModel : NSObject
@property (copy, nonatomic) NSString *QNickName;        //书名
@property (copy, nonatomic) NSString *QTitle;          //作者
@property (copy, nonatomic) NSString *QContent; //出版社
@property (copy, nonatomic) NSString *AddTime;            //ISBN
@property (copy, nonatomic) NSString *ModifyTime;      //索书号
@end
