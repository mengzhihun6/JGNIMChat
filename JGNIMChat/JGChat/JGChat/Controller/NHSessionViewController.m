//
//  NHSessionViewController.m
//  NestHouse
//
//  Created by JG on 2017/4/22.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHSessionViewController.h"
#import "NTESGalleryViewController.h"
#import "NTESVideoViewController.h"
#import "NIMKitLocationPoint.h"
#import "NHSessionConfigurator.h"
#import "NHCardAttachment.h"//自定义消息名片属性
#import "NHIdentCardMessageContentView.h"//自定义消息名片布局
#import "NHMaterialGifAttachment.h"//自定义消息动态图属性
#import "NHMaterialGifMessageContentView.h"//自定义消息动态图布局
#import "NHServiceCardView.h"//客服名片界面
#import "NHChatMessageManageController.h"//聊天信息管理
#import "HXPhotoViewController.h"//照片拍照集合控制器
#import "NHLocationAttachment.h"//自定义消息地图属性
#import "NHMapMessageContentView.h"//自定义消息地图布局
#import "NHPostMessageAttachment.h"//自定义消息帖子属性
#import "NHPostMessageContentView.h"//自定义消息帖子布局
#import "HXPhotoModel.h"
#import "NTESSessionMsgConverter.h"

#import "NHNormalTeamCardViewController.h"//讨论组管理页面

@interface NHSessionViewController ()<NHServiceCardViewDelegate,HXPhotoViewControllerDelegate>

@property (nonatomic, strong)  NHSessionConfigurator *configurator;

@property (nonatomic, strong)  NHServiceCardView *serviceCardView;

@property (nonatomic, strong)  HXPhotoManager *photoManager;

@end

@implementation NHSessionViewController


- (HXPhotoManager *)photoManager
{
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _photoManager.videoMaxNum = 5;
    }
    return _photoManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self customMessage];
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 50, 400, 50, 30)];
    [but setTitle:@"名片" forState:UIControlStateNormal];
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *but2 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 50, 440, 50, 30)];
    [but2 setTitle:@"动图" forState:UIControlStateNormal];
    but2.backgroundColor = [UIColor greenColor];
    [but2 addTarget:self action:@selector(but2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    [self.view bringSubviewToFront:but2];
    [self.view addSubview:but];
    [self.view bringSubviewToFront:but];
    
    UIButton *but3 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 50, 480, 50, 30)];
    [but3 setTitle:@"混合" forState:UIControlStateNormal];
    but3.backgroundColor = [UIColor blueColor];
    [but3 addTarget:self action:@selector(but3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
    [self.view bringSubviewToFront:but3];
    
    
    UIButton *but4 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 50, 530, 50, 30)];
    [but4 setTitle:@"帖子" forState:UIControlStateNormal];
    but4.backgroundColor = [UIColor brownColor];
    [but4 addTarget:self action:@selector(but4Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but4];
    [self.view bringSubviewToFront:but4];
    
    
    UIButton *but5 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 50, 570, 50, 30)];
    [but5 setTitle:@"地图" forState:UIControlStateNormal];
    but5.backgroundColor = [UIColor yellowColor];
    [but5 addTarget:self action:@selector(but5Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but5];
    [self.view bringSubviewToFront:but5];
    
    
    [self firstLoading];
}


