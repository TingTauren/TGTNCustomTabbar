//
//  TGTNCustomBaseTabbar.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/15.
//

#import "TGTNCustomBaseTabbar.h"

@interface TGTNCustomBaseTabbar() {
    /// 默认选中位置
    NSInteger _defaultSelectIndex;
}
/// 是否第一次刷新视图
@property (nonatomic, assign) BOOL isFirstLayout;

/// 图片背景
@property (nonatomic, strong) UIImageView *backImageView;
/// 线条
@property (nonatomic, strong) UIView *lineView;

/// 自定义item
@property (nonatomic, strong) NSMutableArray *customItems;
/// 中间按钮
@property (nonatomic, strong) TGTNCustomBaseTabbarCenter *centerButton;
@end

@implementation TGTNCustomBaseTabbar

#pragma mark ------ get
- (UIImageView *)backImageView {
    if (_backImageView) return _backImageView;
    _backImageView = [UIImageView new];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    if ([_backgroundObject isKindOfClass:[UIImage class]]) {
        _backImageView.image = _backgroundObject;
    } else {
        _backImageView.backgroundColor = _backgroundObject;
    }
    _backImageView.userInteractionEnabled = YES;
    return _backImageView;
}
- (UIView *)lineView {
    if (_lineView) return _lineView;
    _lineView = [UIView new];
    _lineView.hidden = _isShowLine;
    _lineView.backgroundColor = _lineColor;
    return _lineView;
}
- (TGTNCustomBaseTabbarCenter *)centerButton {
    if (_centerButton) return _centerButton;
    _centerButton = [[self preferredTabbarCenterButtClass] new];
    _centerButton.hidden = !_isCenter;
    [_centerButton addTarget:self action:@selector(centerButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return _centerButton;
}
- (NSMutableArray *)customItems {
    if (_customItems) return _customItems;
    _customItems = [NSMutableArray new];
    return _customItems;
}

#pragma mark ------ set
- (void)setBackgroundRadius:(float)backgroundRadius {
    _backgroundRadius = backgroundRadius;
    
    if (_backgroundRadius > 0.0) {
        _backImageView.layer.cornerRadius = _backgroundRadius;
        _backImageView.layer.masksToBounds = YES;
    } else {
        _backImageView.layer.cornerRadius = _backgroundRadius;
        _backImageView.layer.masksToBounds = NO;
    }
}
- (void)setBackgroundObject:(id)backgroundObject {
    _backgroundObject = backgroundObject;
    if ([_backgroundObject isKindOfClass:[UIImage class]]) {
        _backImageView.image = _backgroundObject;
    } else {
        _backImageView.backgroundColor = _backgroundObject;
    }
}
- (void)setIsCenter:(BOOL)isCenter {
    _isCenter = isCenter;
    _centerButton.hidden = !_isCenter;
}
- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    // 改变按钮数据
    [self _tgtnChangeButtonData];
}
- (void)setSelectFont:(UIFont *)selectFont {
    _selectFont = selectFont;
    // 改变按钮数据
    [self _tgtnChangeButtonData];
}
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    // 改变按钮数据
    [self _tgtnChangeButtonData];
}
- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    // 改变按钮数据
    [self _tgtnChangeButtonData];
}
- (void)setIsShowLine:(BOOL)isShowLine {
    _isShowLine = isShowLine;
    _lineView.hidden = !_isShowLine;
}
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _lineView.backgroundColor = _lineColor;
}

