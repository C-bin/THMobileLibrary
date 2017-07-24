//
//  THDetaileModel.m
//  THMobileLibrary
//
//  Created by 天海网络  on 2017/6/19.
//  Copyright © 2017年 C-bin. All rights reserved.
//

#import "THDetaileModel.h"

@implementation THDetaileModel
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.bookid forKey:@"bookId"];
    [encoder encodeObject:self.bookName forKey:@"bookName"];
    [encoder encodeObject:self.bookImage forKey:@"bookImage"];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.bookid = [decoder decodeObjectForKey:@"bookId"];
        self.bookName = [decoder decodeObjectForKey:@"bookName"];
        self.bookImage = [decoder decodeObjectForKey:@"bookImage"];
    }
    return self;
}
@end
