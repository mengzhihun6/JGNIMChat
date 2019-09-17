//
//  NHIdentCardMessageContentView.m
//  NestHouse
//
//  Created by JG on 2017/4/25.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHIdentCardMessageContentView.h"
#import "NHCardAttachment.h"
@interface NHIdentCardMessageContentView()

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation NHIdentCardMessageContentView

- (instancetype)initSessionMessageContentView{
    if (self = [super initSessionMessageContentView]) {
        // 添加点击手势
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
        
        self.identificationImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.identificationIntroLab = [[UILabel alloc]initWithFrame:CGRectZero];
        self.identificationIntroLab.font = AppThemeTraditionFont;
        self.identificationIntroLab.textColor = [UIColor blackColor];
        self.identificationPhoneNumLab = [[UILabel alloc]initWithFrame:CGRectZero];
        self.identificationPhoneNumLab.font = AppThemeTraditionFont;
        self.identificationPhoneNumLab.textColor = [UIColor grayColor];
        [self addSubview:self.identificationPhoneNumLab];
        [self addSubview:self.identificationIntroLab];
        [self addSubview:self.identificationImageView];
        
    }
    return self;

}

#pragma mark - 点击手势
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(onCatchEvent:)]) {
        NIMKitEvent *event = [[NIMKitEvent alloc] init];
        event.eventName = IdentificantCardClick;
        event.messageModel = self.model;
        event.data = self;
        [self.delegate onCatchEvent:event];
    }
}

#pragma mark - 系统父类方法
- (void)refresh:(NIMMessageModel*)data{
    //务必调用super方法
    [super refresh:data];
    
    NIMCustomObject *object = (NIMCustomObject *)data.message.messageObject;
    NHCardAttachment *attachment = (NHCardAttachment *)object.attachment;
    
    self.identificationIntroLab.text = attachment.identificantionIntro;
    self.identificationPhoneNumLab.text = attachment.phoneNumber;
    [self.identificationImageView sd_setImageWithURL:[NSURL URLWithString:attachment.identificantionImageUrl] placeholderImage:nil];
    
    self.identificationIntroLab.numberOfLines = 0;
//    
//    [_titleLabel sizeToFit];
//    CGRect rect = _titleLabel.frame;
//    if (CGRectGetMaxX(rect) > self.bounds.size.width) {
//        rect.size.width = self.bounds.size.width - rect.origin.x - 20;
//        _titleLabel.frame = rect;
//    }
//    
//    [_subTitleLabel sizeToFit];
//    [_descLabel sizeToFit];
}


- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{

    self.identificationImageView.frame = CGRectMake(7, 13, 160, 110);
    self.identificationIntroLab.frame = CGRectMake(7, 13 + 110, 160, 50);
    self.identificationPhoneNumLab.frame = CGRectMake(7, 173, 160, 30);
    return [UIImage imageWithColor:[UIColor redColor]];

}

@end