#pragma mark ------ init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect backImageFrame = CGRectMake(_barInset.left, _barInset.top, CGRectGetWidth(self.bounds) - _barInset.left - _barInset.right, CGRectGetHeight(self.bounds) - _barInset.top - _barInset.bottom);
    if (!CGRectIsEmpty(self.frame) && _isFirstLayout) {
        _isFirstLayout = NO;
        
        // 改变视图大小
        [self _tgtnChangeViewFrame:backImageFrame];
        
        Class class = NSClassFromString(@"UITabBarButton");
        
        for (UIView *btn in self.subviews) { // 遍历tabbar的子控件
            if ([btn isKindOfClass:class]) {
                btn.hidden = YES;
            }
        }
        
        // 监听角标改变
        for (UITabBarItem *barItem in self.items) {
            [barItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
        
    } else {
        if (!CGRectEqualToRect(backImageFrame, _backImageView.frame)) {
            
            // 改变视图大小
            [self _tgtnChangeViewFrame:backImageFrame];
        }
    }
}
/// 初始化视图
- (void)_tgtnInitView {
    _isFirstLayout = YES;
    
    // 背景 (图片或颜色)
    _backgroundObject = [UIColor whiteColor];
    
    // 是否存在中心按钮
    _isCenter = NO;
    // 中心按钮高度
    _centerHeight = 0.0;
    // 中心按钮偏移
    _centerInset = UIEdgeInsetsZero;

    // 字体大小
    _normalFont = [UIFont systemFontOfSize:11.0];
    // 选中字体大小
    _selectFont = [UIFont systemFontOfSize:11.0];
    // 字体颜色
    _normalColor = [UIColor blackColor];
    // 选中字体颜色
    _selectColor = [UIColor redColor];

    // tbbar边距
    _barInset = UIEdgeInsetsZero;

    // item边距
    _itemInset = UIEdgeInsetsZero;
    
    // 是否显示线条
    _isShowLine = NO;
    // 线条颜色
    _lineColor = [UIColor cyanColor];
    
    [self addSubview:self.backImageView];
    [_backImageView addSubview:self.centerButton];
    [_backImageView addSubview:self.lineView];
}
// 重写hitTest方法，去监听中心按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint centerView = [self convertPoint:point toView:_centerButton];
        if (_isCenter && [_centerButton pointInside:centerView withEvent:event]) {
            return _centerButton;
        }
        return [super hitTest:point withEvent:event];
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark ------ KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"badgeValue"]) {
        NSInteger selectIndex = [self.items indexOfObject:object];
        // change : <kind new old>
        NSString *newContent = change[@"new"];
        
        TGTNCustomBaseTabbarItem *item = [_customItems objectAtIndex:selectIndex];
        [item tgtnSetCountNumber:[newContent integerValue]];
    }
}

#pragma mark ------ Click
- (void)centerButtonDidClick:(TGTNCustomBaseTabbarCenter *) button {
    if (_centeButtonConfig) {
        _centeButtonConfig();
    }
}
/// 自定义item点击
/// @param button 点击
- (void)customItemClick:(UIButton *) button {
    if (_itemButtonConfig) {
        _itemButtonConfig(button.tag - 1000);
    }
}

#pragma mark ------ Private
/// 改变视图大小
- (void)_tgtnChangeViewFrame:(CGRect) frame {
    float buttonWidth = (CGRectGetWidth(frame) - _itemInset.left - _itemInset.right) / [self _tgtnButtonCount];
    
    Class class = NSClassFromString(@"UITabBarButton");
    
    int btnIndex = 0;
    CGRect centerButtonRect = CGRectZero;
    for (UIView *btn in self.subviews) { // 遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {
            btn.hidden = YES;
            // 如果是系统的UITabBarButton, 那么就调整子控件位置, 空出中间位置
            CGRect btnRect = btn.frame;
            
            btnIndex = ((int)(btnRect.origin.x / btnRect.size.width));
            btnRect.size.width = buttonWidth;
            
            // 空出中心按钮的位置
            if (btnIndex >= self.items.count/2 && _isCenter) {
                // 记录空出中心位置大小,后面计算中间按钮摆放位置
                if (CGRectIsEmpty(centerButtonRect)) {
                    centerButtonRect = CGRectMake(btnRect.size.width * btnIndex, btnRect.origin.y, btnRect.size.width, btnRect.size.height);
                    centerButtonRect.origin.x = centerButtonRect.origin.x + _itemInset.left;
                }
                btnRect.origin.x = btnRect.size.width * (btnIndex + 1);
            } else {
                btnRect.origin.x = btnRect.size.width * btnIndex;
            }
            btnRect.origin.x = btnRect.origin.x + _itemInset.left;
            
            if (self.customItems.count > 0) {
                TGTNCustomBaseTabbarItem *customItem = [self.customItems objectAtIndex:btnIndex];
                customItem.frame = btnRect;
            }
        }
    }
    
    if (_isCenter) {
        CGRect centerFrame = _centerButton.frame;
        float centerButtonHeight = (_centerHeight > 0) ? (_centerHeight + 2 * TGTNCustomTabbarItemMagin) : ((CGRectGetHeight(frame) - TGTNCustomBaseTabbarLessHeight) + 2 * TGTNCustomTabbarItemMagin);
        centerFrame.size = CGSizeMake(buttonWidth, centerButtonHeight);
        _centerButton.frame = centerFrame;
        // self.center.x
        float centerX = centerButtonRect.origin.x + centerButtonRect.size.width/2.0;
        _centerButton.center = CGPointMake(centerX, centerButtonHeight/2.0 - TGTNCustomTabbarItemMagin - _centerInset.bottom);
        _centerButton.layer.masksToBounds = YES;
    }
    
    [_backImageView bringSubviewToFront:_centerButton];
    
    _backImageView.frame = frame;
    _lineView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 1.0);
}
/// 获取按钮数量
- (NSInteger)_tgtnButtonCount {
    NSInteger count = (_isCenter ? 1 : 0);
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.subviews) { // 遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {
            count++;
        }
    }
    return count;
}
/// 改变按钮数据
- (void)_tgtnChangeButtonData {
    if (_isCenter) {
        if (_normalFont) {
            _centerButton.normalFont = _normalFont;
        }
        if (_selectFont) {
            _centerButton.selectFont = _selectFont;
        }
        if (_normalColor) {
            _centerButton.normalColor = _normalColor;
        }
        if (_selectColor) {
            _centerButton.selectColor = _selectColor;
        }
        
        // 刷新中心按钮其它数据
        [self tgtnChangeButtonOtherData:_centerButton];
    }
}

