//
//  NHPostMessageContentView.m
//  NestHouse
//
//  Created by JG on 2017/4/28.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHPostMessageContentView.h"
#import "NHPostMessageAttachment.h"
@interface NHPostMessageContentView()

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation NHPostMessageContentView

- (instancetype)initSessionMessageContentView{
    if (self = [super initSessionMessageContentView]) {
        // 添加点击手势
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
        self.postContentLab = [[UILabel alloc]initWithFrame:CGRectZero];
        self.postContentLab.numberOfLines = 0;
        self.postContentLab.textColor = [UIColor blackColor];
        self.postContentLab.textAlignment = NSTextAlignmentLeft;
        self.postContentLab.font = AppThemeTraditionFont;
        
        self.postImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        
        self.postTopicLab = [[UILabel alloc]initWithFrame:CGRectZero];
        self.postTopicLab.textColor = [UIColor blackColor];
        self.postTopicLab.textAlignment = NSTextAlignmentLeft;
        self.postTopicLab.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:self.postTopicLab];
        [self addSubview:self.postImageView];
        [self addSubview:self.postContentLab];
    }
    return self;
    
}

#pragma mark - 点击手势
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(onCatchEvent:)]) {
        NIMKitEvent *event = [[NIMKitEvent alloc] init];
        event.eventName = PostMessageClick;
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
    NHPostMessageAttachment *attachment = (NHPostMessageAttachment *)object.attachment;
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:attachment.postImageUrl]];
    self.postContentLab.text = attachment.postContent;
    self.postTopicLab.text = attachment.postTopic;
}


- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    
    self.postImageView.frame = CGRectMake(7, 13, 60, 60);
    self.postContentLab.frame = CGRectMake(77, 13, 83, 60);
    self.postTopicLab.frame = CGRectMake(7, 80, 170, 20);
    
    return [UIImage imageWithColor:[UIColor redColor]];
}



@end
