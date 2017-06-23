//
//  THDetaileModel.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/19.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THDetaileModel : NSObject

@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *bookImage;
@property (copy, nonatomic) NSString *bookName;        //书名
@property (copy, nonatomic) NSString *bookAuthor;          //作者
@property (copy, nonatomic) NSString *press; //出版社
@property (copy, nonatomic) NSString *isbn;            //ISBN
@property (copy, nonatomic) NSString *fileExt;      //文件格式
//@property (copy, nonatomic) NSString *description ;      //内容介绍
//@property (nonatomic, strong) NSString *description;
@property (copy, nonatomic) NSString *tableContent;   //目录内容
@property (copy, nonatomic) NSString *filePath;   //下载路径
@end
