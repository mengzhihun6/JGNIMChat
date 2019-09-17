//
//  NHServiceCardView.m
//  NestHouse
//
//  Created by JG on 2017/4/25.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHServiceCardView.h"
@interface NHServiceCardView()

//头像
@property (nonatomic, strong) UIImageView *iconView;
//姓名
@property (nonatomic, strong) UILabel *nameLab;
//职位
@property (nonatomic, strong) UILabel *careerLab;
//照片
@property (nonatomic, strong) UIImageView *photoView;
//介绍
@property (nonatomic, strong) UILabel *introLab;
//phoneIcon
@property (nonatomic, strong) UIImageView *phoneIconView;
//phoneLab
@property (nonatomic, strong) UILabel *phoneLab;


@end

@implementation NHServiceCardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 绘制UI
- (void)setupUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backView.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    tap.cancelsTouchesInView = NO;
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];

    UIView *frontView = [[UIView alloc]init];
    frontView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:frontView];
    [frontView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
        make.width.equalTo(WIDTH - W(40));
        make.height.equalTo(HEIGHT/2);
    }];
    
    self.iconView = [[UIImageView alloc]init];
    self.iconView.layer.cornerRadius = 14;
    self.iconView.clipsToBounds = YES;
    self.iconView.backgroundColor = [UIColor redColor];
    self.iconView.image = [UIImage imageNamed:@"DefaultAvatar"];
    [frontView addSubview:self.iconView];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(frontView).offset(10);
        make.left.equalTo(frontView).offset(10);
        make.size.equalTo(CGSizeMake(28, 28));
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"Mr巢";
    self.nameLab.font = [UIFont systemFontOfSize:20];
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.textColor = [UIColor blackColor];
    [frontView addSubview:self.nameLab];
    CGFloat width = [UILabel getWidthWithTitle:self.nameLab.text font:[UIFont systemFontOfSize:20]];
    [self.nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView);
        make.left.equalTo(self.iconView.right).offset(5);
        make.size.equalTo(CGSizeMake(width, H(20)));
    }];
    
    
    self.careerLab = [UILabel lableWithTextColor:[UIColor whiteColor                                                                                                                                                                                                                                                                                                                                                                                                                            ] textFont:14 text:@"全天候客服"];
    self.careerLab.textAlignment = NSTextAlignmentLeft;
    self.careerLab.backgroundColor = [UIColor blueColor];
    [frontView addSubview:self.careerLab];
    [self.careerLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView);
        make.left.equalTo(self.nameLab.right).offset(10);
        make.size.equalTo(CGSizeMake(W(66), 14));
    }];
    
    self.photoView = [[UIImageView alloc]init];
    self.photoView.image = [UIImage imageNamed:@"background@2x.jpg"];
    [frontView addSubview:self.photoView];
    [self.photoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.bottom).offset(10);
        make.left.equalTo(frontView).offset(10);
        make.right.equalTo(frontView).offset(-10);
        make.height.equalTo(180);
    }];
    
    self.introLab = [[UILabel alloc]init];
    self.introLab.text = @"尊敬的业主你好，很高兴认识你";
    self.introLab.numberOfLines = 0;
    self.introLab.font = [UIFont systemFontOfSize:14];
    [frontView addSubview:self.introLab];
    [self.introLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.bottom).offset(10);
        make.left.equalTo(frontView).offset(10);
        make.right.equalTo(frontView).offset(-10);
        make.height.equalTo(H(30));
    }];
    
    self.phoneIconView = [[UIImageView alloc]init];
    self.phoneIconView.layer.cornerRadius = 7;
    self.phoneIconView.clipsToBounds = YES;
    self.phoneIconView.image = [UIImage imageNamed:@"发送"];
    UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneClick:)];
    [self.phoneIconView addGestureRecognizer:phoneTap];
    [frontView addSubview:self.phoneIconView];
    [self.phoneIconView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(frontView).offset(10);
        make.top.equalTo(self.introLab.bottom).offset(10);
        make.size.equalTo(CGSizeMake(14, 14));
    }];
    
    self.phoneLab = [[UILabel alloc]init];
    self.phoneLab.text = @"直接拨打电话咨询我";
    self.phoneLab.font = AppThemeTraditionFont;
    self.phoneLab.textColor = [UIColor darkGrayColor];
    self.phoneLab.textAlignment = NSTextAlignmentLeft;
    [self.phoneLab addGestureRecognizer:phoneTap];
    [frontView addSubview:self.phoneLab];
    [self.phoneLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneIconView.right).offset(5);
        make.top.equalTo(self.phoneIconView);
        make.size.equalTo(CGSizeMake(W(140), 14));
    }];
    

}

#pragma mark - 蒙版点击
- (void)backViewClick{
    if ([_delegate respondsToSelector:@selector(backViewClick:)]) {
        [_delegate backViewClick:self];
    }

}


#pragma mark - phoneNumClick
- (void)phoneClick:(UITapGestureRecognizer *)tap{

    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15996667281"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}

@end
