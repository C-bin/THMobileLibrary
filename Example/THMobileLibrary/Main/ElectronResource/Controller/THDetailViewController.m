//
//  THDetailViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THDetailViewController.h"
#import "THBaseNavView.h"
#import "UIImageView+WebCache.h"
#import "LSYReadPageViewController.h"
#import "UILabel+THLabelHeightAndWidth.h"
#import "THDetaileModel.h"
#import "THBookMessageView.h"
#import "THBookCase.h"
#import "THBookCaseViewController.h"
//#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define HEADER_URL @"http://101.201.114.210/591/ebooks/"
@interface THDetailViewController ()<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    CGFloat height;
    CGFloat list_heigh;
    NSMutableArray *detailArray;
    NSString *downPath;
}


@end

@implementation THDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化数据源
    self.view.backgroundColor=[UIColor whiteColor];
    detailArray=[[NSMutableArray alloc]init];
    [self createNavgationBar];
   
    [self createDetailDataWithURL:self.bookURL];
}

#pragma mark -创建导航栏
-(void)createNavgationBar{
        //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"图书详情"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -获取图书详情的网络请求
-(void)createDetailDataWithURL:(NSString *)url{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
             NSDictionary *dict=(NSDictionary *)responseObject;
             
             NSDictionary *data1=[dict objectForKey:@"data1"];

                 THDetaileModel  *model =[[THDetaileModel alloc]init];
                 model.bookName = [data1 objectForKey:@"bookName"];
                 model.bookAuthor = [data1 objectForKey:@"bookAuthor"];
                 model.press = [data1 objectForKey:@"press"];
                 model.isbn = [data1 objectForKey:@"isbn"];
                 model.describe=[data1 objectForKey:@"description"];
             NSArray *bookFiles=[data1 objectForKey:@"bookFiles"];
             NSDictionary *filesDic=[bookFiles objectAtIndex:0];
                model.fileExt=[filesDic objectForKey:@"fileExt"];
             self.fileName=[filesDic objectForKey:@"filePath"];
                model.filePath=[NSString stringWithFormat:@"http://101.201.114.210/591/ebooks/%@",[filesDic objectForKey:@"filePath"]];
             
                downPath=model.filePath;
             NSArray *pictures=[data1 objectForKey:@"bookPictures"];
             NSString *bookPicture=[[pictures objectAtIndex:0]objectForKey:@"filePath"];
             
             model.bookImage =[NSString stringWithFormat:@"%@%@",HEADER_URL,bookPicture];
            model.tableContent=[filesDic objectForKey:@"tableContent"];
             
             
            
             UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, SCREEN_WIDTH-20, 20)];
            
             labelOne.text =model.tableContent;
             labelOne.backgroundColor = [UIColor whiteColor];
             labelOne.font = [UIFont systemFontOfSize:15];
             labelOne.numberOfLines = 0;
             list_heigh= [UILabel getHeightByWidth:labelOne.frame.size.width title:labelOne.text font:labelOne.font];
             labelOne.frame = CGRectMake(10, 284+height, self.view.frame.size.width-20, list_heigh);
            [self createCollectionViewWithModel:model];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}
