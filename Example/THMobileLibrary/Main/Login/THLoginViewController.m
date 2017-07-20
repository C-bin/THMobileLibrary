//
//  THLoginViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/6.
//  Copyright © 2017年 C-bin. All rights reserved.
//
//http://www.thyhapp.com:8091/LoginService.asmx?op=Login

#import "THLoginViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import "UIImageView+WebCache.h"
#import "THMainViewController.h"

/**
 *  键盘出现frameY的改变值
 */
#define CHANGE_FRAME_VALUE 60

/**
 *  初始的frameY值
 */
#define ORIGIN_FRAMW_Y (self.view.frame.size.height-80)/2

/**
 *  播放器的音量值
 */
#define VOLUME_OF_PLAYER 0

/**
 *  输入框和登陆，注册按钮的高度
 */
#define HEIGHT_OF_FIELD 40
@interface THLoginViewController ()<UITextFieldDelegate>
/*** 视频播放器*/
@property(nonatomic,strong)AVPlayer *player;
/*** 播放视频的view*/
@property(nonatomic,strong)UIView *playerView;


/*** loginView覆盖在播放器上*/
@property(nonatomic,strong)UIView *loginView;
/*** 名字输入框*/
@property(nonatomic,strong)UITextField *nameField;
/*** 密码输入框*/
@property(nonatomic,strong) UITextField *passWordField;
/*** login按钮*/
@property(nonatomic,strong) UIButton *loginButton;
/*** signup按钮*/
@property(nonatomic,strong) UIButton *signupButton;
@end

@implementation THLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self createVideoPlayer];
    
    [self createLoginView];
    
    //两个监听键盘状态的通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];

}
/**
 *  创建VideoPlayer
 */
-(void)createVideoPlayer
{
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"];
    NSURL *pathUrl = [NSURL fileURLWithPath:videoPath];
    
    AVPlayerItem *videoItem = [[AVPlayerItem alloc] initWithURL:pathUrl];
    //[videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:videoItem];
    
    self.player.volume = VOLUME_OF_PLAYER;
    self.playerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.playerView];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    //    playerLayer.videoGravity = UIViewContentModeScaleToFill;
    playerLayer.frame = self.playerView.bounds;
    [self.playerView.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [self.player.currentItem addObserver:self forKeyPath:AVPlayerItemFailedToPlayToEndTimeNotification options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    
}
/**
 *  创建loginView
 */
-(void)createLoginView
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"pusername"];
    NSString *passWord=[userDefault objectForKey:@"password"];
    
    self.loginView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.loginView.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:0.3f];
    [self.view addSubview:self.loginView];
    //账号
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(50, ORIGIN_FRAMW_Y, self.view.frame.size.width - 100, HEIGHT_OF_FIELD)];
    self.nameField.backgroundColor = [UIColor colorWithRed:0.81f green:0.91f blue:0.94f alpha:0.5f];
    [self.loginView addSubview:self.nameField];
    self.nameField.layer.cornerRadius = 8;
    self.nameField.borderStyle = 0;
    self.nameField.delegate = self;
    self.nameField.text = name;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameField.keyboardType = UIKeyboardTypeEmailAddress;
    self.nameField.layer.borderColor = (__bridge CGColorRef)([UIColor cyanColor]);
//    密码
    self.passWordField = [[UITextField alloc] initWithFrame:CGRectMake(50, ORIGIN_FRAMW_Y + 60, self.view.frame.size.width - 100, HEIGHT_OF_FIELD)];
    self.passWordField.backgroundColor = [UIColor colorWithRed:0.81f green:0.91f blue:0.94f alpha:0.5f];
    [self.loginView addSubview:self.passWordField];
    self.passWordField.layer.cornerRadius = 8;
    self.passWordField.borderStyle = 0;
    self.passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordField.delegate = self;
    self.passWordField.text = passWord;
    self.passWordField.keyboardType = UIKeyboardTypeEmailAddress;
    self.passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordField.secureTextEntry = YES;
    self.passWordField.layer.borderColor = (__bridge CGColorRef)([UIColor cyanColor]);
    
    
    self.passWordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pw_icon"]];
    self.nameField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_icon"]];
    self.nameField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordField.leftViewMode = UITextFieldViewModeAlways;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstRe)];
    
    [self.loginView addGestureRecognizer:tap];
    [self createButtons];
    
   
    
    //给textfiled添加监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jiantingNotification)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.passWordField];
}

