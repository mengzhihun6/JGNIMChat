//
//  NHMaterialGifMessageContentView.h
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <NIMKit/NIMKit.h>
static NSString *const MaterialGifClick = @"MaterialGifClick";

@interface NHMaterialGifMessageContentView : NIMSessionMessageContentView

@property (nonatomic, strong) UIImageView *gImageView;

@end
