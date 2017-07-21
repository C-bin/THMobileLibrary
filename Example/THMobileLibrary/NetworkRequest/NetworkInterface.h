//
//  NetworkInterface.h
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/18.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#ifndef NetworkInterface_h
#define NetworkInterface_h
//图书馆编码  libraryCode
#define LIBRARYCODE       @"130000001"

//基础接口
#define BABSURL           @"http://www.thyhapp.com"

//图书馆
#define LBASEURL         [NSString stringWithFormat:@"%@:8091",BABSURL]

////公司
//#define CBASEURL       [NSString stringWithFormat:@"%@:8020",BABSURL]
//登录
#define ISLOGIN          [NSString stringWithFormat:@"%@/LoginService.asmx/Login",LBASEURL]

//功能列表
#define lISTURL          [NSString stringWithFormat:@"%@/BookInfoService.asmx",LBASEURL]

//搜索 查询
#define SEARCHURL        [NSString stringWithFormat:@"%@/GetBookInfo",lISTURL]
//新书推荐
#define NEWBOOKURL       [NSString stringWithFormat:@"%@/NewBookRecommend",lISTURL]

//借阅排行
#define RANKURL       [NSString stringWithFormat:@"%@/BookRank",lISTURL]

/***  读者信息  ***/
#define READERINFO       [NSString stringWithFormat:@"%@/UserInfoService.asmx",LBASEURL]

//正在借阅
#define BORROW           [NSString stringWithFormat:@"%@/GetCurrentBorrow",READERINFO]

//历史借阅
#define HISTORY          [NSString stringWithFormat:@"%@/GetHistoryBorrow",READERINFO]

//预约
#define ORDERBOOK        [NSString stringWithFormat:@"%@/GetOrderBook",READERINFO]

//个人信息
#define USERINFO         [NSString stringWithFormat:@"%@/GetUserInfo",READERINFO]

/**********************************************************************************************/

#define LibrarySystem       [NSString stringWithFormat:@"%@/News.asmx",LBASEURL]
//http://www.thyhapp.com:8091/News.asmx/GetNews
#define NEWS_URL         [NSString stringWithFormat:@"%@/GetNews",LibrarySystem]
//图书馆信息
#define LIBNOTE         [NSString stringWithFormat:@"%@/LibNote.asmx",LBASEURL]

#define LIBINFO        [NSString stringWithFormat:@"%@/LibInfo",LIBNOTE]

#endif /* NetworkInterface_h */