#pragma mark - 初始化
- (void)firstLoading{
    self.serviceCardView = [[NHServiceCardView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.serviceCardView.delegate = self;
    
    //修改聊天页面导航条上方的按钮
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame =  CGRectMake(0, 0, 30, 30);
    [rightBut setImage:[UIImage imageNamed:@"DefaultAvatar"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(navRightButClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}



#pragma mark - 自定义消息cell点击实现方法
- (void)onTapCell:(NIMKitEvent *)event{
    BOOL handled = NO;
    NSString *eventName = event.eventName;
    if ([eventName isEqualToString:NIMKitEventNameTapContent])
    {
        NIMMessage *message = event.messageModel.message;
        NSDictionary *actions = [self cellActions];
        NSString *value = actions[@(message.messageType)];
        if (value) {
            SEL selector = NSSelectorFromString(value);
            if (selector && [self respondsToSelector:selector]) {
                SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:message]);
                handled = YES;
            }
        }
    }
    else if([eventName isEqualToString:NIMKitEventNameTapLabelLink])
    {

    }else if ([eventName isEqualToString:IdentificantCardClick]){
        DLog(@"点击了名片按钮");
        [self serviceCardViewAppearance];
    
    }
    
    if (!handled) {
//        NSAssert(0, @"invalid event");
    }


}

#pragma mark - 返回点击多媒体文件的点击芳法
- (NSDictionary *)cellActions
{
    static NSDictionary *actions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actions = @{@(NIMMessageTypeImage) :    @"showImage:",
                    @(NIMMessageTypeVideo) :    @"showVideo:",
                    @(NIMMessageTypeLocation) : @"showLocation:",
                    @(NIMMessageTypeFile)  :    @"showFile:",
                    @(NIMMessageTypeCustom):    @"showCustom:"};
    });
    return actions;
}

#pragma mark - Cell Actions

#pragma mark - 点击看大图
- (void)showImage:(NIMMessage *)message
{
    NIMImageObject *object = (NIMImageObject *)message.messageObject;
    NTESGalleryItem *item = [[NTESGalleryItem alloc] init];
    item.thumbPath      = [object thumbPath];
    item.imageURL       = [object url];
    item.name           = [object displayName];
    NTESGalleryViewController *vc = [[NTESGalleryViewController alloc] initWithItem:item];
    [self.navigationController pushViewController:vc animated:YES];
    if(![[NSFileManager defaultManager] fileExistsAtPath:object.thumbPath]){
        //如果缩略图下跪了，点进看大图的时候再去下一把缩略图
        __weak typeof(self) wself = self;
        [[NIMSDK sharedSDK].resourceManager download:object.thumbUrl filepath:object.thumbPath progress:nil completion:^(NSError *error) {
            if (!error) {
                [wself uiUpdateMessage:message];
            }
        }];
    }
}

#pragma mark - 视频
- (void)showVideo:(NIMMessage *)message
{
    NIMVideoObject *object = (NIMVideoObject *)message.messageObject;
    NTESVideoViewController *playerViewController = [[NTESVideoViewController alloc] initWithVideoObject:object];
    [self.navigationController pushViewController:playerViewController animated:YES];
    if(![[NSFileManager defaultManager] fileExistsAtPath:object.coverPath]){
        //如果封面图下跪了，点进视频的时候再去下一把封面图
        __weak typeof(self) wself = self;
        [[NIMSDK sharedSDK].resourceManager download:object.coverUrl filepath:object.coverPath progress:nil completion:^(NSError *error) {
            if (!error) {
                [wself uiUpdateMessage:message];
            }
        }];
    }
}

#pragma mark - 地点
- (void)showLocation:(NIMMessage *)message
{
    NIMLocationObject *object = (NIMLocationObject *)message.messageObject;
    NIMKitLocationPoint *locationPoint = [[NIMKitLocationPoint alloc] initWithLocationObject:object];
//    NIMLocationViewController *vc = [[NIMLocationViewController alloc] initWithLocationPoint:locationPoint];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 自定义消息
- (void)showCustom:(NIMMessage *)message
{
    //普通的自定义消息点击事件可以在这里做哦~
    
}

#pragma mark - 重写父类配置方法，原因：群名片上方悬浮header订单
- (void)setupConfigurator
{
    _configurator = [[NHSessionConfigurator alloc] init];
    _configurator.session = self.session;
    [_configurator setup:self];
}


//名片消息发送
- (void)butClick{
    NHCardAttachment *attachment = [[NHCardAttachment alloc]init];
    NIMMessage *message               = [[NIMMessage alloc] init];
    NIMCustomObject *customObject     = [[NIMCustomObject alloc] init];
    customObject.attachment           = attachment;
    message.messageObject             = customObject;
    message.apnsContent = @"发来了一张名片";
    NIMMessageSetting *setting = [[NIMMessageSetting alloc] init];
    setting.apnsEnabled = NO;
    message.setting = setting;
    [self sendMessage:message];
}

//动图消息发送
- (void)but2Click{
    NHMaterialGifAttachment *attachment = [[NHMaterialGifAttachment alloc]init];
    NIMMessage *message               = [[NIMMessage alloc] init];
    NIMCustomObject *customObject     = [[NIMCustomObject alloc] init];
    customObject.attachment           = attachment;
    message.messageObject             = customObject;
    message.apnsContent = @"发来了一张动图";
    NIMMessageSetting *setting = [[NIMMessageSetting alloc] init];
    setting.apnsEnabled = NO;
    message.setting = setting;
    [self sendMessage:message];

}


#pragma mark - 点击了名片弹出名片界面
- (void)serviceCardViewAppearance{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.serviceCardView];
}


#pragma mark 名片点击消失的代理方法
- (void)backViewClick:(NHServiceCardView *)backView{
    [self.serviceCardView removeFromSuperview];
}


#pragma mark - navRightButClick
- (void)navRightButClick{
//    NHChatMessageManageController *vc = [[NHChatMessageManageController alloc]initWithSession:self.session];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:self.session.sessionId];
    UIViewController *vc;
    if (team.type == NIMTeamTypeNormal) {
        vc = [[NHNormalTeamCardViewController alloc] initWithTeam:team session:self.session];
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

//点击了拍照视频照片集合按钮
- (void)but3Click{
    
    self.photoManager.photoMaxNum = 6;
    self.photoManager.videoMaxNum = 6;
    self.photoManager.rowCount = 4;
    HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
    vc.delegate = self;
    vc.manager = self.photoManager;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

//点击发送帖子
- (void)but4Click{
    NHPostMessageAttachment *attachment = [[NHPostMessageAttachment alloc]init];
    NIMMessage *message               = [[NIMMessage alloc] init];
    NIMCustomObject *customObject     = [[NIMCustomObject alloc] init];
    customObject.attachment           = attachment;
    message.messageObject             = customObject;
    NIMMessageSetting *setting = [[NIMMessageSetting alloc] init];
    setting.apnsEnabled = NO;
    message.setting = setting;
    [self sendMessage:message];

}

- (void)but5Click{

    NHLocationAttachment *attachment = [[NHLocationAttachment alloc]init];
    NIMMessage *message               = [[NIMMessage alloc] init];
    NIMCustomObject *customObject     = [[NIMCustomObject alloc] init];
    customObject.attachment           = attachment;
    message.messageObject             = customObject;
    NIMMessageSetting *setting = [[NIMMessageSetting alloc] init];
    setting.apnsEnabled = NO;
    message.setting = setting;
    [self sendMessage:message];

}

#pragma mark - HXPhotoViewControllerDelegate
- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original
{
    
    // 如果是相册选取的视频 要获取视频URL 必须先将视频压缩写入文件,得到的文件路径就是视频的URL 如果是通过相机录制的视频那么 videoURL 这个字段就是视频的URL 可以看需求看要不要压缩
    [videos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
         __weak typeof(self) weakSelf = self;
        // previewPhoto 这个也是视频封面 如果是在相册选择的视频 这个字段有可能没有值,只有当用户通过3DTouch 预览过之后才会有值 而且比 thumbPhoto 清晰  如果视频是通过相机拍摄的视频 那么 previewPhoto 这个字段跟 thumbPhoto 是同一张图片也是比较清晰的
        
        // 如果是通过相机录制的视频 需要通过 model.VideoURL 这个字段来压缩写入文件
        if (model.type == HXPhotoModelMediaTypeCameraVideo) {
            [self compressedVideoWithURL:model.videoURL success:^(NSString *fileName) {
                //构造消息
                NIMVideoObject *videoObject = [[NIMVideoObject alloc] initWithSourcePath:fileName];
                NIMMessage *message         = [[NIMMessage alloc] init];
                message.messageObject       = videoObject;
                
                //构造会话
                NIMSession *session = [NIMSession session:weakSelf.session.sessionId type:NIMSessionTypeTeam];
                
                //                message = [NTESSessionMsgConverter msgWithVideo:fileName];
                
                //发送消息
                [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
            } failure:^{
                // 压缩写入失败
            }];
        }else { // 如果是在相册里面选择的视频就需要用过 model.avAsset 这个字段来压缩写入文件
            [self compressedVideoWithURL:model.avAsset success:^(NSString *fileName) {

                //构造消息
                NIMVideoObject *videoObject = [[NIMVideoObject alloc] initWithSourcePath:fileName];
                NIMMessage *message         = [[NIMMessage alloc] init];
                message.messageObject       = videoObject;
                
                //构造会话
                NIMSession *session = [NIMSession session:weakSelf.session.sessionId type:NIMSessionTypeTeam];
                
                //                message = [NTESSessionMsgConverter msgWithVideo:fileName];
                
                //发送消息
                [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
            } failure:^{
                // 压缩写入失败
            }];
        }
    }];
    
    
    [photos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak typeof(self) weakSelf = self;
        //构造消息
        NIMImageObject * imageObject = [[NIMImageObject alloc] initWithImage:model.thumbPhoto];
        NIMMessage *message          = [[NIMMessage alloc] init];
        message.messageObject        = imageObject;
        
        //构造会话
        NIMSession *session = [NIMSession session:weakSelf.session.sessionId type:NIMSessionTypeTeam];
        
        //发送消息
        [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
        
    }];
}


// 压缩视频并写入沙盒文件
- (void)compressedVideoWithURL:(id)url success:(void(^)(NSString *fileName))success failure:(void(^)())failure
{
    AVURLAsset *avAsset;
    if ([url isKindOfClass:[NSURL class]]) {
        avAsset = [AVURLAsset assetWithURL:url];
    }else if ([url isKindOfClass:[AVAsset class]]) {
        avAsset = (AVURLAsset *)url;
    }
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSString *fileName = @""; // 这里是自己定义的文件路径
        
        NSDate *nowDate = [NSDate date];
        NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[nowDate timeIntervalSince1970]];
        
        NSString *numStr = [NSString stringWithFormat:@"%d",arc4random()%10000];
        fileName = [fileName stringByAppendingString:dateStr];
        fileName = [fileName stringByAppendingString:numStr];
        
        // ````` 这里取的是时间加上一些随机数  保证每次写入文件的路径不一样
        fileName = [fileName stringByAppendingString:@".mp4"]; // 视频后缀
        NSString *fileName1 = [NSTemporaryDirectory() stringByAppendingString:fileName]; //文件名称
        exportSession.outputURL = [NSURL fileURLWithPath:fileName1];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) {
                            success(fileName1);
                        }
                    });
                }
                    break;
                case AVAssetExportSessionStatusExporting:
                    break;
                case AVAssetExportSessionStatusFailed:
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (failure) {
                            failure();
                        }
                    });
                }
                    break;
                case AVAssetExportSessionStatusUnknown:
                    break;
                case AVAssetExportSessionStatusWaiting:
                    break;
                default:
                    break;
            }
        }];
    }
}
@end
