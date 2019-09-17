//
//  NHMaterialGifMessageContentView.m
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHMaterialGifMessageContentView.h"
#import "NHMaterialGifAttachment.h"

@interface NHMaterialGifMessageContentView()

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation NHMaterialGifMessageContentView

- (instancetype)initSessionMessageContentView{
    if (self = [super initSessionMessageContentView]) {
        // 添加点击手势
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
        
        self.gImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.gImageView];
        
    }
    return self;
    
}

#pragma mark - 点击手势
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(onCatchEvent:)]) {
        NIMKitEvent *event = [[NIMKitEvent alloc] init];
        event.eventName = MaterialGifClick;
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
    NHMaterialGifAttachment *attachment = (NHMaterialGifAttachment *)object.attachment;
    [self.gImageView sd_setImageWithURL:[NSURL URLWithString:attachment.gifUrl]];
}


- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    
    self.gImageView.frame = CGRectMake(7, 13, 160, 100);
    return [UIImage imageWithColor:[UIColor redColor]];
    
}


@end
