//
//  LoopBanner.h
//  TestSample
//
//  Created by 彬爷 on 17/2/22.
//  Copyright © 2017年 CastielChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopBanner : UIView
/** click action */
@property (nonatomic, copy) void (^clickAction) (NSInteger curIndex) ;

/** data source */
@property (nonatomic, copy) NSArray *imageURLStrings;


- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration;

@end
