//
//  TGTNCustomLeftTabbar.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import "TGTNCustomLeftTabbar.h"

@implementation TGTNCustomLeftTabbar

/// 返回自定义Tabbar按钮的Class
- (Class)preferredTabbarItemButtClass {
    return TGTNCustomLeftTabbarItem.class;
}

/// 刷新中心按钮其它数据
- (void)tgtnChangeButtonOtherData:(TGTNCustomBaseTabbarCenter *) centerButton {
    
}
/// 刷新按钮其它数据
- (void)tgtnsetItemButtonOtherData:(TGTNCustomBaseTabbarItem *) itemButton {
    
}

@end
