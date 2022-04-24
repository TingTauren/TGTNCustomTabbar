//
//  UIView+TGTNCustomBaseTabbar.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/21.
//

#import "UIView+TGTNCustomBaseTabbar.h"

@implementation UIView (TGTNCustomBaseTabbar)

/// 遍历获取tabbar线条
- (UIImageView *)tgtnTabbarShadowImageView {
    UIView *subview = [self tgtnTabbarBackgroundView];
    if (!subview) {
        return nil;
    }
    NSArray<__kindof UIView *> *backgroundSubviews = subview.subviews;
    if (backgroundSubviews.count > 1) {
        for (UIView *subview in backgroundSubviews) {
            if (CGRectGetHeight(subview.bounds) <= 1.0 ) {
                return (UIImageView *)subview;
            }
        }
    }
    return nil;
}
/// 遍历获取tabbar背景视图
- (UIView *)tgtnTabbarBackgroundView {
    for (UIImageView *subview in self.subviews) {
        if ([subview _tgtnIsTabBackgroundView]) {
            return (UIImageView *)subview;
        }
    }
    return nil;
}

#pragma mark ------ private
- (BOOL)_tgtnIsTabBackgroundView {
    BOOL isKindOfClass = [self isKindOfClass:[UIView class]];
    BOOL isClass = [self isMemberOfClass:[UIView class]];
    BOOL isKind = isKindOfClass && !isClass;
    if (!isKind) {
        return NO;
    }
    NSString *tabBackgroundViewString = [NSString stringWithFormat:@"%@IB%@", @"_U" , @"arBac"];
    BOOL isTabBackgroundView = [self _tgtnClassStringHasPrefix:tabBackgroundViewString] && [self _tgtnClassStringHasSuffix:@"nd"];
    return isTabBackgroundView;
}
- (BOOL)_tgtnClassStringHasPrefix:(NSString *)prefix {
    NSString *classString = NSStringFromClass([self class]);
    return [classString hasPrefix:prefix];
}
- (BOOL)_tgtnClassStringHasSuffix:(NSString *)suffix {
    NSString *classString = NSStringFromClass([self class]);
    return [classString hasSuffix:suffix];
}

@end
