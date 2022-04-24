//
//  AppDelegate.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/7.
//

#import "AppDelegate.h"

#import "TGTNCustomBaseTabbarController.h"
#import "TGTNCustomLeftTabbarController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TGTNCustomLeftTabbarController *tabbarController = [TGTNCustomLeftTabbarController new];
    // 背景 (图片或颜色)
    tabbarController.backgroundObject = [[UIColor whiteColor] colorWithAlphaComponent:0.05];
    // 背景圆角
    tabbarController.backgroundRadius = 0.0;
    // 是否存在中心按钮
    tabbarController.isCenter = YES;
    // 中心按钮高度
    tabbarController.centerHeight = 0.0;
    // 中心按钮偏移（底部有效）
    tabbarController.centerInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    // 字体大小
    tabbarController.normalFont = [UIFont systemFontOfSize:11.0];
    // 选中字体大小
    tabbarController.selectFont = [UIFont systemFontOfSize:11.0];
    // 字体颜色
    tabbarController.normalColor = [UIColor whiteColor];
    // 选中字体颜色
    tabbarController.selectColor = [UIColor whiteColor];
    // tbbar边距
    tabbarController.barInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);

    // item边距
    tabbarController.itemInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    // 是否显示线条
    tabbarController.isShowLine = NO;
    // 线条颜色
    tabbarController.lineColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    tabbarController.centerButtonConfig = ^{
        [(TGTNCustomBaseTabbarController *)self.window.rootViewController.childViewControllers.firstObject presentViewController:[ViewController new] animated:YES completion:nil];
    };
    
    UIImage *backImage = [UIImage imageNamed:@"TGTNBarXuanZhongBack"];
    CGSize backImageSize = CGSizeMake(50.0, 49.0);
    
    ViewController *one = [ViewController new];
    [tabbarController tgtnAddChildController:one image:@"TGTNBarShouYeN" selectedImage:@"TGTNBarShouYeS" title:@"11111" backImage:nil backSelectImage:backImage backSize:backImageSize];
    
    ViewController *two = [ViewController new];
    [tabbarController tgtnAddChildController:two image:@"TGTNBarFaXianN" selectedImage:@"TGTNBarFaXianS" title:@"22222" backImage:nil backSelectImage:backImage backSize:backImageSize];
    
    ViewController *three = [ViewController new];
    [tabbarController tgtnAddChildController:three image:@"TGTNBarXiaoXiN" selectedImage:@"TGTNBarXiaoXiS" title:@"33333" backImage:nil backSelectImage:backImage backSize:backImageSize];
    
    ViewController *four = [ViewController new];
    [tabbarController tgtnAddChildController:four image:@"TGTNBarWoDeN" selectedImage:@"TGTNBarWoDeS" title:@"44444" backImage:nil backSelectImage:backImage backSize:backImageSize];
    
    UIImage *centerImage = [UIImage imageNamed:@"TGTNBarCenterJia"];
    [tabbarController tgtnAddCenterImage:centerImage selectedImage:centerImage title:@""];
    
    self.window.rootViewController = tabbarController;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        one.tabBarItem.badgeValue = @"10";
    });
    
    return YES;
}


@end
