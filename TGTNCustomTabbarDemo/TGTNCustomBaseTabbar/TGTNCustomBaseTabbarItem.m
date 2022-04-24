//
//  TGTNCustomBaseTabbarItem.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import "TGTNCustomBaseTabbarItem.h"

@interface TGTNCustomBaseTabbarItem()
/// 背景图片
@property (nonatomic, readwrite) UIImageView *backImageView;
/// 图片
@property (nonatomic, readwrite) UIImageView *photoView;
/// 标题
@property (nonatomic, readwrite) UILabel *textLabel;
/// 红点
@property (nonatomic, readwrite) UIButton *countView;
@end

@implementation TGTNCustomBaseTabbarItem

#pragma mark ------ get
- (UIImageView *)backImageView {
    if (_backImageView) return _backImageView;
    _backImageView = [UIImageView new];
    _backImageView.clipsToBounds = YES;
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    return _backImageView;
}
- (UIImageView *)photoView {
    if (_photoView) return _photoView;
    _photoView = [UIImageView new];
    _photoView.clipsToBounds = YES;
    _photoView.contentMode = UIViewContentModeCenter;
    return _photoView;
}
- (UILabel *)textLabel {
    if (_textLabel) return _textLabel;
    _textLabel = [UILabel new];
    [_textLabel setTextColor:_normalColor];
    [_textLabel setFont:[UIFont systemFontOfSize:11.0]];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    return _textLabel;
}
- (UIButton *)countView {
    if (_countView) return _countView;
    _countView = [UIButton new];
    _countView.layer.cornerRadius = 13.5/2.0;
    _countView.layer.masksToBounds = YES;
    _countView.userInteractionEnabled = NO;
    _countView.contentEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
    _countView.backgroundColor = [UIColor redColor];
    [_countView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_countView.titleLabel setFont:[UIFont systemFontOfSize:11.0]];
    [_countView setTitle:@"0" forState:UIControlStateNormal];
    _countView.hidden = YES;
    return _countView;
}

#pragma mark ------ set
- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    if (_textLabel) {
        [_textLabel setFont:_normalFont];
    }
}
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    if (_textLabel) {
        [_textLabel setTextColor:_normalColor];
    }
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (_photoView) {
        _photoView.image = (selected ? _selectImage : _normalImage);
    }
    if (_textLabel) {
        [_textLabel setTextColor:(selected ? _selectColor : _normalColor)];
        [_textLabel setFont:(selected ? _selectFont : _normalFont)];
    }
    
    if (_backImageView) {
        if (_selectBackImage) {
            _backImageView.image = (selected ? _selectBackImage : _normalBackImage);
        }
    }
}

#pragma mark ------ init
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGRectIsEmpty(self.frame)) {
        [self tgtnChangeViewFrame];
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _tgtnInitUI];
    }
    return self;
}
- (void)_tgtnInitUI {
    _normalColor = [UIColor grayColor];
    
    [self tgtnInitUI];
}

#pragma mark ------ public
/// 设置按钮数据
/// @param image 正常显示图标
/// @param selectImg 选中图标
/// @param title 标题
- (void)tgtnSetNormalImage:(UIImage * _Nullable) image selectImage:(UIImage * _Nullable) selectImg title:(NSString *) title {
    _normalImage = image;
    _selectImage = selectImg;
    
    if (_photoView) {
        if (image) {
            [_photoView setImage:image];
        }
    }
    if (_textLabel) {
        [_textLabel setText:title];
    }
}
/// 设置按钮背景数据
/// @param image 默认背景
/// @param selectImg 选中背景
/// @param backSize 背景大小
- (void)tgtnSetNormalBackImage:(UIImage * _Nullable) image selectBackImage:(UIImage * _Nullable) selectImg backSize:(CGSize) backSize {
    if (image) {
        _normalBackImage = image;
    }
    if (selectImg) {
        _selectBackImage = selectImg;
    }
    _backSize = backSize;
    
    if (_backImageView) {
        _backImageView.image = _normalBackImage;
    }
}
/// 设置未读数据
/// @param number 数量
- (void)tgtnSetCountNumber:(NSInteger) number {
    if (_countView) {
        if (number == 0) {
            _countView.hidden = YES;
        } else {
            _countView.hidden = NO;
            [_countView setTitle:@(number > 99 ? 99 : number).stringValue forState:UIControlStateNormal];
            [self layoutSubviews];
        }
    }
}

@end

#pragma mark ------ 分割线

@implementation TGTNCustomBaseTabbarItem (TGTNCustomBaseTabbarItemAdd)

/// 初始化视图
- (void)tgtnInitUI {
    [self addSubview:self.backImageView];
    [self addSubview:self.photoView];
    [self addSubview:self.textLabel];
    [self addSubview:self.countView];
}
/// 改变视图大小
- (void)tgtnChangeViewFrame {
    float mySelfWidth = self.frame.size.width;
    float mySelfHeight = self.frame.size.height;
    
    if (_backImageView) {
        float backImageX = (_backSize.width > 0 ? (mySelfWidth - _backSize.width)/2.0 : 0.0);
        float backImageY = (_backSize.height > 0 ? (mySelfHeight - _backSize.height)/2.0 : 0.0);
        _backImageView.frame = CGRectMake(backImageX, backImageY, (_backSize.width > 0 ? _backSize.width : mySelfWidth), (_backSize.height > 0 ? _backSize.height : mySelfHeight));
    }
    
    if (_photoView) {
        float maxImageHeight = mySelfHeight;
        if (![_textLabel.text isEqualToString:@""]) {
            maxImageHeight = mySelfHeight - 16.5;
        }
        float imageHeight = maxImageHeight;
        float imageWidth = mySelfWidth;
        if (_normalImage) {
            imageHeight = (_normalImage.size.height > imageHeight ? imageHeight : _normalImage.size.height);
            imageWidth = (_normalImage.size.width > imageWidth ? imageWidth : _normalImage.size.width);
        }
        _photoView.frame = CGRectMake((mySelfWidth - imageWidth)/2.0, (maxImageHeight - imageHeight)/2.0, imageWidth, imageHeight);
    }
    
    if (_textLabel) {
        _textLabel.frame = CGRectMake(0.0, CGRectGetMaxY(_photoView.frame) + 3, self.frame.size.width, 13.5);
    }
    
    if (_countView) {
        [_countView sizeToFit];
        CGSize countSize = _countView.bounds.size;
        float countX = CGRectGetMaxX(_photoView.frame) - 5.0;
        countX = fmin((mySelfWidth - countSize.width), countX);
        float countY = CGRectGetMinY(_photoView.frame) + 5.0 - countSize.height;
        countY = fmax(countY, 0.0);
        _countView.frame = CGRectMake(countX, countY, countSize.width, countSize.height);
    }
}

@end
