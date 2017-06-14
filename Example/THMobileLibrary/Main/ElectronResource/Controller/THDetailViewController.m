//
//  THDetailViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/14.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THDetailViewController.h"

@interface THDetailViewController ()


@end

@implementation THDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_bookImage setImage:[UIImage imageNamed:@"woshi.jpg"]];
    
    _bookName.text=@"我是名人";
    _bookName.font=[UIFont systemFontOfSize:18];
    _author.text=@"卡卡西";
    _author.font=[UIFont systemFontOfSize:15];
    _publishingHouse.text=@"木叶出版";
    _publishingHouse.font=[UIFont systemFontOfSize:15];
    _isbn.text=@"978-7-227-04462-8";
    _isbn.font=[UIFont systemFontOfSize:15];
    _fileFormat.text=@"epub";
    _fileFormat.font=[UIFont systemFontOfSize:15];
    _price.text=@"¥14.50";
    _price.font=[UIFont systemFontOfSize:15];
    
}
- (IBAction)readNow:(id)sender {
    
    NSLog(@"》》》》》》》》》》》》》开始阅读");
    
    
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
