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

//我的图书馆接口
#define MYLIBRARY       [NSString stringWithFormat:@"%@/MyLibraryService.asmx/MyLibrary",LBASEURL]

//OPAC查询
#define GETBOOKINFO     [NSString stringWithFormat:@"%@/SearchBookInfoService.asmx/GetBookInfo",LBASEURL]
//是否在馆
#define GETISBORROWED   [NSString stringWithFormat:@"%@/SearchBookInfoService.asmx/GetIsBorrowed",LBASEURL]

//续借
#define ISRENEWAL       [NSString stringWithFormat:@"%@/RenewService.asmx/IsReNewal",LBASEURL]

//图书馆须知
#define NOTICELIST      [NSString stringWithFormat:@"%@/NoticeService.asmx/searchNoticeList",CBASEURL]

//龙源期刊  Periodical
#define PERIODICAL       @"http://zhstsg.vip.qikan.com"

//重置密码
#define UPDATEPSW       [NSString stringWithFormat:@"%@/UpdatePswService.asmx/ChangePsw",CBASEURL]

//信息核实
#define FINDPSW         [NSString stringWithFormat:@"%@/FindPswService.asmx/findPsw",LBASEURL]

//确认修改
#define FINDOFPSW       [NSString stringWithFormat:@"%@/FindOfPswService.asmx/FindOfPsw",CBASEURL]

//出入记录
#define GETRECORD       [NSString stringWithFormat:@"%@/SearchSchoolInOutService.asmx/GetRecord",LBASEURL]

//验证卡号真实性
#define ISEXIST         [NSString stringWithFormat:@"%@/LoginService.asmx/IsExist",LBASEURL]

//注册
#define SAVEUSERINFO    [NSString stringWithFormat:@"%@/RegisterService.asmx/SaveUserInfo",CBASEURL]



//管理个人信息   http://www.thyhapp.com:8020/UserInfoUpdateService.asmx/SearchInfo
#define SEARCHINFO      [NSString stringWithFormat:@"%@/UserInfoUpdateService.asmx/SearchInfo",CBASEURL]

//更改个人信息  http://www.thyhapp.com:8020/UserInfoUpdateService.asmx/UpdateInfo
#define UPDATEINFO      [NSString stringWithFormat:@"%@/UserInfoUpdateService.asmx/UpdateInfo",CBASEURL]



#endif /* NetworkInterface_h */