- (void)jiantingNotification {
    if (_nameField.text.length ==0 || _passWordField.text.length==0) {
        [self loginButtonNormalStatus];
    }else {
        [self loginButtonHighLightStatus];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *newStr = [textField.text mutableCopy];
    [newStr replaceCharactersInRange:range
                          withString:string];
    if ([textField isEqual:_passWordField]) {
        if ([_nameField.text length] == 0 || [newStr length] == 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }else if ([textField isEqual:_nameField]){
        if ([_passWordField.text length] == 0 || [newStr length] == 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([textField isEqual:_passWordField]) {
        if ([_nameField.text length] == 0 || [textField.text length] != 0) {
            NSLog(@"----0%@",textField.text);
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }else if ([textField isEqual:_nameField]) {
        if ([_passWordField.text length] == 0 || [textField.text length] != 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_passWordField]) {
        if (textField.text.length == 0) {
            [self loginButtonNormalStatus];
        }else {
            [self loginButtonHighLightStatus];
        }
    }
}

-(void)loginButtonHighLightStatus{
    self.loginButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:193/255.0 blue:192/255.0 alpha:1];
    [_loginButton setTitleColor:RGB(56, 46, 46) forState:UIControlStateNormal];
    
     [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    _loginButton.userInteractionEnabled = YES;
}
-(void)loginButtonNormalStatus{
    _loginButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:193/255.0 blue:192/255.0 alpha:0.2];
    [_loginButton setTitleColor:RGB(56, 46, 46) forState:UIControlStateNormal];
  
    _loginButton.userInteractionEnabled = NO;
}

/**
 *  创建登录按钮
 */
-(void)createButtons
{
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake((self.view.frame.size.width-200)/2, ORIGIN_FRAMW_Y + 120, 200, HEIGHT_OF_FIELD);
    _loginButton.backgroundColor = [UIColor colorWithRed:14/255.0 green:193/255.0 blue:192/255.0 alpha:0.2];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
   
    _loginButton.userInteractionEnabled = NO;
    [self.view addSubview:_loginButton];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"pusername"];
    if (name) {
        [self loginButtonHighLightStatus];
    }
}

/**
 *  登录Aciton
 */
-(void)loginAction
{
    /**/
//    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:ISLOGIN];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"cardNum=%@&password=%@",self.nameField.text,self.passWordField.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    
    //2.3请求超时
    request.timeoutInterval = 5;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        //   解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
   
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if ([[dic objectForKey:@"success"] isEqualToString:@"true"]) {
        
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                //登陆成功后把用户名存储到UserDefault
                [userDefaults setObject:self.nameField.text forKey:@"pusername"];
                [userDefaults setObject:self.passWordField.text forKey:@"password"];
                [userDefaults synchronize];
                [THReaderConstant shareReadConstant].userName=self.nameField.text;
                
                self.view.window.rootViewController = [[THMainViewController alloc] init];
                
            }else{
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"卡号或密码出现错误" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:true completion:nil];
            }
        });
    
    }];
    //7.执行任务
    [dataTask resume];
    
}

/**
 *  注册Action */
-(void)signupAction:(UIButton*)button
{
    NSLog(@"signupAction");
}
/**
 *  点击背景键盘收起
 */
-(void)resignFirstRe
{
    [self.nameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
}
/**
 *
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  键盘出现的Action
 */
-(void)keyboardShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.nameField.frame.origin.y == ORIGIN_FRAMW_Y) {
            CGRect nameFrame = self.nameField.frame;
            nameFrame.origin.y -= CHANGE_FRAME_VALUE;
            self.nameField.frame = nameFrame;
            
            CGRect passWordFrame = self.passWordField.frame;
            passWordFrame.origin.y -= CHANGE_FRAME_VALUE;
            self.passWordField.frame = passWordFrame;
            
            CGRect loginFrame = self.loginButton.frame;
            loginFrame.origin.y -= CHANGE_FRAME_VALUE;
            self.loginButton.frame = loginFrame;
            
            CGRect signupFrame = self.signupButton.frame;
            signupFrame.origin.y -= CHANGE_FRAME_VALUE;
            self.signupButton.frame = signupFrame;
            
            
        }
    }];
}
/**
 *  键盘消失的Action
 */
-(void)keyboardHide:(NSNotification*)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        if (self.nameField.frame.origin.y == ORIGIN_FRAMW_Y - CHANGE_FRAME_VALUE) {
            CGRect frame = self.nameField.frame;
            frame.origin.y += CHANGE_FRAME_VALUE;
            self.nameField.frame = frame;
            
            CGRect passWordFrame = self.passWordField.frame;
            passWordFrame.origin.y += CHANGE_FRAME_VALUE;
            self.passWordField.frame = passWordFrame;
            
            CGRect loginFrame = self.loginButton.frame;
            loginFrame.origin.y += CHANGE_FRAME_VALUE;
            self.loginButton.frame = loginFrame;
            
            CGRect signupFrame = self.signupButton.frame;
            signupFrame.origin.y += CHANGE_FRAME_VALUE;
            self.signupButton.frame = signupFrame;
            
            
        }
    }];
}

/**
 *  循环播放
 */
-(void)moviePlayDidEnd:(NSNotification*)notification
{
    AVPlayerItem *item = [notification object];
    
    [item seekToTime:kCMTimeZero];
    
    [self.player play];
    
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
