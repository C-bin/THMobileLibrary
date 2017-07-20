//
//  THReaderConstant.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THReaderConstant : NSObject
@property (nonatomic, copy) NSString *userName;


+(THReaderConstant *)shareReadConstant;
@end
