//
//  NHSearchMessageEntraceCell.m
//  NestHouse
//
//  Created by JG on 2017/4/27.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "NHSearchMessageEntraceCell.h"
#import "UIView+NTES.h"
@implementation NHSearchMessageEntraceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor blueColor];
    }
    return self;
}

- (void)refresh:(NHSearchChatHistoryObject *)object{
    self.textLabel.text = object.content;
    [self.textLabel sizeToFit];
}


#define TextLabelLeft 20.f
- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.left    = TextLabelLeft;
    self.textLabel.centerY = self.height * .5f;
}



@end
