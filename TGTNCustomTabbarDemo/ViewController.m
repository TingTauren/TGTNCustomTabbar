//
//  ViewController.m
//  TGTNCustomTabbarDemo
//
//  Created by Mac on 2022/4/7.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:25.0/255.0 blue:31.0/255.0 alpha:1.0];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    if ([self.tabBarItem.badgeValue isEqualToString:@"10"]) {
        self.tabBarItem.badgeValue = @"0";
    } else {
        self.tabBarItem.badgeValue = @"10";
    }
}

@end
