//
//  NHPostMessageContentView.h
//  NestHouse
//
//  Created by JG on 2017/4/28.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <NIMKit/NIMKit.h>
static NSString *const PostMessageClick = @"PostMessageClick";

@interface NHPostMessageContentView : NIMSessionMessageContentView

@property (nonatomic, strong) UIImageView *postImageView;

@property (nonatomic, strong) UILabel *postContentLab;

@property (nonatomic, strong) UILabel *postTopicLab;

@end
