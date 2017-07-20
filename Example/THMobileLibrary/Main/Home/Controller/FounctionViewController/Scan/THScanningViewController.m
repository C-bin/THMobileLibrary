//
//  THScanningViewController.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/7/12.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THScanningViewController.h"
#import "SGQRCode.h"
#import "THDetailViewController.h"
@interface THScanningViewController () <SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;

@end

@implementation THScanningViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
      self.navigationController.navigationBarHidden = NO;
     self.tabBarController.tabBar.hidden=YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.scanningView];
    
    [self setupQRCodeScanning];
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}


- (void)setupQRCodeScanning {
    SGQRCodeScanManager *manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    manager.delegate = self;
}
#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    
}


#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    [scanManager SG_stopRunning];
      
   
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager SG_stopRunning];
        [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        //        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
        NSString *jump_URL = [obj stringValue];
        NSLog(@"跳转地址----++++++%@",jump_URL);
        NSArray *array = [jump_URL componentsSeparatedByString:@"?"]; //从字符A中分隔成2个元素的数组
        NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf

       
        if ([jump_URL hasPrefix:@"http"]) {
//            NSURL *url = [ [ NSURL alloc ] initWithString:jump_URL];
//            [[UIApplication sharedApplication] openURL:url];
            THDetailViewController *detailVC=[[THDetailViewController alloc]init];
             detailVC.bookURL = [NSString stringWithFormat:@"http://101.201.116.210:7726/mobile/bookDetailById?bookId=%@",[array objectAtIndex:1]];
             [self.navigationController pushViewController:detailVC animated:NO];
        }else {
            NSLog(@"条形码0");
        }
        
        //        [self.navigationController pushViewController:jumpVC animated:YES];
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
      
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
