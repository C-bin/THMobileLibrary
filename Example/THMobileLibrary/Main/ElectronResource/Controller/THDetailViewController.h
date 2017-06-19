//
//  THDetailViewController.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZBookModel.h"
@interface THDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;   //图书图片
@property (nonatomic,copy) NSString *bookPicture;
@property (nonatomic,strong) CZBookModel *bookModel;
@property (weak, nonatomic) IBOutlet UILabel *bookName;        //书名
@property (weak, nonatomic) IBOutlet UILabel *author;          //作者
@property (weak, nonatomic) IBOutlet UILabel *publishingHouse; //出版社
@property (weak, nonatomic) IBOutlet UILabel *isbn;            //ISBN
@property (weak, nonatomic) IBOutlet UILabel *fileFormat;      //文件格式


@end
