//
//  RCMediaViewController.h
//  PhotoAndVIdeo
//
//  Created by Roy on 2017/2/28.
//  Copyright © 2017年 Roy CHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPhotoModel.h"

typedef enum : NSUInteger {
    HXCameraTypePhoto = 0,
    HXCameraTypeVideo,
    HXCameraTypePhotoAndVideo
} HXCameraType;

@class RCMediaViewController;

///image instance
FOUNDATION_EXTERN NSString *const RCMediaImageInfo;
///NSURL instance
FOUNDATION_EXTERN NSString *const RCMediaVideoInfo;


@protocol RCMediaViewControllerDelegate <NSObject>

- (void)rc_mediaController:(RCMediaViewController *)media didFinishPickingMediaWithInfo:(NSDictionary *)info;

- (void)rc_mediaControlelrDidCancel:(RCMediaViewController *)media;


- (void)cameraDidNextClick:(HXPhotoModel *)model;

@end

@interface RCMediaViewController : UIViewController

@property (nonatomic, weak) id<RCMediaViewControllerDelegate> mediaDelegate;

@property (assign, nonatomic) BOOL isVideo;
@property (assign, nonatomic) HXCameraType type;

@end
