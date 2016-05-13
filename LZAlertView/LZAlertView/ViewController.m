//
//  ViewController.m
//  LZAlertView
//
//  Created by 张重 on 16/5/13.
//  Copyright © 2016年 张重. All rights reserved.
//

#import "ViewController.h"
#import "LZAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LZAlertView *alert = [[LZAlertView alloc]initWithButtonClicked:^(NSInteger buttonIndex) {
        NSLog(@"%ld",buttonIndex);
    }];
    [alert alertShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
