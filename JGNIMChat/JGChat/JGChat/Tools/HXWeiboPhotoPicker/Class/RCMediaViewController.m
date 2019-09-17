//
//  RCMediaViewController.m
//  PhotoAndVIdeo
//
//  Created by Roy on 2017/2/28.
//  Copyright © 2017年 Roy CHANG. All rights reserved.
//

#import "RCMediaViewController.h"
#import "RCMediaCaptureView.h"
#import "UIView+HXExtension.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HXPhotoTools.h"
#import "UIImage+HXExtension.h"

@interface RCMediaViewController ()
{
    RCMediaCaptureView *_captureView;
}

@property (strong, nonatomic) NSURL *videoURL;

@property (strong, nonatomic) NSURL *clipVideoURL;

@property (assign, nonatomic) NSInteger videoTime;

/**
 * 最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;

@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation RCMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self rc_initToolbar];
    
//    _focus = [[RCMediaFocusView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
//    [self.view addSubview:_focus];
    
    self.effectiveScale = 1.0f;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    _captureView = [[RCMediaCaptureView alloc] initWithFrame:self.view.bounds];
    _captureView.captureDelegate = (id<RCMediaCaptureViewDelegate>)self;
    [self.view addSubview:_captureView];
    
    [_captureView rc_startCapture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if(self.isMovingFromParentViewController)
    {
        [_captureView rc_stopCaptture];
        [_captureView removeFromSuperview];
    }
}

- (void)rc_captureView:(RCMediaCaptureView *)capture didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    HXPhotoModel *model = [[HXPhotoModel alloc] init];
    self.videoURL = [info objectForKey:@"_rc_mediainfo_video_"];
    if (self.videoURL) {
        [self.view showLoadingHUDText:@"处理中"];
        self.view.userInteractionEnabled = NO;
        __weak typeof(self) weakSelf = self;
        [self clipVideoCompleted:^{
            weakSelf.view.userInteractionEnabled = YES;
            model.type = HXPhotoModelMediaTypeCameraVideo;
            MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:weakSelf.videoURL] ;
            player.shouldAutoplay = NO;
            UIImage  *image = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
            NSString *videoTime = [HXPhotoTools getNewTimeFromDurationSecond:weakSelf.videoTime];
            model.videoURL = weakSelf.clipVideoURL;
            model.videoTime = videoTime;
            model.thumbPhoto = image;
            model.imageSize = [image clipImage:self.effectiveScale].size;
            model.previewPhoto = image;
            model.cameraIdentifier = [weakSelf videoOutFutFileName];
            [weakSelf.view handleLoading];
                    if ([weakSelf.mediaDelegate respondsToSelector:@selector(cameraDidNextClick:)]) {
                        [weakSelf.mediaDelegate cameraDidNextClick:model];
                    }
//                    [weakSelf dismiss];
        } failed:^{
            weakSelf.view.userInteractionEnabled = YES;
            [weakSelf.view handleLoading];
            [weakSelf.view showImageHUDText:@"处理失败,请重试!"];
        }];
        
        if([_mediaDelegate respondsToSelector:@selector(rc_mediaController:didFinishPickingMediaWithInfo:)])
        {
            [_mediaDelegate rc_mediaController:self didFinishPickingMediaWithInfo:info];
        }
        
        //    [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        self.imageView.image = [info objectForKey:@"_rc_mediainfo_image_"];
        model.type = HXPhotoModelMediaTypeCameraPhoto;
        if (self.imageView.image.imageOrientation != UIImageOrientationUp) {
            self.imageView.image = [self.imageView.image normalizedImage];
        }
        UIImage *image;
        if (self.effectiveScale > 1) {
            image = [self.imageView.image scaleImagetoScale:self.effectiveScale];
        }else {
            image = self.imageView.image;
        }
        image = [image clipImage:self.effectiveScale];
        model.thumbPhoto = image;
        model.imageSize = image.size;
        model.previewPhoto = image;
        
        model.cameraIdentifier = [self videoOutFutFileName];
        if ([self.mediaDelegate respondsToSelector:@selector(cameraDidNextClick:)]) {
            [self.mediaDelegate cameraDidNextClick:model];
        }
        if([_mediaDelegate respondsToSelector:@selector(rc_mediaController:didFinishPickingMediaWithInfo:)])
        {
            [_mediaDelegate rc_mediaController:self didFinishPickingMediaWithInfo:info];
        }
        
        //    [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
}

- (void)rc_captureViewDidCancel:(RCMediaCaptureView *)capture
{
    if([_mediaDelegate respondsToSelector:@selector(rc_mediaControlelrDidCancel:)])
    {
        [_mediaDelegate rc_mediaControlelrDidCancel:self];
    }
    
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clipVideoCompleted:(void(^)())completed failed:(void(^)())failed
{
    AVAsset *asset = [AVAsset assetWithURL:self.videoURL];
    
    AVAssetTrack *audioTrack;
    if ([[asset tracksWithMediaType:AVMediaTypeAudio] count] != 0) {
        audioTrack = [asset tracksWithMediaType:AVMediaTypeAudio][0];
    }
    
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    NSError *error = nil;
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                        ofTrack:[[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero
                          error:&error];
    
    if (audioTrack != nil) {
        AVMutableCompositionTrack *compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                       preferredTrackID:kCMPersistentTrackID_Invalid];
        [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                       ofTrack:audioTrack
                                        atTime:kCMTimeZero
                                         error:&error];
    }
    
    // 3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
    
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    AVAssetTrack *videoAssetTrack;
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
        videoAssetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    }
    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
    BOOL isVideoAssetPortrait_  = NO;
    CGAffineTransform videoTransform = videoAssetTrack.preferredTransform;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ = UIImageOrientationRight;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ =  UIImageOrientationLeft;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
        videoAssetOrientation_ =  UIImageOrientationUp;
    }
    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
        videoAssetOrientation_ = UIImageOrientationDown;
    }
    CGFloat videoWidth = videoAssetTrack.naturalSize.width;
    CGFloat videoHeight = videoAssetTrack.naturalSize.height;
    CGAffineTransform t1;
    CGAffineTransform t2;
    if(isVideoAssetPortrait_){
        if (videoAssetOrientation_ == UIImageOrientationRight) {
            t1 = CGAffineTransformTranslate(videoTransform, -(videoWidth / 2 - videoHeight / 2), 0);
            [videolayerInstruction setTransform:t1 atTime:kCMTimeZero];
        }else if (videoAssetOrientation_ == UIImageOrientationLeft) {
            t1 = CGAffineTransformScale(videoTransform, 1, 1);
            t2 = CGAffineTransformTranslate(t1, -(videoWidth / 2 - videoHeight - videoHeight / 4), 0);
            [videolayerInstruction setTransform:t2 atTime:kCMTimeZero];
        }
    } else {
        if (videoAssetOrientation_ == UIImageOrientationUp) {
            t1 = CGAffineTransformScale(videoTransform, 1.77778, 1.77778);
            t2 = CGAffineTransformTranslate(t1, videoHeight / 2 - videoWidth / 2, 0);
            [videolayerInstruction setTransform:t2 atTime:kCMTimeZero];
        }else {
            t1 = CGAffineTransformScale(videoTransform, 1.77778, 1.77778);
            t2 = CGAffineTransformTranslate(t1, videoHeight / 2 - videoWidth / 2, -(videoHeight / 16 * 7));
            [videolayerInstruction setTransform:t2 atTime:kCMTimeZero];
        }
    }
    [videolayerInstruction setOpacity:0.0 atTime:asset.duration];
    
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    } else {
        naturalSize = videoAssetTrack.naturalSize;
    }
    
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderWidth);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"FinalVideo-%d.mov",arc4random() % 1000]];
    self.clipVideoURL = [NSURL fileURLWithPath:myPathDocs];
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL = self.clipVideoURL;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.shouldOptimizeForNetworkUse = YES;
    exporter.videoComposition = mainCompositionInst;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        switch (exporter.status) {
            case AVAssetExportSessionStatusUnknown:
                break;
            case AVAssetExportSessionStatusWaiting:
                break;
            case AVAssetExportSessionStatusExporting:
                break;
            case AVAssetExportSessionStatusCompleted:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completed) {
                        completed();
                    }
                });
            }
                break;
            case AVAssetExportSessionStatusFailed:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failed) {
                        failed();
                    }
                });
            }
                break;
            case AVAssetExportSessionStatusCancelled:
                break;
            default:
                break;
        }
    }];
}


- (NSString *)videoOutFutFileName
{
    NSString *fileName = @"";
    NSDate *nowDate = [NSDate date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[nowDate timeIntervalSince1970]];
    NSString *numStr = [NSString stringWithFormat:@"%d",arc4random()%10000];
    fileName = [fileName stringByAppendingString:dateStr];
    fileName = [fileName stringByAppendingString:numStr];
    return fileName;
}


@end
