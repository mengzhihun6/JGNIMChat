//
//  NHSessonListFooterView.m
//  NestHouse
//
//  Created by JG on 2017/4/22.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHSessonListFooterView.h"
@interface NHSessonListFooterView()

@property (nonatomic, strong) UIImageView *introduceIcon;

@property (nonatomic, strong) UILabel *introduceLab;

@property (nonatomic, strong) UIImageView *answerIcon;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *subTitleLab;

@end

@implementation NHSessonListFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI{

    UIView *introView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 70)];
    introView.backgroundColor = [UIColor greenColor];
    [self addSubview:introView];
    self.introduceIcon= [[UIImageView alloc]init];
    self.introduceIcon.backgroundColor = [UIColor redColor];
    self.introduceIcon.layer.cornerRadius = 25;
    self.introduceIcon.clipsToBounds = YES;
    [introView addSubview:self.introduceIcon];
    [self.introduceIcon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(introView);
        make.left.equalTo(introView).offset(10);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    
    self.introduceLab = [[UILabel alloc]init];
    self.introduceLab.text = @"精品推荐";
    self.introduceLab.textAlignment = NSTextAlignmentLeft;
    self.introduceLab.font = [UIFont systemFontOfSize:18];
    self.introduceLab.textColor = [UIColor blackColor];
    [introView addSubview:self.introduceLab];
    [self.introduceLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(introView);
        make.left.equalTo(self.introduceIcon.right).offset(10);
        make.size.equalTo(CGSizeMake(W(200), H(30)));
    }];
    
    UIView *answerView = [[UIView alloc]initWithFrame:CGRectMake(0, 71, WIDTH, 70)];
    answerView.backgroundColor = [UIColor blueColor];
    [self addSubview:answerView];
    self.answerIcon = [[UIImageView alloc]init];
    self.answerIcon.backgroundColor = [UIColor redColor];
    self.answerIcon.layer.cornerRadius = 25;
    self.answerIcon.clipsToBounds = YES;
    [answerView addSubview:self.answerIcon];
    [self.answerIcon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(answerView);
        make.left.equalTo(answerView).offset(10);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"巢宅家舍通知/即时答疑解惑";
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.font = AppThemeTraditionFont;
    self.titleLab.textColor = [UIColor blackColor];
    [answerView addSubview:self.titleLab];
    [self.titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(answerView).offset(10);
        make.left.equalTo(self.answerIcon.right).offset(10);
        make.size.equalTo(CGSizeMake(W(200), H(20)));
    }];
    
    self.subTitleLab = [[UILabel alloc]init];
    self.subTitleLab.textColor = [UIColor darkGrayColor];
    self.subTitleLab.textAlignment = NSTextAlignmentLeft;
    self.subTitleLab.text = @"Hi,欢迎来到巢宅家舍，希望你的每一次选择都是";
    self.subTitleLab.font = [UIFont systemFontOfSize:12];
    [answerView addSubview:self.subTitleLab];
    [self.subTitleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.bottom);
        make.left.equalTo(self.titleLab);
        make.size.equalTo(self.titleLab);
    }];
}

@end
