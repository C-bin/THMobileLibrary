//
//  THReaderConstant.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THReaderConstant.h"
static THReaderConstant *readerConstant;
@implementation THReaderConstant
+(THReaderConstant *)shareReadConstant{
    if (!readerConstant) {
        readerConstant =[[THReaderConstant alloc]init];
       
    }
    return readerConstant;
}
@end
