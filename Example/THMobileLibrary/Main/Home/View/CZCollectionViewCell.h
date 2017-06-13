//
//  CZCollectionViewCell.h
//  CZReader
//
//  Created by Castiel Chen on 11/03/2017.
//  Copyright © 2017 1124835650@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZBookModel.h"
@interface CZCollectionViewCell : UICollectionViewCell




@property (strong, nonatomic) UIImageView *topImage;
@property (strong, nonatomic) UILabel *botlabel;
@property (nonatomic,assign) NSString *bookId;

-(void)configCellWithModel:(CZBookModel *)model;
@end
