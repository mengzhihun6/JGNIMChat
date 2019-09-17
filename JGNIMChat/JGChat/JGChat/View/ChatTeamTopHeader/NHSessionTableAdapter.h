//
//  NHSessionTableAdapter.h
//  NestHouse
//
//  Created by JG on 2017/4/22.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <NIMKit/NIMKit.h>
#import "NIMSessionTableAdapter.h"

@interface NHSessionTableAdapter : NIMSessionTableAdapter

//接收session，判断是群还是个人
@property (nonatomic, strong) NIMSession *session;

@end
