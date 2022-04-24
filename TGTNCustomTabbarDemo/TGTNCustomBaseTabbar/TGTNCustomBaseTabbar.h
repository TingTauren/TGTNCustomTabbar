//
//  TGTNCustomBaseTabbar.h
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/15.
//

#import <UIKit/UIKit.h>

#import "TGTNCustomBaseTabbarCenter.h"
#import "TGTNCustomBaseTabbarItem.h"

NS_ASSUME_NONNULL_BEGIN

// 是否是iPad
#define TGTNCustomBaseTabbarIsIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断设备型号 (2x宽度 2x高度 宽度 高度)
#define TGTNCustomBaseTabbarCheckDevice(x2W, x2H, W, H) (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(x2W, x2H), [[UIScreen mainScreen] currentMode].size) : CGSizeEqualToSize(CGSizeMake(W, H), [[UIScreen mainScreen] bounds].size)) && !TGTNCustomBaseTabbarIsIpad)

// 判断iPhone X
#define TGTNCustomBaseTabbarIsiPhoneX TGTNCustomBaseTabbarCheckDevice(1125.0, 2436.0, 375.0, 812.0)
// 判断iPHoneXr
#define TGTNCustomBaseTabbarIsiPhoneXR TGTNCustomBaseTabbarCheckDevice(828.0, 1792.0, 414.0, 896.0)
// 判断iPHone 11
#define TGTNCustomBaseTabbarIsiPhone11 TGTNCustomBaseTabbarCheckDevice(750.0, 1624.0, 375.0, 812.0)
// 判断iPHoneXs | 11Pro
#define TGTNCustomBaseTabbarIsiPhoneXS TGTNCustomBaseTabbarCheckDevice(1125.0, 2436.0, 375.0, 812.0)
// 判断iPhoneXs Max | 11ProMax
#define TGTNCustomBaseTabbarIsiPhoneXS_MAX TGTNCustomBaseTabbarCheckDevice(1242.0, 2688.0, 414.0, 896.0)
// 判断iPhone12_Mini
#define TGTNCustomBaseTabbarIsiPhone12_Mini TGTNCustomBaseTabbarCheckDevice(1080.0, 2340.0, 360.0, 780.0)
// 判断iPhone12 | 12Pro
#define TGTNCustomBaseTabbarIsiPhone12 TGTNCustomBaseTabbarCheckDevice(1170.0, 2532.0, 390.0, 844.0)
// 判断iPhone12 Pro Max
#define TGTNCustomBaseTabbarIsiPhone12_ProMax TGTNCustomBaseTabbarCheckDevice(1284.0, 2778.0, 428.0, 926.0)

#define TGTNCustomBaseTabbarIPhoneXAll (TGTNCustomBaseTabbarIsiPhoneX || TGTNCustomBaseTabbarIsiPhoneXR || TGTNCustomBaseTabbarIsiPhone11 || TGTNCustomBaseTabbarIsiPhoneXS || TGTNCustomBaseTabbarIsiPhoneXS_MAX || TGTNCustomBaseTabbarIsiPhone12_Mini || TGTNCustomBaseTabbarIsiPhone12 || TGTNCustomBaseTabbarIsiPhone12_ProMax)
#define TGTNCustomBaseTabbarBottomBarHeight        (49.f)
#define TGTNCustomBaseTabbarLessHeight             (TGTNCustomBaseTabbarIPhoneXAll ? 34.0f : 0.0f)
#define TGTNCustomBaseTabbarLessBottomBarHeight    (TGTNCustomBaseTabbarIPhoneXAll ? (TGTNCustomBaseTabbarBottomBarHeight + TGTNCustomBaseTabbarLessHeight) : TGTNCustomBaseTabbarBottomBarHeight)

#define TGTNCustomTabbarItemMagin 0.0

@interface TGTNCustomBaseTabbar : UITabBar

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

/// 中间按钮点击
@property (nonatomic, copy) dispatch_block_t centeButtonConfig;
/// 按钮点击
@property (nonatomic, copy) void(^ _Nullable itemButtonConfig)(NSInteger index);

/// 选中索引
/// @param index 索引
- (void)tgtnSetSelectIndex:(NSInteger) index;

/// 添加自定义按钮
/// @param image 默认图标
/// @param selectImg 选中图标
/// @param title 标题
/// @param backImage 默认按钮背景
/// @param backSelectImage 选中按钮背景
/// @param backSize 背景大小
- (void)tgtnAddCustomItemNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title backImage:(UIImage * _Nullable) backImage backSelectImage:(UIImage * _Nullable) backSelectImage backSize:(CGSize) backSize;
/// 设置中间按钮数据
/// @param image 正常显示图标
/// @param selectImg 选中图标
/// @param title 标题
- (void)tgtnSetCenterButtonNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title;

@end

#pragma mark ------ 分割线

@interface TGTNCustomBaseTabbar (TGTNCustomBaseTabbarAdd)

/// 返回自定义Tabbar中心按钮的Class
- (Class)preferredTabbarCenterButtClass;
/// 返回自定义Tabbar按钮的Class
- (Class)preferredTabbarItemButtClass;

/// 刷新中心按钮其它数据
- (void)tgtnChangeButtonOtherData:(TGTNCustomBaseTabbarCenter *) centerButton;
/// 刷新按钮其它数据
- (void)tgtnsetItemButtonOtherData:(TGTNCustomBaseTabbarItem *) itemButton;

@end

NS_ASSUME_NONNULL_END
