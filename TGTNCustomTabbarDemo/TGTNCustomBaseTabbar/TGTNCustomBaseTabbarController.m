//
//  TGTNCustomBaseTabbarController.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/15.
//

#import "TGTNCustomBaseTabbarController.h"
#import "TGTNCustomBaseTabbar.h"

#import "UIView+TGTNCustomBaseTabbar.h"

@interface TGTNCustomBaseTabbarController ()
/// 自定义tabbar
@property (nonatomic, strong) TGTNCustomBaseTabbar *baseTabbar;
@end

@implementation TGTNCustomBaseTabbarController

#pragma mark ------ get
- (TGTNCustomBaseTabbar *)baseTabbar {
    if (_baseTabbar) return _baseTabbar;
    _baseTabbar = [[self preferredTabbarClass] new];
    return _baseTabbar;
}

#pragma mark ------ set
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    [self.baseTabbar tgtnSetSelectIndex:selectedIndex];
}
- (void)setBackgroundRadius:(float)backgroundRadius {
    _backgroundRadius = backgroundRadius;
    self.baseTabbar.backgroundRadius = _backgroundRadius;
}
- (void)setBackgroundObject:(id)backgroundObject {
    _backgroundObject = backgroundObject;
    self.baseTabbar.backgroundObject = _backgroundObject;
}
- (void)setIsCenter:(BOOL)isCenter {
    _isCenter = isCenter;
    self.baseTabbar.isCenter = _isCenter;
}
- (void)setCenterHeight:(float)centerHeight {
    _centerHeight = centerHeight;
    self.baseTabbar.centerHeight = _centerHeight;
}
- (void)setCenterInset:(UIEdgeInsets)centerInset {
    _centerInset = centerInset;
    self.baseTabbar.centerInset = _centerInset;
}
- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    self.baseTabbar.normalFont = _normalFont;
}
- (void)setSelectFont:(UIFont *)selectFont {
    _selectFont = selectFont;
    self.baseTabbar.selectFont = _selectFont;
}
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.baseTabbar.normalColor = _normalColor;
}
- (void)setBarInset:(UIEdgeInsets)barInset {
    _barInset = barInset;
    self.baseTabbar.barInset = _barInset;
}

- (void)setItemInset:(UIEdgeInsets)itemInset {
    _itemInset = itemInset;
    self.baseTabbar.itemInset = _itemInset;
}
- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    self.baseTabbar.selectColor = _selectColor;
}
- (void)setIsShowLine:(BOOL)isShowLine {
    _isShowLine = isShowLine;
    self.baseTabbar.isShowLine = _isShowLine;
}
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.baseTabbar.lineColor = _lineColor;
}

#pragma mark ------ init
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_viewWillAppearConfig) {
        _viewWillAppearConfig();
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [self _tgtnHideTabBarShadowImageView];
    }
    [self _tgtnHiddenBarBackground];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setValue:self.baseTabbar forKey:@"tabBar"];
    
    __weak typeof(self) weakSelf = self;
    _baseTabbar.centeButtonConfig = ^{
        __strong typeof(weakSelf) self = weakSelf;
        if (self.centerButtonConfig) {
            self.centerButtonConfig();
        }
    };
    _baseTabbar.itemButtonConfig = ^(NSInteger index) {
        __strong typeof(weakSelf) self = weakSelf;
        self.selectedIndex = index;
    };
}
// 让状态跟随子视图变化
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

#pragma mark ------ Private Function
/// 将颜色转换为图片
/// @param color 颜色
- (UIImage *)_tgtnCreateImageWithColor:(UIColor *) color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *fceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return fceImage;
}

#pragma mark ------ Private
/// 隐藏tabbar系统阴影图片
- (void)_tgtnHideTabBarShadowImageView {
    [self.tabBar layoutIfNeeded];
    
    UIImageView *imageView = [self.tabBar tgtnTabbarShadowImageView];
    imageView.hidden = YES; // iOS13+
    imageView.alpha = 0;
}
/// 隐藏tabbar系统背景
- (void)_tgtnHiddenBarBackground {
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:@"_UIBarBackground"] || [NSStringFromClass([obj class]) isEqualToString:@"_UITabBarBackgroundView"]) {
            obj.hidden = YES;
        }
    }];
}
/// 设置系统线条颜色
- (void)_tgtnSetSystemTabbarLineColor {
    if (@available(iOS 13.0, *)) {
    } else {
        [self.tabBar setBackgroundImage:[UIImage new]];
        
        if (self.baseTabbar.isShowLine) {
            [self.tabBar setShadowImage:[self _tgtnCreateImageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.0]]];
        } else {
            [self.tabBar setShadowImage:[self _tgtnCreateImageWithColor:_lineColor]];
        }
    }
}

#pragma mark ------ Public
/// 添加普通item关联
/// @param controller 关联视图
/// @param image 正常图标
/// @param selectedImage 选中图标
/// @param title 标题
/// @param backImage 背景图标
/// @param backSelectImage 背景选中图标
/// @param backSize 背景大小
- (void)tgtnAddChildController:(UIViewController *) controller image:(NSString *) image selectedImage:(NSString *) selectedImage title:(NSString *) title backImage:(UIImage * _Nullable) backImage backSelectImage:(UIImage * _Nullable) backSelectImage backSize:(CGSize) backSize {
    UIImage *myImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mySelectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:controller];
    
    // 添加自定义按钮
    [self.baseTabbar tgtnAddCustomItemNormalImage:myImage selectImage:mySelectedImage title:title backImage:backImage backSelectImage:backSelectImage backSize:backSize];
}
/// 添加中心按钮关联
/// @param image 正常图标
/// @param selectedImage 选中图标
/// @param title 标题
- (void)tgtnAddCenterImage:(id) image selectedImage:(id) selectedImage title:(NSString *) title {
    // 设置系统线条颜色
    [self _tgtnSetSystemTabbarLineColor];
    
    // 添加中心按钮
    UIImage *normalImage = [([image isKindOfClass:[NSString class]] ? [UIImage imageNamed:image] : (UIImage *)image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [([selectedImage isKindOfClass:[NSString class]] ? [UIImage imageNamed:selectedImage] : (UIImage *)selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.baseTabbar tgtnSetCenterButtonNormalImage:normalImage selectImage:selectImage title:title];
}

@end

#pragma mark ------ 分割线

@implementation TGTNCustomBaseTabbarController (TGTNCustomBaseTabbarControllerAdd)

/// 返回自定义Tabbar的Class
- (Class)preferredTabbarClass {
    return TGTNCustomBaseTabbar.class;
}

@end
