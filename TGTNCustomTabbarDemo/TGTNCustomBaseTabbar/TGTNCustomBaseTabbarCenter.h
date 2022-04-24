//
//  TGTNCustomBaseTabbarCenter.h
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNCustomBaseTabbarCenter : UIButton

/// 图片
@property (nonatomic, readonly) UIImageView *photoView;
/// 标题
@property (nonatomic, readonly) UILabel *textLabel;

/// 字体大小
@property (nonatomic, strong) UIFont *normalFont;
/// 选中字体大小
@property (nonatomic, strong) UIFont *selectFont;
/// 字体颜色
@property (nonatomic, strong) UIColor *normalColor;
/// 选中字体颜色
@property (nonatomic, strong) UIColor *selectColor;

/// 初始化视图
- (void)tgtnInitUI;

/// 设置按钮数据
/// @param image 正常显示图标
/// @param selectImg 选中图标
/// @param title 标题
- (void)tgtnSetNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title;

@end

NS_ASSUME_NONNULL_END
