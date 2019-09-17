# JGChat
网易云信自定义，想干嘛就干嘛，妈妈再也不用担心我的学习了
网易云信的主要类和协议：
> NIMSDK :整个SDK的主入口，单例，主要提供初始化，注册，内部管理类管理的功能。
> NIMLoginManager:登录管理类，负责登录，注销和相应的回调收发
> NIMChatManager: 聊天管理类，负责消息的收发
> NIMConversationManager :会话管理类，负责消息，最近会话的管理
> NIMTeamManager 群组管理类，负责群组各种操作
> NIMMediaManager 媒体管理类，负责多媒体相关的接口，比如录音
> NIMSystemNotificationManager 系统通知管理类，负责系统消息的接收和存储
> NIMApnsManager 推送管理类，负责推送的设置和接收
> NIMResourceManager 资源管理类，负责文件的上传和下载
> NIMUserManager 好友管理类，负责对好友的增删查，以及对其会话的消息设置
> NIMChatroomManager 聊天室管理类，负责聊天室状态管理和数据拉取及设置
> NIMDocTranscodingManager 文档转码管理类，负责文档转码的查询和删除等
> NIMAVChat 主要提供了如下类(协议)与方法
> NIMAVChat 是 NIMSDK 的音视频和实时会话扩展，封装了网络通话、实时会话和网络探测等的管理
> NIMNetCallManager 音视频网络通话管理类，提供音视频网络通话功能
> NIMRTSManager 实时会话管理类，提供数据通道 (TCP/语音通道) 来满足实时会话的需求
> NIMRTSConferenceManager 多人实时会话管理类，提供多人数据通道 (TCP) 来满足多人实时会话的需求
> NIMAVChatNetDetectManager 音视频网络探测管理类，提供音视频网络状态诊断功能
####一般的app接入聊天功能，客户端不需要带有注册功能，app本身几乎都有账号系统，当app登陆时，如果app账号没有注册过网易云信账号，是由后台去拿app账号去网易云信上进行账号注册。所以，网易云信的官方demo太过繁重。

自定义消息

![自定义消息.gif](http://upload-images.jianshu.io/upload_images/2011313-57e63b5e88a58acd.gif?imageMogr2/auto-orient/strip)
自定义消息可以让你的聊天消息多种多样，你可以发送你任何排版任何类型的消息。

3Dtouch功能

![3Dtouch列表弹窗.gif](http://upload-images.jianshu.io/upload_images/2011313-57f13f5fd5541856.gif?imageMogr2/auto-orient/strip)

模仿微信的appIcon重按弹窗，以及最近联系人会话列表页重按弹出页面。
选人聊天图标添加抛物线动画。

相册管理，同时选择多个视频多个图片发送

![相册管理.gif](http://upload-images.jianshu.io/upload_images/2011313-d15f0bffc3c7bfcf.gif?imageMogr2/auto-orient/strip)

##视频播放，图片预览（用的网易云信官方demo的）

![视频播放图片浏览.gif](http://upload-images.jianshu.io/upload_images/2011313-4e74d998f3c84f10.gif?imageMogr2/auto-orient/strip)

群管理（搜索本地聊天和群管理）
![群管理.gif](http://upload-images.jianshu.io/upload_images/2011313-2a0e55566a551755.gif?imageMogr2/auto-orient/strip)

相机相册合并（短按拍照，长按拍视频，类似微信）

![相机相册合并.gif](http://upload-images.jianshu.io/upload_images/2011313-e711b81df362c95f.gif?imageMogr2/auto-orient/strip)


##最后甩上[git地址](https://github.com/huangjianguohjg/JGChat)，老司机们，快上车吧，可以的话帮忙点个star。
