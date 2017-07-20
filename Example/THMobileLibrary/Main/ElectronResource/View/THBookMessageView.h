//
//  THBookMessageView.h
//  Label自适应高度
//
//  Created by 天海网络  on 2017/6/22.
//  Copyright © 2017年 天海网络 . All rights reserved.
//
//@property (nonatomic,copy) NSString *describe;
//@property (copy, nonatomic) NSString *bookName;        //书名
//@property (copy, nonatomic) NSString *bookAuthor;          //作者
//@property (copy, nonatomic) NSString *press; //出版社
//@property (copy, nonatomic) NSString *isbn;            //ISBN
//@property (copy, nonatomic) NSString *fileExt;      //文件格式
////@property (copy, nonatomic) NSString *description ;      //内容介绍
////@property (nonatomic, strong) NSString *description;
//@property (copy, nonatomic) NSString *tableContent;   //目录内容
//@property (copy, nonatomic) NSString *filePath;   //下载路径
#import <UIKit/UIKit.h>
#import "THDetaileModel.h"
@interface THBookMessageView : UIView
@property (strong, nonatomic) UIImageView *bookImage;
@property (strong, nonatomic) UILabel *bookName;
@property (strong, nonatomic) UILabel *bookAuthor;
@property (strong, nonatomic) UILabel *press;
@property (strong, nonatomic) UILabel *isbn;
@property (strong, nonatomic) UILabel *fileExt;

-(void)configCellWithModel:(THDetaileModel *)model;
@end
