//
//  NHMapMessageContentView.m
//  NestHouse
//
//  Created by JG on 2017/4/28.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHMapMessageContentView.h"
#import "NHLocationAttachment.h"
@interface NHMapMessageContentView()

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation NHMapMessageContentView


- (instancetype)initSessionMessageContentView{
    if (self = [super initSessionMessageContentView]) {
        // 添加点击手势
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
        self.mapAdress = [[UILabel alloc]initWithFrame:CGRectZero];
        self.mapAdress.textColor = [UIColor blackColor];
        self.mapAdress.textAlignment = NSTextAlignmentLeft;
        self.mapAdress.font = AppThemeTraditionFont;
        
        self.mapImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        
        self.mapAdressDetail = [[UILabel alloc]initWithFrame:CGRectZero];
        self.mapAdressDetail.textColor = [UIColor blackColor];
        self.mapAdressDetail.textAlignment = NSTextAlignmentLeft;
        self.mapAdressDetail.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:self.mapAdressDetail];
        [self addSubview:self.mapImageView];
        [self addSubview:self.mapAdress];
    }
    return self;
    
}

#pragma mark - 点击手势
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(onCatchEvent:)]) {
        NIMKitEvent *event = [[NIMKitEvent alloc] init];
        event.eventName = MapMessageClick;
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
    NHLocationAttachment *attachment = (NHLocationAttachment *)object.attachment;
    [self.mapImageView sd_setImageWithURL:[NSURL URLWithString:attachment.mapImageUrl]];
    self.mapAdress.text = attachment.mapAdress;
    self.mapAdressDetail.text = attachment.mapAdressDetail;
}


- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    
    self.mapAdress.frame = CGRectMake(7, 6, 170, 20);
    self.mapAdressDetail.frame = CGRectMake(7, 33, 170, 20);
    self.mapImageView.frame = CGRectMake(7, 53, 170, 60);
    
    return [UIImage imageWithColor:[UIColor redColor]];
}


@end
