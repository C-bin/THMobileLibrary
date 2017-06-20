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

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
@interface THDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *mainCollectionView;
    NSMutableArray *detailArray;
    CGFloat height;
    NSString *downPath;
}


@end

@implementation THDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    detailArray=[[NSMutableArray alloc]init];
    [self createNavgationBar];
    
[self createDetailData];
    
}

-(void)createCollectionView{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width,44);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(100, 100);
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
//    [mainCollectionView registerClass:[CZCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
//    
//    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupplementaryViewHeaderIdentify];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    //    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    //轮播图
[self createDetailData];
    
}
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
-(void)createDetailData{
    NSString *baseString =[NSString stringWithFormat:@"http://101.201.116.210:7726/mobile/bookDetailById?bookId=%@",self.bookModel.bookid];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:baseString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
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
                model.filePath=[NSString stringWithFormat:@"http://101.201.114.210/591/ebooks/%@",[filesDic objectForKey:@"filePath"]];
             downPath=model.filePath;
                model.tableContent=[filesDic objectForKey:@"tableContent"];
             [self createDetailViewWithModel:model];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];

    
}

-(void)createDetailViewWithModel:(THDetaileModel *)model{
    [self.bookImage sd_setImageWithURL:[NSURL URLWithString:self.bookModel.bookImage] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _bookName.text=model.bookName;
    _bookName.font=[UIFont systemFontOfSize:18];
    _author.text=model.bookAuthor;
    _author.font=[UIFont systemFontOfSize:15];
    _publishingHouse.text=model.press;
    _publishingHouse.font=[UIFont systemFontOfSize:15];
    _isbn.text=model.isbn;
    _isbn.font=[UIFont systemFontOfSize:15];
    _fileFormat.text=[NSString stringWithFormat:@"文件格式：%@",model.fileExt];
    _fileFormat.font=[UIFont systemFontOfSize:15];
    
    NSLog(@"%@",model.filePath);
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 284, self.view.frame.size.width, 50)];
    labelOne.text = model.describe;
    labelOne.backgroundColor = [UIColor whiteColor];
    labelOne.font = [UIFont systemFontOfSize:20];
    labelOne.numberOfLines = 0;
    height = [UILabel getHeightByWidth:labelOne.frame.size.width title:labelOne.text font:labelOne.font];
    labelOne.frame = CGRectMake(10, 284, self.view.frame.size.width-20, height);
    [self.view addSubview:labelOne];
    
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 284+height, self.view.frame.size.width, self.view.frame.size.height-284-height)];
    textView.text=model.tableContent;
    textView.backgroundColor=[UIColor whiteColor];
     textView.font=[UIFont systemFontOfSize:18];
    //不可编辑状态
     textView.editable = NO;
    [self.view addSubview:textView];
    
}

- (IBAction)readNow:(id)sender {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:downPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
        
        
        pageView.resourceURL = filePath;    //文件位置
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            pageView.model = [LSYReadModel getLocalModelWithURL:filePath];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //            [_epubActivity stopAnimating];
                //            [_beginEpub setTitle:@"Beign epub Read" forState:UIControlStateNormal];
                //            [_beginEpub setEnabled:YES];
                
                [self presentViewController:pageView animated:YES completion:nil];
            });
        });
    }];
    [downloadTask resume];
    
   

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
