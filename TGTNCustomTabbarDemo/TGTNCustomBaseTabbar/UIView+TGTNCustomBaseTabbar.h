//
//  UIView+TGTNCustomBaseTabbar.h
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TGTNCustomBaseTabbar)

/// 遍历获取tabbar线条
- (UIImageView *)tgtnTabbarShadowImageView;
/// 遍历获取tabbar背景视图
- (UIView *)tgtnTabbarBackgroundView;

@end

NS_ASSUME_NONNULL_END
