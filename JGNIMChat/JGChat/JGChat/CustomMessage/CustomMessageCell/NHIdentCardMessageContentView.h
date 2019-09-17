//
//  NHIdentCardMessageContentView.h
//  NestHouse
//
//  Created by JG on 2017/4/25.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <NIMKit/NIMKit.h>

static NSString *const IdentificantCardClick = @"IdentificantCardClick";

@interface NHIdentCardMessageContentView : NIMSessionMessageContentView

//个人名片图片
@property (nonatomic, strong) UIImageView *identificationImageView;
//个人名片介绍
@property (nonatomic, strong) UILabel *identificationIntroLab;
//个人名片电话号码
@property (nonatomic, strong) UILabel *identificationPhoneNumLab;

@end
