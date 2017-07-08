//
//  THLibraryCatalogSearch.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/20.
//  Copyright © 2017年 C-bin. All rights reserved.
//


#import "THLibraryCatalogSearch.h"
#import "FSComboListView.h"
/*
 ********************馆藏查询
 */
@interface THLibraryCatalogSearch ()<FSComboPickerViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>{
    NSString *searchTitle;
}

@end

@implementation THLibraryCatalogSearch
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    [self createNavgationBar];
    //搜索选择
    [self createSearchBar];
//    //加载Segment
    [self settingSegment];
//
//    //加载ScrollView
    [self settingScrollView];
}
-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"馆藏查询"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backtoHome) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
}
-(void)createSearchBar{
    self.searchView=[[UIView alloc]initWithFrame:CGRectMake(15, 64, self.view.frame.size.width-30, 60)];
    _searchView.backgroundColor=RGB(162, 229, 229);
    //将图层的边框设置为圆脚
    
    _searchView.layer.cornerRadius = 8;
    
    _searchView.layer.masksToBounds = YES;
    [ [ [ UIApplication  sharedApplication ]  keyWindow ] addSubview : self.searchView ] ;
    [self.view addSubview:self.searchView];
    [self.view addSubview:[self setupComboListView]];
    [self.view addSubview:[self createTextField]];
    [self.view addSubview:[self createButton]];
}
- (FSComboListView *)setupComboListView
{
    FSComboListView *comboListView = [[FSComboListView alloc] initWithValues:@[@"出版社",
                                                                               @"题名",
                                                                               @"作者",
                                                                               @"ISBN"]
                                                                              
                                                                       frame:CGRectMake(20, 74, 90, 40)];
    comboListView.delegate = self;
    comboListView.backgroundColor = RGB(14, 193, 194);
    comboListView.textColor = [UIColor whiteColor];
    
    return comboListView;
    
}
-(UITextField *)createTextField{
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(110, 74, self.view.frame.size.width-135, 40)];
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.placeholder = [NSString stringWithFormat:@"请输入出版社名称"];
    
    return _textField;
}
-(UIButton *)createButton{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(110+(self.view.frame.size.width-170), 74, 40, 40);
//    button.backgroundColor=RGB(239, 173, 14);
    [button setImage:[UIImage imageNamed:@"btn_opac.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchBook) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}
-(void)searchBook{
    [self.textField resignFirstResponder];
    NSLog(@"搜索书籍");
}

-(void)backtoHome{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) comboboxOpened:(FSComboListView *)combobox
{
    NSLog(@"comboboxOpened");
}

- (void) comboboxClosed:(FSComboListView *)combobox
{
    NSLog(@"comboboxClosed");
}
- (void) comboboxChanged:(FSComboListView *)combobox toValue:(NSString *)toValue
{
    _textField.placeholder = [NSString stringWithFormat:@"请输入%@名称",toValue];
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

#pragma mark -  新书推荐／热门图书  UISegmentedControl

- (void)settingSegment{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"新书推荐",@"热门图书",nil];
    //1.初始化UISegmentedControl
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentCtrl.frame=CGRectMake(20, 180, self.view.frame.size.width-40, 40);
    
    segmentCtrl.selectedSegmentIndex = 0;
    //2.segmentCtrl字体大小，颜色
    [segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGB(223, 163, 17)} forState:UIControlStateNormal];
    [segmentCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //2.segmentCtrl 背景颜色
    segmentCtrl.tintColor = RGB(223, 163, 17);
    [segmentCtrl addTarget:self action:@selector(segmentBtnClick:) forControlEvents:UIControlEventValueChanged];
    _segmentCtrl = segmentCtrl;
    [self.view addSubview:segmentCtrl];
    [self.textField resignFirstResponder];
    
}
//segmentCtrl 点击事件
- (void)segmentBtnClick:(UISegmentedControl *)segmentCtrl{
    [self.textField resignFirstResponder];
    self.scrollView.contentOffset = CGPointMake(self.segmentCtrl.selectedSegmentIndex * (SCREEN_WIDTH-40), 0);
}
#pragma mark - ScrollView  新书推荐／热门图书 列表
- (void)settingScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 250, SCREEN_WIDTH-40, SCREEN_HEIGHT-248)];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    scrollView.contentSize = CGSizeMake(2 *(SCREEN_WIDTH-40), 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    THNewBook *tableViewOne = [[THNewBook alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-40, SCREEN_HEIGHT-248)];
  
    THHotBook *tableViewTwo = [[THHotBook alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40,0, SCREEN_WIDTH-60, SCREEN_HEIGHT-248)];
   
    [scrollView addSubview:tableViewOne];
    [scrollView addSubview:tableViewTwo];
    [self.textField resignFirstResponder];
    _scrollView = scrollView;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    self.segmentCtrl.selectedSegmentIndex = offset/(SCREEN_WIDTH-40);
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
