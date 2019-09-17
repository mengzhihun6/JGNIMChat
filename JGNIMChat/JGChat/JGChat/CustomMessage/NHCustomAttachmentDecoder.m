//
//  NHCustomAttachmentDecoder.m
//  NestHouse
//
//  Created by JG on 2017/4/25.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHCustomAttachmentDecoder.h"
#import "NSDictionary+NHJson.h"
#import "NHCardAttachment.h"
#import "NHMaterialGifAttachment.h"
#import "NHLocationAttachment.h"
#import "NHPostMessageAttachment.h"
@implementation NHCustomAttachmentDecoder

- (id<NIMCustomAttachment>)decodeAttachment:(NSString *)content
{
    id<NIMCustomAttachment> attachment = nil;
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:nil];
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            NSInteger type     = [dict jsonInteger:CMType];
            NSDictionary *data = [dict jsonDict:CMData];
            switch (type) {
                case CustomMessageTypeIdentificantionCard:
                {
                    attachment = [[NHCardAttachment alloc] init];
                    ((NHCardAttachment *)attachment).identificantionImageUrl = [data jsonString:CMIdentificationImageUrl];
                    ((NHCardAttachment *)attachment).identificantionIntro = [data jsonString:CMIdentificationIntro];
                    ((NHCardAttachment *)attachment).phoneNumber = [data jsonString:CMIdentificationPhoneNum];
                    
                }
                    break;
                    case CustomMessageMaterialGif:
                {
                    attachment = [[NHMaterialGifAttachment alloc]init];
                    ((NHMaterialGifAttachment *)attachment).gifUrl = [data jsonString:CMMaterialGifUrl];
                
                }
                    break;
                    case CustomMessagePost:
                {
                
                    attachment = [[NHPostMessageAttachment alloc] init];
                    ((NHPostMessageAttachment *)attachment).postTopic = [data jsonString:CMPostTopic];
                    ((NHPostMessageAttachment *)attachment).postContent = [data jsonString:CMPostContent];
                    ((NHPostMessageAttachment *)attachment).postImageUrl = [data jsonString:CMPostImageUrl];
                
                }
                    break;
                    case CustomMessageLocation:
                {
                
                    attachment = [[NHLocationAttachment alloc] init];
                    ((NHLocationAttachment *)attachment).mapAdressDetail = [data jsonString:CMLocationMapAdressDetail];
                    ((NHLocationAttachment *)attachment).mapAdress = [data jsonString:CMLocationMapAdress];
                    ((NHLocationAttachment *)attachment).mapImageUrl = [data jsonString:CMLocationMapImageUrl];
                }
                    break;
                default:
                    break;
            }
            attachment = [self checkAttachment:attachment] ? attachment : nil;
        }
    }
    return attachment;
}


- (BOOL)checkAttachment:(id<NIMCustomAttachment>)attachment{
    BOOL check = NO;
    if ([attachment isKindOfClass:[NHCardAttachment class]]) {
        NSString *imageUrl = ((NHCardAttachment *)attachment).identificantionImageUrl;
        NSString *intro = ((NHCardAttachment *)attachment).identificantionIntro;
        NSString *phoneNumber = ((NHCardAttachment *)attachment).phoneNumber;
        check = imageUrl.length && intro.length && phoneNumber.length? YES : NO;
    }else if ([attachment isKindOfClass:[NHMaterialGifAttachment class]]){
        NSString *gifUrl = ((NHMaterialGifAttachment *)attachment).gifUrl;
        check = gifUrl.length ? YES : NO;
    }else if ([attachment isKindOfClass:[NHLocationAttachment class]]){
        NSString *imageUrl = ((NHLocationAttachment *)attachment).mapImageUrl;
        NSString *mapAdress = ((NHLocationAttachment *)attachment).mapAdress;
        NSString *mapAdressDetail = ((NHLocationAttachment *)attachment).mapAdressDetail;
        check = imageUrl.length && mapAdress.length && mapAdressDetail.length? YES : NO;
    }else if ([attachment isKindOfClass:[NHPostMessageAttachment class]]){
        NSString *imageUrl = ((NHPostMessageAttachment *)attachment).postImageUrl;
        NSString *mapAdress = ((NHPostMessageAttachment *)attachment).postContent;
        NSString *mapAdressDetail = ((NHPostMessageAttachment *)attachment).postTopic;
        check = imageUrl.length && mapAdress.length && mapAdressDetail.length? YES : NO;
    }
    return check;
}

@end
