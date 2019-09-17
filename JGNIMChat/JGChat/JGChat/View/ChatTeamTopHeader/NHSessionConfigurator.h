//
//  NHSessionConfigurator.h
//  NestHouse
//
//  Created by JG on 2017/4/24.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <NIMKit/NIMKit.h>
#import "NIMSessionConfigurator.h"
#import "NIMSessionConfigurateProtocol.h"
@class NIMSessionViewController;
@interface NHSessionConfigurator : NIMSessionConfigurator

- (void)setup:(NIMSessionViewController *)vc;

@property (nonatomic, strong) NIMSession *session;

@end
