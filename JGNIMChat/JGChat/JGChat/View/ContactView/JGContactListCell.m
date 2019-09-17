//
//  JGContactListCell.m
//  JGChat
//
//  Created by JG on 2017/5/12.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGContactListCell.h"

@implementation JGContactListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}


- (UILabel *)nickLab{
    if (!_nickLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.font = [UIFont systemFontOfSize:20];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = [UIColor blackColor];
        [self.contentView addSubview:lab];
        [lab makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(200, 30));
        }];
        _nickLab = lab;
    }
    return _nickLab;
}

- (UIImageView *)selectImage{
    if (!_selectImage) {
        UIImageView *img = [[UIImageView alloc]init];
        [self.contentView addSubview:img];
        [img makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(- 10);
            make.centerY.equalTo(self.contentView);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        _selectImage = img;
    }
    return _selectImage;
}


@end
