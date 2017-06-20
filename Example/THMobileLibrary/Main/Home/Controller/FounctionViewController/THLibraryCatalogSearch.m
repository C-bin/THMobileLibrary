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
@interface THLibraryCatalogSearch ()<FSComboPickerViewDelegate,UISearchBarDelegate>{
    NSString *searchTitle;
}

@end

@implementation THLibraryCatalogSearch
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //导航栏
    [self createNavgationBar];
    //搜索选择
    [self createSearchBar];
}
-(void)createNavgationBar{
    //导航栏
    THBaseNavView *navView=[[THBaseNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) navTitle:@"馆藏查询"];
    [self.view addSubview:navView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 30, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
}
-(void)createSearchBar{
    self.searchView=[[UIView alloc]initWithFrame:CGRectMake(15, 100, self.view.frame.size.width-30, 60)];
    _searchView.backgroundColor=RGB(162, 229, 229);
    //将图层的边框设置为圆脚
    
    _searchView.layer.cornerRadius = 8;
    
    _searchView.layer.masksToBounds = YES;
    
    
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
                                                                               @"ISBN",
                                                                               @"索书号"]
                                                                       frame:CGRectMake(20, 110, 90, 40)];
    comboListView.delegate = self;
    comboListView.backgroundColor = RGB(14, 193, 194);
    comboListView.textColor = [UIColor whiteColor];
    
    return comboListView;
    
}
-(UITextField *)createTextField{
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(110, 110, self.view.frame.size.width-170, 40)];
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.placeholder = [NSString stringWithFormat:@"请输入出版社名称"];
    
    return _textField;
}
-(UIButton *)createButton{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(110+(self.view.frame.size.width-170), 110, 40, 40);
//    button.backgroundColor=RGB(239, 173, 14);
    [button setImage:[UIImage imageNamed:@"btn_opac.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchBook) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}
-(void)searchBook{
    
    
}

-(void)back{
    
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
