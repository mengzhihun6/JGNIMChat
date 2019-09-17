//
//  NHMapMessageContentView.h
//  NestHouse
//
//  Created by JG on 2017/4/28.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <NIMKit/NIMKit.h>
static NSString *const MapMessageClick = @"MapMessageClick";

@interface NHMapMessageContentView : NIMSessionMessageContentView

@property (nonatomic, strong) UILabel *mapAdress;

@property (nonatomic, strong) UILabel *mapAdressDetail;

@property (nonatomic, strong) UIImageView *mapImageView;

@end