#pragma mark -创建UIScrollView
-(void)createCollectionViewWithModel:(THDetaileModel *)model{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_HEIGHT-64 )];
    scrollView.backgroundColor = [UIColor whiteColor];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT/3*2+list_heigh);
    // 是否反弹
    //        scrollView.bounces = YES;
    // 是否分页
    //        scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    //    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    //    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    
    //  当处于跟踪状态(tracking)时是否显示垂直状态条，默认值为YES。
    scrollView.showsVerticalScrollIndicator=NO;
    // 提示用户,Indicators flash
    [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    scrollView.directionalLockEnabled = YES;
    
    [self createDetailViewWithModel:model];
    
    //立即阅读，加入书架
    UIButton *addBookShell=[self buttonWithtitle:@"加入书架" frame:CGRectMake(SCREEN_WIDTH-30-(SCREEN_WIDTH-90)/2, 160, (SCREEN_WIDTH-90)/2, 40) action:@selector(clickBookShell)];
    [addBookShell setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBookShell.backgroundColor=RGB(229, 229, 229);
    [scrollView addSubview:addBookShell];
    UIButton *readNow=[self buttonWithtitle:@"立即阅读" frame:CGRectMake(30, 160, (SCREEN_WIDTH-90)/2, 40) action:@selector(clickRead)];
    [readNow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    readNow.backgroundColor=[UIColor orangeColor];
    [scrollView addSubview:readNow];
    
    [self bookDescriptionWithModel:model];
    [self bookListWithModelModel:model];
    [self.view addSubview:scrollView];
}

-(void)clickRead{
    
    
    _progressHUD = [[THProgressHUD alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-40, 80, 80)];
    [self.view addSubview:_progressHUD];
    [_progressHUD startAnimation];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:downPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        [THReaderConstant shareReadConstant].cacheFile=[filePath absoluteString];
        LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
        
       pageView.resourceURL = filePath;
            
            pageView.model = [LSYReadModel getLocalModelWithURL:filePath];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                  [_progressHUD stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
                [self presentViewController:pageView animated:YES completion:nil];
            });

      
    }];
    [downloadTask resume];
}
-(void)clickBookShell{
   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否加入书架" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
  
    [alert show];
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {//确定则注销
         [[THBookCase  shareBookShelf]encodeBook:_bookModel];
    }
    
}
#pragma mark -立即阅读／收藏
-(UIButton *)buttonWithtitle:(NSString *)title frame:(CGRect)frame action:(SEL)action{
    
    UIButton *iconbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [iconbtn setTitle:title forState:UIControlStateNormal];
    
    iconbtn.frame=frame;
    iconbtn.layer.cornerRadius = 0;//2.0是圆角的弧度，根据需求自己更改
    iconbtn.layer.borderColor = [UIColor clearColor].CGColor;//设置边框颜色
    iconbtn.layer.borderWidth = 1.0f;//设置边框

    [iconbtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return iconbtn;
}



#pragma mark -图书详情
-(void)createDetailViewWithModel:(THDetaileModel *)model{
//   model.bookImage=self.bookModel.bookImage;
    THBookMessageView *messageView=[[THBookMessageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [messageView configCellWithModel:model];
    [scrollView addSubview:messageView];
}
//生成一张毛玻璃图片
- (UIImage*)blur:(UIImage*)theImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}
#pragma mark -图书简介

-(void )bookDescriptionWithModel:(THDetaileModel *)model{
    
    //线
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(20, 209 , SCREEN_WIDTH-40, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line];
//    图书简介Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, SCREEN_WIDTH-40, 20)];
    titleLabel.text =@"图书简介";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor=[UIColor redColor];
    [scrollView addSubview:titleLabel];
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, SCREEN_WIDTH-40, 40)];
    labelOne.text =model.describe;
    labelOne.backgroundColor = [UIColor whiteColor];
    labelOne.font = [UIFont systemFontOfSize:16];
    labelOne.numberOfLines = 0;
    height= [UILabel getHeightByWidth:labelOne.frame.size.width title:labelOne.text font:labelOne.font];
    labelOne.frame = CGRectMake(20, 250, self.view.frame.size.width-40, height);
    [scrollView addSubview:labelOne];
}
#pragma mark -图书目录
-(void)bookListWithModelModel:(THDetaileModel *)model{
        //线
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(20, 259+height , SCREEN_WIDTH-40, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line];
    //  书目详情Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 270+height, SCREEN_WIDTH-40, 20)];
    titleLabel.text =@"书目详情";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor=[UIColor redColor];
    [scrollView addSubview:titleLabel];
    
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, SCREEN_WIDTH-40, 20)];
    labelOne.text =model.tableContent;
    labelOne.backgroundColor = [UIColor whiteColor];
    labelOne.font = [UIFont systemFontOfSize:14];
    labelOne.numberOfLines = 0;
    list_heigh= [UILabel getHeightByWidth:labelOne.frame.size.width title:labelOne.text font:labelOne.font];
    labelOne.frame = CGRectMake(20, 300+height, self.view.frame.size.width-40, list_heigh);
    [scrollView addSubview:labelOne];
    
}


- (IBAction)readNow:(id)sender {
    
   
    
   

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
