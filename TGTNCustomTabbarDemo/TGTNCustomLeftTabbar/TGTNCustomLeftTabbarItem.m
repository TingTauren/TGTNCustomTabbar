//
//  TGTNCustomLeftTabbarItem.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import "TGTNCustomLeftTabbarItem.h"

@interface TGTNCustomLeftTabbarItem()
@end

@implementation TGTNCustomLeftTabbarItem

#pragma mark ------ get

#pragma mark ------ set

#pragma mark ------ init
/// 初始化视图
- (void)tgtnInitUI {
    [super tgtnInitUI];
    
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.numberOfLines = 0;
}
/// 改变视图大小
- (void)tgtnChangeViewFrame {
    float mySelfWidth = self.frame.size.width;
    float mySelfHeight = self.frame.size.height;
    
    if (self.backImageView) {
        float backImageX = (_backSize.width > 0 ? (mySelfWidth - _backSize.width)/2.0 : 0.0);
        float backImageY = (_backSize.height > 0 ? (mySelfHeight - _backSize.height)/2.0 : 0.0);
        self.backImageView.frame = CGRectMake(backImageX, backImageY, (_backSize.width > 0 ? _backSize.width : mySelfWidth), (_backSize.height > 0 ? _backSize.height : mySelfHeight));
    }
    
    float maxTextWidth = mySelfHeight / 2.0 - 2.5;
    float textWidth = maxTextWidth;
    float textHeight = mySelfHeight;
    
    if (self.photoView) {
        float maxImageHeight = mySelfHeight;
        float maxImageWidth = mySelfHeight;
        if (![self.textLabel.text isEqualToString:@""]) {
            [self.textLabel sizeToFit];
            CGSize textSize = self.textLabel.bounds.size;
            textWidth = (textSize.width > maxTextWidth ? maxTextWidth : textSize.width);
            textHeight = textSize.height;
            maxImageWidth = maxImageWidth - textWidth - 2.5;
        }
        
        float imageHeight = maxImageHeight;
        float imageWidth = maxImageWidth;
        
        if (_normalImage) {
            imageHeight = (_normalImage.size.height > imageHeight ? imageHeight : _normalImage.size.height);
            imageWidth = (_normalImage.size.width > imageWidth ? imageWidth : _normalImage.size.width);
        }
        self.photoView.frame = CGRectMake((mySelfWidth - imageWidth - textWidth - 5.0)/2.0, (mySelfHeight - imageHeight)/2.0, imageWidth, imageHeight);
    }

    if (self.textLabel) {
        self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.frame) + 5.0, (mySelfHeight - textHeight)/2.0, textWidth, textHeight);
    }

    if (self.countView) {
        [self.countView sizeToFit];
        CGSize countSize = self.countView.bounds.size;
        float countX = CGRectGetMaxX(self.photoView.frame) - 5.0;
        countX = fmin((mySelfWidth - countSize.width), countX);
        float countY = CGRectGetMinY(self.photoView.frame) + 5.0 - countSize.height;
        countY = fmax(countY, 0.0);
        self.countView.frame = CGRectMake(countX, countY, countSize.width, countSize.height);
    }
}

#pragma mark ------ public


@end
