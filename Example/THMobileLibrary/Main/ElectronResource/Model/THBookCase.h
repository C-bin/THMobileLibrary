//
//  THBookCase.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THDetaileModel.h"
@interface THBookCase : NSObject

//书架中的书籍信息
@property(strong,nonatomic)NSMutableArray * books;

+(THBookCase *)shareBookShelf;
//归档到书架
-(void)encodeBook:(THDetaileModel*)book;
-(void)decoderBooks;
@end
