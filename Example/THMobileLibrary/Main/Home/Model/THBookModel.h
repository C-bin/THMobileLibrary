//
//  THBookModel.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THBookModel : NSObject

@property (copy, nonatomic) NSString *BookName;        //书名
@property (copy, nonatomic) NSString *FirstAuthor ;          //作者
@property (copy, nonatomic) NSString *PublishName ; //出版社
//@property (copy, nonatomic) NSString *isbn;            //ISBN
@property (copy, nonatomic) NSString *ChineseSort ;      //索书号

@end
