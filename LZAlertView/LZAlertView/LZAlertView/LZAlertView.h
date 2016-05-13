//
//  LZAlertView.h
//  LZAlertView
//
//  Created by 张重 on 16/5/13.
//  Copyright © 2016年 张重. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ButtonClicked)(NSInteger buttonIndex);


static const CGFloat alertWidth = 280;

@interface LZAlertView : UIView

@property (nonatomic,copy) ButtonClicked buttonClicked;

- (id)initWithButtonClicked:(ButtonClicked)buttonClick;

- (void)alertShow;

@end


