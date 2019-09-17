//
//  NHChatMessageManageView.m
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHChatMessageManageView.h"
@interface NHChatMessageManageView()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nickLab;

@end

@implementation NHChatMessageManageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


#pragma mark - 绘制界面
- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    UIView *firstView = [[UIView alloc]init];
    self.iconView = [[UIImageView alloc]init];
    self.iconView.layer.cornerRadius = 20;
    self.iconView.clipsToBounds = YES;
    self.iconView.image = [UIImage imageNamed:@"DefaultAvatar"];
    self.nickLab = [[UILabel alloc]init];
    self.nickLab.text = @"MR巢";
    self.nickLab.font = [UIFont systemFontOfSize:20];
    self.nickLab.textAlignment = NSTextAlignmentLeft;
    self.nickLab.textColor = [UIColor blackColor];
    [self addSubview:firstView];
    [firstView addSubview:self.iconView];
    [firstView addSubview:self.nickLab];
    
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(50);
    }];
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView).offset(5);
        make.left.equalTo(firstView).offset(10);
        make.bottom.equalTo(firstView).offset(-5);
        make.width.equalTo(40);
    }];
    
    [self.nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.bottom.equalTo(self.iconView);
        make.left.equalTo(self.iconView.right).offset(5);
        make.width.equalTo(W(100));
    }];
    
    UIView *secondView = [[UIView alloc]init];
    [self addSubview:secondView];
    UILabel *searchLab = [[UILabel alloc]init];
    searchLab.text = @"查找聊天记录";
    searchLab.font = [UIFont systemFontOfSize:20];
    searchLab.textColor = [UIColor blackColor];
    searchLab.textAlignment = NSTextAlignmentLeft;
    searchLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchClick)];
    [searchLab addGestureRecognizer:searchTap];
    [secondView addSubview:searchLab];
    
    [secondView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.bottom).offset(10);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(30);
    }];
    
    [searchLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView);
        make.left.equalTo(secondView).offset(10);
        make.bottom.equalTo(secondView);
        make.width.equalTo(W(150));
    }];
    
    UIView *thirdView = [[UIView alloc]init];
    UILabel *cleanLab = [UILabel lableWithTextColor:[UIColor blackColor] textFont:20 text:@"清理聊天记录"];
    cleanLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *cleanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cleanClick)];
    [cleanLab addGestureRecognizer:cleanTap];
    cleanLab.textAlignment = NSTextAlignmentLeft;
    [thirdView addSubview:cleanLab];
    [self addSubview:thirdView];
    [thirdView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.bottom).offset(10);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(secondView);
    }];
    
    [cleanLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdView);
        make.left.equalTo(thirdView).offset(10);
        make.bottom.equalTo(thirdView);
        make.width.equalTo(searchLab);
    }];

}


#pragma mark - searchClick
- (void)searchClick{

    if ([_delegate respondsToSelector:@selector(searchButClick:)]) {
        [_delegate searchButClick:self];
    }

}

#pragma mark - cleanClick
- (void)cleanClick{
    if ([_delegate respondsToSelector:@selector(cleanButClick:)]) {
        [_delegate cleanButClick:self];
    }

}
@end
