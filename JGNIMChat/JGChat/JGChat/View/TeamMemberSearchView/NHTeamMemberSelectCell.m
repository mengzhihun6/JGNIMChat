//
//  NHTeamMemberSelectCell.m
//  NestHouse
//
//  Created by JG on 2017/4/21.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHTeamMemberSelectCell.h"
@interface NHTeamMemberSelectCell()

@end

@implementation NHTeamMemberSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;

}

#pragma mark - 绘制UI
- (void)setupUI{

    self.iconView = [[UIImageView alloc]init];
    self.iconView.layer.cornerRadius = W(10);
    self.iconView.clipsToBounds = YES;
    self.iconView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.iconView];
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(W(20), H(20)));
        make.left.equalTo(self.contentView).offset(W(10));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"MR巢宅家舍";
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.font = AppThemeTraditionFont;
    [self.contentView addSubview:self.nameLab];
    [self.nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(W(100), H(20)));
        make.left.equalTo(self.iconView.right).offset(W(10));
    }];
    
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image = [UIImage imageNamed:@"发送"];
    [self.contentView addSubview:self.selectImageView];
    [self.selectImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(- W(10));
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(W(15), H(15)));
    }];
    
    
    

}

@end