#pragma mark ------ Public
/// 选中索引
/// @param index 索引
- (void)tgtnSetSelectIndex:(NSInteger) index {
    if (index == _defaultSelectIndex) {
        return;
    }
    TGTNCustomBaseTabbarItem *oldCustomItem = [_customItems objectAtIndex:_defaultSelectIndex];
    oldCustomItem.selected = NO;
    
    TGTNCustomBaseTabbarItem *customItem = [_customItems objectAtIndex:index];
    customItem.selected = YES;
    
    _defaultSelectIndex = index;
}
/// 添加自定义按钮
/// @param image 默认图标
/// @param selectImg 选中图标
/// @param title 标题
/// @param backImage 默认按钮背景
/// @param backSelectImage 选中按钮背景
/// @param backSize 背景大小
- (void)tgtnAddCustomItemNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title backImage:(UIImage * _Nullable) backImage backSelectImage:(UIImage * _Nullable) backSelectImage backSize:(CGSize) backSize; {
    NSInteger tag = self.customItems.count;
    TGTNCustomBaseTabbarItem *customItem = [[self preferredTabbarItemButtClass] new];
    customItem.tag = tag + 1000;
    [customItem tgtnSetNormalImage:image selectImage:selectImg title:title];
    [customItem tgtnSetNormalBackImage:backImage selectBackImage:backSelectImage backSize:backSize];
    if (_normalFont) {
        customItem.normalFont = _normalFont;
    }
    if (_selectFont) {
        customItem.selectFont = _selectFont;
    }
    if (_normalColor) {
        customItem.normalColor = _normalColor;
    }
    if (_selectColor) {
        customItem.selectColor = _selectColor;
    }
    // 修改按钮其它属性
    [self tgtnsetItemButtonOtherData:customItem];
    if (tag == _defaultSelectIndex) {
        customItem.selected = YES;
    }
    [customItem addTarget:self action:@selector(customItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customItems addObject:customItem];
    [_backImageView addSubview:customItem];
}
/// 设置中间按钮数据
/// @param image 正常显示图标
/// @param selectImg 选中图标
/// @param title 标题
- (void)tgtnSetCenterButtonNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title {
    [_centerButton tgtnSetNormalImage:image selectImage:image title:title];
}

@end

#pragma mark ------ 分割线

@implementation TGTNCustomBaseTabbar (TGTNCustomBaseTabbarAdd)

/// 返回自定义Tabbar中心按钮的Class
- (Class)preferredTabbarCenterButtClass {
    return TGTNCustomBaseTabbarCenter.class;
}
/// 返回自定义Tabbar按钮的Class
- (Class)preferredTabbarItemButtClass {
    return TGTNCustomBaseTabbarItem.class;
}

/// 刷新中心按钮其它数据
- (void)tgtnChangeButtonOtherData:(TGTNCustomBaseTabbarCenter *) centerButton {
}
/// 刷新按钮其它数据
- (void)tgtnsetItemButtonOtherData:(TGTNCustomBaseTabbarItem *) itemButton {
}

@end
