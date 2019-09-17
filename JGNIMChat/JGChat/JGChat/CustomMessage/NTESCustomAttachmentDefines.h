//
//  NTESCustomAttachmentDefines.h
//  NIM
//
//  Created by amao on 7/2/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#ifndef NIM_NTESCustomAttachmentTypes_h
#define NIM_NTESCustomAttachmentTypes_h

@class NIMKitBubbleStyleObject;

typedef NS_ENUM(NSInteger,NTESCustomMessageType){
    CustomMessageTypeIdentificantionCard  = 1, //名片
    CustomMessagePost                     = 2, //帖子
    CustomMessageMaterialGif              = 5, //动态图
    CustomMessageLocation                 = 6  //地图
};


#define CMType          @"type"
#define CMData          @"data"
#define CMValue         @"value"
#define CMFlag          @"flag"
#define CMURL           @"url"
#define CMMD5           @"md5"
#define CMCatalog       @"catalog"  //贴图类别
#define CMChartlet      @"chartlet" //贴图表情ID

//名片内容
#define CMIdentificationImageUrl     @"Identification_ImageUrl"
#define CMIdentificationIntro   @"Identification_Intro"
#define CMIdentificationPhoneNum   @"Identification_PhoneNum"

//帖子
#define CMPostImageUrl    @"post_img"
#define CMPostContent     @"post_content"
#define CMPostTopic       @"post_topic"

//素材动态图url
#define CMMaterialGifUrl @"material_Url"

//定位
#define CMLocationMapImageUrl @"map_img"
#define CMLocationMapAdress   @"map_address"
#define CMLocationMapAdressDetail @"map_address_detial"


#endif


@protocol NTESCustomAttachmentInfo <NSObject>

@optional

- (NSString *)cellContent:(NIMMessage *)message;

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width;

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message;

- (NSString *)formatedMessage;

- (UIImage *)showCoverImage;

- (BOOL)shouldShowAvatar;

- (void)setShowCoverImage:(UIImage *)image;

@end
