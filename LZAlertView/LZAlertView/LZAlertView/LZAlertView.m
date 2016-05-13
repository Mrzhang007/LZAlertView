//
//  LZAlertView.m
//  LZAlertView
//
//  Created by 张重 on 16/5/13.
//  Copyright © 2016年 张重. All rights reserved.
//

#import "LZAlertView.h"
#import "UIView+SDAutoLayout.h"

#define K_screen_width [UIScreen mainScreen].bounds.size.width
#define K_screnn_height  [UIScreen mainScreen].bounds.size.height

@interface LZAlertView()

@property (nonatomic,strong) UIView *coverView;//中间层view 有透明度 就是一个透明层
@property (nonatomic,strong) UIView *alertView;//自定义弹出的试图，也就是要动画的图层

@end


@implementation LZAlertView

- (id)initWithButtonClicked:(ButtonClicked)buttonClick{
    
    self.buttonClicked = buttonClick;
    
    //创建alertView
    self  = [self init];
    self.frame = CGRectMake((K_screen_width-alertWidth)/2, K_screnn_height/4, alertWidth, K_screnn_height/2);
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel new];
//    titleLabel.backgroundColor  = [UIColor lightGrayColor];
    titleLabel.text = @"你的标题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(self,20).topSpaceToView(self,10).rightSpaceToView(self,20).heightIs(30);
    
    //主要内容
    UILabel *contentLabel = [UILabel new];
//    contentLabel.backgroundColor  = [UIColor yellowColor];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.text = @"1.李克强表示，中摩建交58年来,始终坚持相互尊重、平等相待。\n2.昨天，习近平主席同国王陛下举行了富有成果的会谈。中方愿同摩方不断深化政治互信，\n3.拓展务实合作，使两国关系发展更好惠及双方人民。";
    contentLabel.numberOfLines = 0;
    
    
    NSString *text = contentLabel.text;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];//设置行距 2
    [paragraphStyle setFirstLineHeadIndent:20];//首行缩进
    [paragraphStyle setParagraphSpacing:5];//段落距离
    UIColor *color = [UIColor blackColor];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    contentLabel.attributedText = string;
    contentLabel.isAttributedContent = YES;
    
    
    [self addSubview:contentLabel];
    
    contentLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(titleLabel,20).rightEqualToView(titleLabel).autoHeightRatio(0);
    
    
    NSArray *otherButtonTitles = @[@"取消",@"确定"];
    
    UIButton *btn;
    
    for (int i = 0 ; i < otherButtonTitles.count; i ++) {
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherButton.backgroundColor = [UIColor purpleColor];
        //            TpColor(251, 251, 251);
        [otherButton setTitle:otherButtonTitles[i] forState:UIControlStateNormal];
        otherButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        otherButton.tag = i;
        [otherButton addTarget:self action:@selector(otherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [otherButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:otherButton];
        
        otherButton.sd_layout.leftSpaceToView(self,i*alertWidth/otherButtonTitles.count).topSpaceToView(contentLabel,20).heightIs(44).widthIs(alertWidth/otherButtonTitles.count);
        
        btn = otherButton;
        if (i == 0) {

  
        }else{
            [otherButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
    [self setupAutoHeightWithBottomView:btn bottomMargin:0];
    
    //中间层view
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_screen_width, K_screnn_height)];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.0;//透明
    self.coverView = coverView;
    //给中间层加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
    tap.numberOfTapsRequired = 1;
    [self.coverView addGestureRecognizer:tap];
    
//    [self alertShow];
    
    return self;
}

- (void)otherButtonClick:(UIButton *)btn{
    
    [self removeView];
    
    if (_buttonClicked) {
        _buttonClicked(btn.tag);
    }
}

- (void)alertShow{
    UIView *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    [window insertSubview:self.coverView belowSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.coverView.alpha = 0.4;
    } completion:^(BOOL finished) {
        
    }];
    
    CGFloat duration = 0.3;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:@"bouce"];
}

- (void)removeView{
    [UIView animateWithDuration:0.3f animations:^{
        self.coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self  removeFromSuperview];
    }];
    
    CGFloat duration = 0.3;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.4, 0.4);
    } completion:^(BOOL finished) {
        //        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}


@end
