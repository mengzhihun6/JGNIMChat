//
//  NHSessionTopHeaderView.m
//  NestHouse
//
//  Created by JG on 2017/4/22.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHSessionTopHeaderView.h"
@interface NHSessionTopHeaderView()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *subTitleLab;

@property (nonatomic, strong) UILabel *priceLab;


@end

@implementation NHSessionTopHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 绘制UI
- (void)setupUI{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.layer.cornerRadius = 35;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.image = [UIImage imageNamed:@"DefaultAvatar"];
    [view addSubview:self.iconImageView];
    [self.iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(10);
        make.size.equalTo(CGSizeMake(70, 70));
    }];

    self.titleLab = [[UILabel alloc]init];
    self.titleLab.text = @"三居室。混搭";
    self.titleLab.font = [UIFont systemFontOfSize:17];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.titleLab];
    [self.titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.right).offset(10);
        make.size.equalTo(CGSizeMake(W(200), 35));
    }];
    
    self.subTitleLab = [[UILabel alloc]init];
    self.subTitleLab.textAlignment = NSTextAlignmentLeft;
    self.subTitleLab.text = @"马卡龙罕见的闪光灯市规划";
    self.subTitleLab.font = [UIFont systemFontOfSize:15];
    self.subTitleLab.textColor = [UIColor darkGrayColor];
    [view addSubview:self.subTitleLab];
    [self.subTitleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.bottom);
        make.left.equalTo(self.titleLab);
        make.size.equalTo(self.titleLab);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.text = @"$约4.3万";
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.font = [UIFont systemFontOfSize:20];
    [view addSubview:self.priceLab];
    [self.priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-10);
        make.size.equalTo(CGSizeMake(W(90), 25));
    }];
}
@end
