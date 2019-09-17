//
//  JGContactListCell.h
//  JGChat
//
//  Created by JG on 2017/5/12.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGContactListCell : UITableViewCell

//昵称
@property (nonatomic, weak) UILabel *nickLab;

//选中状态图片
@property (nonatomic, weak) UIImageView *selectImage;

@end
