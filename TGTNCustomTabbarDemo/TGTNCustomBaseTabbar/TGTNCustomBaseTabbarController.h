//
//  TGTNCustomBaseTabbarController.h
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGTNCustomBaseTabbarController : UITabBarController

/// 将要加载方法回调
@property (nonatomic, copy) dispatch_block_t viewWillAppearConfig;
/// 中心按钮点击
@property (nonatomic, copy) dispatch_block_t centerButtonConfig;

/// 背景 (图片或颜色)
@property (nonatomic, strong) id backgroundObject;
/// 背景圆角
@property (nonatomic, assign) float backgroundRadius;

/// 是否存在中心按钮
@property (nonatomic, assign) BOOL isCenter;
/// 中心按钮高度
@property (nonatomic, assign) float centerHeight;
/// 中心按钮偏移
@property (nonatomic, assign) UIEdgeInsets centerInset;

/// 字体大小
@property (nonatomic, strong) UIFont *normalFont;
/// 选中字体大小
@property (nonatomic, strong) UIFont *selectFont;
/// 字体颜色
@property (nonatomic, strong) UIColor *normalColor;
/// 选中字体颜色
@property (nonatomic, strong) UIColor *selectColor;

/// tbbar边距
@property (nonatomic, assign) UIEdgeInsets barInset;

/// item边距
@property (nonatomic, assign) UIEdgeInsets itemInset;

/// 是否显示线条
@property (nonatomic, assign) BOOL isShowLine;
/// 线条颜色
@property (nonatomic, strong) UIColor *lineColor;

/// 添加普通item关联
/// @param controller 关联视图
/// @param image 正常图标
/// @param selectedImage 选中图标
/// @param title 标题
/// @param backImage 背景图标
/// @param backSelectImage 背景选中图标
/// @param backSize 背景大小
- (void)tgtnAddChildController:(UIViewController *) controller image:(NSString *) image selectedImage:(NSString *) selectedImage title:(NSString *) title backImage:(UIImage * _Nullable) backImage backSelectImage:(UIImage * _Nullable) backSelectImage backSize:(CGSize) backSize;
/// 添加中心按钮关联
/// @param image 正常图标
/// @param selectedImage 选中图标
/// @param title 标题
- (void)tgtnAddCenterImage:(id) image selectedImage:(id) selectedImage title:(NSString *) title;

@end

#pragma mark ------ 分割线

@interface TGTNCustomBaseTabbarController (TGTNCustomBaseTabbarControllerAdd)

/// 返回自定义Tabbar的Class
- (Class)preferredTabbarClass;

@end

NS_ASSUME_NONNULL_END
