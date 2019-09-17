//
//  JGContactListController.h
//  JGChat
//
//  Created by JG on 2017/5/12.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMContactSelectConfig.h"
@interface JGContactListController : UIViewController

@property (nonatomic, strong, readonly) id<NIMContactSelectConfig> config;

@end
