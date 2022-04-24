//
//  TGTNCustomBaseTabbarCenter.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import "TGTNCustomBaseTabbarCenter.h"

@interface TGTNCustomBaseTabbarCenter()
/// 图片
@property (nonatomic, readwrite) UIImageView *photoView;
/// 标题
@property (nonatomic, readwrite) UILabel *textLabel;
@end

@implementation TGTNCustomBaseTabbarCenter

#pragma mark ------ get
- (UIImageView *)photoView {
    if (_photoView) return _photoView;
    _photoView = [UIImageView new];
    _photoView.clipsToBounds = YES;
    _photoView.contentMode = UIViewContentModeCenter;
    return _photoView;
}
- (UILabel *)textLabel {
    if (_textLabel) return _textLabel;
    _textLabel = [[UILabel alloc] init];
    [_textLabel setTextColor:_normalColor];
    [_textLabel setFont:[UIFont systemFontOfSize:11.0]];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    return _textLabel;
}

#pragma mark ------ set
- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    [_textLabel setFont:_normalFont];
}
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [_textLabel setTextColor:_normalColor];
}

#pragma mark ------ init
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGRectIsEmpty(self.frame)) {
        float imageHeight = self.frame.size.height;
        if (![_textLabel.text isEqualToString:@""]) {
            imageHeight = self.frame.size.height - 16.5;
        }
        float imageWidth = self.frame.size.width;
        
        _photoView.frame = CGRectMake(0.0, 0.0, imageWidth, imageHeight);
        
        _textLabel.frame = CGRectMake(0.0, CGRectGetMaxY(_photoView.frame) + 3, self.frame.size.width, 13.5);
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self tgtnInitUI];
    }
    return self;
}
- (void)tgtnInitUI {
    _normalColor = [UIColor grayColor];
    
    [self addSubview:self.photoView];
    [self addSubview:self.textLabel];
    
    // 处理按钮点击事件
    [self addTarget:self action:@selector(touchDownMethod)forControlEvents: UIControlEventTouchDown];
    // 处理按钮松开状态
    [self addTarget:self action:@selector(touchUpMethod)forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
}

#pragma mark ------ click
/// 按下方法
- (void)touchDownMethod {
    [_textLabel setFont:_selectFont];
    [_textLabel setTextColor:_selectColor ? _selectColor : _normalColor];
}
/// 抬起方法
- (void)touchUpMethod {
    [_textLabel setFont:_normalFont];
    [_textLabel setTextColor:_normalColor];
}

#pragma mark ------ public
/// 设置按钮数据
/// @param image 正常显示图标
/// @param selectImg 选中图标
/// @param title 标题
- (void)tgtnSetNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title {
    if (image) {
        [_photoView setImage:image];
    }
    [_textLabel setText:title];
}

@end
