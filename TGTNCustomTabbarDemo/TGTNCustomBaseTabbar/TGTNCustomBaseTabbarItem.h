//
//  TGTNCustomBaseTabbarItem.h
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNCustomBaseTabbarItem : UIButton  {
    /// 正常图标
    UIImage *_normalImage;
    /// 选中图标
    UIImage *_selectImage;
    /// 默认背景
    UIImage *_normalBackImage;
    /// 选中背景
    UIImage *_selectBackImage;
    /// 背景大小
    CGSize _backSize;
}

/// 字体大小
@property (nonatomic, strong) UIFont *normalFont;
/// 选中字体大小
@property (nonatomic, strong) UIFont *selectFont;
/// 字体颜色
@property (nonatomic, strong) UIColor *normalColor;
/// 选中字体颜色
@property (nonatomic, strong) UIColor *selectColor;

/// 背景图片
@property (nonatomic, readonly) UIImageView *backImageView;
/// 图片
@property (nonatomic, readonly) UIImageView *photoView;
/// 标题
@property (nonatomic, readonly) UILabel *textLabel;
/// 红点
@property (nonatomic, readonly) UIButton *countView;

/// 设置按钮数据
/// @param image 正常显示图标
/// @param selectImg 选中图标
/// @param title 标题
- (void)tgtnSetNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title;
/// 设置按钮背景数据
/// @param image 默认背景
/// @param selectImg 选中背景
/// @param backSize 背景大小
- (void)tgtnSetNormalBackImage:(UIImage * _Nullable) image selectBackImage:(UIImage * _Nullable) selectImg backSize:(CGSize) backSize;
/// 设置未读数据
/// @param number 数量
- (void)tgtnSetCountNumber:(NSInteger) number;

@end

#pragma mark ------ 分割线

@interface TGTNCustomBaseTabbarItem (TGTNCustomBaseTabbarItemAdd)

/// 初始化视图
- (void)tgtnInitUI;
/// 改变视图大小
- (void)tgtnChangeViewFrame;

@end

NS_ASSUME_NONNULL_END
