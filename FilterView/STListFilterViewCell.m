//
//  STListFilterViewCell.m
//  my
//
//  Created by soso-mac on 2016/11/21.
//  Copyright © 2016年 soso-mac. All rights reserved.
//

#import "STListFilterViewCell.h"
#import "UIColor+STMyIColor.h"
@implementation STListFilterViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _titleLab = [UILabel new];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, 30);
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor fromHexValue:0x555555 alpha:1];
        [self.contentView addSubview:_titleLab];
    }
    return self;
}
-(void)setFilterIndexPath:(NSIndexPath *)indexPath andFilter:(BOOL)isFilter andTitleAry:(NSArray *)titleAry{
    _titleLab.text = [titleAry[indexPath.section][indexPath.row] allKeys][0];
    if (isFilter) {
        if (indexPath.row == 0) {
            self.titleLab.textColor = [UIColor fromHexValue:0xea5413 alpha:1];
            self.layer.borderColor = [UIColor fromHexValue:0xea5413 alpha:1].CGColor;
            self.layer.borderWidth = 1.0f;
        }else{
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.layer.borderWidth = 1.0f;
            self.titleLab.textColor = [UIColor fromHexValue:0x555555 alpha:1];
        }
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.titleLab.textColor = [UIColor fromHexValue:0x555555 alpha:1];
    }
}
@end
