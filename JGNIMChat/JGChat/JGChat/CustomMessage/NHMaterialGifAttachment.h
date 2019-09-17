//
//  NHMaterialGifAttachment.h
//  NestHouse
//
//  Created by JG on 2017/4/26.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTESCustomAttachmentDefines.h"

@interface NHMaterialGifAttachment : NSObject<NIMCustomAttachment,NTESCustomAttachmentInfo>

//gif图url
@property (nonatomic, strong) NSString *gifUrl;

@end
