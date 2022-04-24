//
//  TGTNCustomLeftTabbarController.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/24.
//

#import "TGTNCustomLeftTabbarController.h"

#import "TGTNCustomLeftTabbar.h"

@interface TGTNCustomLeftTabbarController ()
@end

@implementation TGTNCustomLeftTabbarController

- (Class)preferredTabbarClass {
    return TGTNCustomLeftTabbar.class;
}

@end
